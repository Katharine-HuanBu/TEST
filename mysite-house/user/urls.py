from django.urls import path
from .views import *

app_name = 'user'

urlpatterns = [
    path('login/', user_login, name='login'),
    path('register/', register, name='register'), # register
    path('change_profile/', change_password, name='change_profile'), # Modify personal information
    path('logout/', logout, name='logout'), # exit
]
