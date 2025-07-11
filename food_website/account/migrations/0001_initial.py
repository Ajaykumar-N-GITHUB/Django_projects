# Generated by Django 5.2.1 on 2025-05-23 07:34

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user_name', models.CharField(max_length=200)),
                ('user_mobile', models.CharField(max_length=15)),
                ('user_location', models.CharField(max_length=200)),
                ('user_dob', models.DateField()),
                ('user_age', models.IntegerField()),
                ('user_email', models.EmailField(max_length=254)),
                ('user_id', models.CharField(max_length=20, unique=True)),
                ('user_passwd', models.CharField(max_length=25, unique=True)),
            ],
            options={
                'db_table': 'user_detail',
            },
        ),
    ]
