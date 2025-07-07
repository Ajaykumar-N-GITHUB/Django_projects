import os
import sys
import django
from django.core.management import call_command

def main():
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'ngo_mailsender.settings')
    django.setup()

    try:
        print("calling static files...")
        call_command("collectstatic --noinput")

        print("📦 Making migrations...")
        call_command('makemigrations')

        print("📂 Applying migrations...")
        call_command('migrate')

        print("🚀 Starting development server at http://127.0.0.1:8000/")
        call_command('runserver', '0.0.0.0:8000')

    except Exception as e:
        print(f"❌ Error: {e}")

if __name__ == '__main__':
    main()
