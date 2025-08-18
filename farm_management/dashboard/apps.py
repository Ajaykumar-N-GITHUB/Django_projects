from django.apps import AppConfig
from farm_management.ai_model import load_and_train_model
import sys

class DashboardConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'dashboard'

    def ready(self):
        if 'runserver' in sys.argv:
            load_and_train_model()