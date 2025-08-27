from django.shortcuts import render
from account.models import Customer, Worker
import hashlib

class MultiRoleSessionMiddleware:
    """
    Middleware to support multiple role-based sessions simultaneously
    """
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        # Add session helper methods to request
        request.get_role_session = lambda role: self.get_role_session(request, role)
        request.set_role_session = lambda role, user_id, user_type: self.set_role_session(request, role, user_id, user_type)
        request.clear_role_session = lambda role: self.clear_role_session(request, role)
        request.get_current_user = lambda: self.get_current_user(request)
        
        response = self.get_response(request)
        return response

    def get_session_key(self, role):
        """Generate unique session keys for different roles"""
        return f"user_session_{role}"

    def get_role_session(self, request, role):
        """Get session data for a specific role"""
        session_key = self.get_session_key(role)
        return request.session.get(session_key, {})

    def set_role_session(self, request, role, user_id, user_type):
        """Set session data for a specific role"""
        session_key = self.get_session_key(role)
        request.session[session_key] = {
            'user_id': user_id,
            'user_role': role,
            'user_type': user_type,
            'is_active': True
        }
        request.session.modified = True

    def clear_role_session(self, request, role):
        """Clear session data for a specific role"""
        session_key = self.get_session_key(role)
        if session_key in request.session:
            del request.session[session_key]
            request.session.modified = True

    def get_current_user(self, request):
        """Determine current user based on the request path or fallback logic"""
        # Check for explicit role parameter first
        role_param = request.GET.get('role') or request.POST.get('role')
        if role_param:
            session_data = self.get_role_session(request, role_param)
            if session_data.get('is_active'):
                return session_data
        
        # Determine role based on the URL path and referer
        path = request.path.lower()
        referer = request.META.get('HTTP_REFERER', '').lower()
        
        # For API calls, check the referer to determine which page made the request
        if request.path.startswith('/user/'):
            # If it's an API call, check the referer
            if 'manager' in referer:
                session_data = self.get_role_session(request, 'manager')
                if session_data.get('is_active'):
                    return session_data
            elif 'worker' in referer:
                session_data = self.get_role_session(request, 'worker')
                if session_data.get('is_active'):
                    return session_data
            else:
                # Check if it's a manager-specific endpoint
                manager_endpoints = ['fetch_all_records', 'fetch_pending_records', 'approve-expense', 'reject-expense']
                for endpoint in manager_endpoints:
                    if endpoint in request.path:
                        session_data = self.get_role_session(request, 'manager')
                        if session_data.get('is_active'):
                            return session_data
                
                # Check if it's an owner-specific endpoint
                owner_endpoints = ['manage']
                for endpoint in owner_endpoints:
                    if endpoint in request.path:
                        session_data = self.get_role_session(request, 'owner')
                        if session_data.get('is_active'):
                            return session_data
        
        # Check for dashboard-specific paths
        if '/dashboard/' in path:
            if 'manager' in path:
                session_data = self.get_role_session(request, 'manager')
                if session_data.get('is_active'):
                    return session_data
            elif 'worker' in path:
                session_data = self.get_role_session(request, 'worker')
                if session_data.get('is_active'):
                    return session_data
            else:
                # Default to owner for main dashboard
                session_data = self.get_role_session(request, 'owner')
                if session_data.get('is_active'):
                    return session_data
        
        # For template rendering, determine role based on template name
        template_name = getattr(request, '_template_name', '')
        if 'manager' in template_name:
            session_data = self.get_role_session(request, 'manager')
            if session_data.get('is_active'):
                return session_data
        elif 'worker' in template_name:
            session_data = self.get_role_session(request, 'worker')
            if session_data.get('is_active'):
                return session_data
        elif 'dashboard' in template_name:
            session_data = self.get_role_session(request, 'owner')
            if session_data.get('is_active'):
                return session_data
        
        # Last resort: check which page the user is currently on
        user_agent = request.META.get('HTTP_USER_AGENT', '')
        
        # If no specific context found, return None to prevent cross-contamination
        return None

class SessionValidationMiddleware:
    """
    Middleware to validate session consistency and prevent role confusion
    """
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        # Only validate for dashboard and user management routes
        if request.path.startswith('/dashboard/') or request.path.startswith('/user/'):
            self.validate_session(request)
        
        response = self.get_response(request)
        return response

    def validate_session(self, request):
        """Validate that session data matches database records"""
        # Check all role-based sessions
        for role in ['owner', 'manager', 'worker']:
            session_key = f"user_session_{role}"
            session_data = request.session.get(session_key)
            
            if session_data:
                user_id = session_data.get('user_id')
                stored_role = session_data.get('user_role')
                
                if user_id and stored_role:
                    # Check if the user still exists and has the correct role
                    actual_role = None
                    
                    # Check Customer table
                    customer = Customer.objects.filter(user_id=user_id).first()
                    if customer:
                        actual_role = customer.role
                    else:
                        # Check Worker table
                        worker = Worker.objects.filter(worker_id=user_id).first()
                        if worker:
                            actual_role = worker.worker_role
                    
                    # If role mismatch or user doesn't exist, clear this role session
                    if not actual_role or actual_role != stored_role:
                        del request.session[session_key]
                        request.session.modified = True
