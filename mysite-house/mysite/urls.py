"""mysite URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf.urls import url
from django.contrib import admin
from django.urls import path, include, re_path
from django.conf.urls.static import static
from mysite import settings
from house.views import *

urlpatterns = [
    path('captcha/', include('captcha.urls')), # Verification code
    path('', index, name='index'),
    path('detail/<int:bid>', detail, name='detail'),
    url(r'new_search$', new_search, name='new_search'),
    url(r'^search$', search, name='search'),
    path('rent/', rent, name='rent'), # To apply for
    path('unsubscribe/<int:rid>', unsubscribe, name='unsubscribe'), # unsubscribe
    path('cancel_unsub/<int:cid>', cancel_ubsub, name='cancel_unsub'), # cancel unsubscribe
    path('delay/<int:rid>', delay, name='delay'),
    path('account/', include('account.urls'), name='account'),
    path('user/', include('user.urls'), name='user'),
    path('admin/', admin.site.urls),
    re_path(r'^admin_tools/', include('admin_tools.urls')), # admin_tools
    path('tongji/', tongji, name='tongji'),
    path('profit_search/', profit_search, name='profit_search'),
]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT) + static(settings.STATIC_URL) # Configure the path to the static resource

