from django.urls import path
from .views import *

app_name = 'account'
urlpatterns = [
    path('login/', user_login, name='login'),
    path('logout/', logout, name="logout"),  # Log out
    path('register/', register, name='register'),  # Register
    path('center/', center, name='center'),
    path('change_profile/', change_profile, name='change_profile'), # Modify the data
]