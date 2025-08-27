from account.models import Customer, Worker

def get_user_from_role_session(request, role):
    """Get user data from role-specific session"""
    session_data = request.get_role_session(role)
    if session_data and session_data.get('is_active'):
        return session_data
    return None

def get_current_user_session(request):
    """Get current active user session based on context"""
    return request.get_current_user()

def set_user_session(request, user_id, role, user_type):
    """Set user session for specific role"""
    request.set_role_session(role, user_id, user_type)

def clear_user_session(request, role):
    """Clear user session for specific role"""
    request.clear_role_session(role)

def validate_user_permission(request, required_role):
    """Validate if current user has required permission"""
    # First, try to get the session specifically for the required role
    role_session = get_user_from_role_session(request, required_role)
    
    if role_session:
        user_id = role_session.get('user_id')
        user_role = role_session.get('user_role')
        
        # Validate the user still exists and has correct role
        if user_role == 'owner' and required_role == 'owner':
            customer = Customer.objects.filter(user_id=user_id, role='owner').first()
            return customer is not None
        elif user_role in ['manager', 'worker'] and required_role == user_role:
            worker = Worker.objects.filter(worker_id=user_id, worker_role=user_role).first()
            return worker is not None
    
    # Fallback to current user session (for backward compatibility)
    current_user = get_current_user_session(request)
    if not current_user:
        return False
    
    user_role = current_user.get('user_role')
    user_id = current_user.get('user_id')
    
    # Validate the user still exists and has correct role
    if user_role == 'owner':
        customer = Customer.objects.filter(user_id=user_id, role='owner').first()
        return customer is not None and required_role == 'owner'
    elif user_role in ['manager', 'worker']:
        worker = Worker.objects.filter(worker_id=user_id, worker_role=user_role).first()
        return worker is not None and required_role == user_role
    
    return False

def get_user_context(request):
    """Get user context for templates"""
    current_user = get_current_user_session(request)
    if current_user:
        return {
            'user_id': current_user.get('user_id'),
            'user_role': current_user.get('user_role'),
            'user_type': current_user.get('user_type'),
            'is_authenticated': True
        }
    return {'is_authenticated': False}
