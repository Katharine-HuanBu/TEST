from django.shortcuts import render
from .forms import *
from django.contrib import messages
from django.contrib.auth import authenticate, login, logout as auth_logout, hashers
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required

#reate your views here.
def user_login(request):
    """
    login
    """
    if request.method == 'GET':
        user_form = LoginForm()
        return render(request, 'user/login.html', {'user_form': user_form})
    else:
        user_form = LoginForm(request.POST)
        if user_form.is_valid():
            cd = user_form.cleaned_data
            user = authenticate(request, username=cd['username'], password=cd['password'])  # validation
            login(request, user)  # login
            messages.success(request, 'login success')
            return redirect('/')
        else:
            return render(request, 'user/login.html', {'user_form': user_form})

def register(request):
    """
    Register
    """
    if request.method == 'GET':
        # You have already logged in and need to log out first
        if request.user is not None:
            auth_logout(request)
        user_form = RegisterForm()
        return render(request, 'user/register.html', {'user_form': user_form})
    else:
        user_form = RegisterForm(request.POST)
        if user_form.is_valid():
            # A new user
            new_user = user_form.save(commit=False)
            new_user.set_password(user_form.cleaned_data['password'])
            new_user.save()
            
            messages.success(request, 'register success! Please Login First!')
            return redirect('user:login')
        else:
            return render(request, 'user/register.html', {'user_form': user_form})

@login_required
def change_password(request):
    """
    Change the password
    """
    if request.method == 'GET':
        user_form = PasswordForm()
        return render(request, 'user/change_password.html', {'user_form': user_form})
    else:
        user_form = PasswordForm(request.POST)
        if user_form.is_valid():
            user = request.user
            password = user_form.cleaned_data['password']
            user.password = hashers.make_password(password)  # Formal change password, automatic encryption
            user.save()
            messages.success(request, 'chanege your profile success! Please Login First!')
            return redirect('user:login')
        else:
            return render(request, 'user/change_password.html', {'user_form': user_form})

def logout(request):
    """
    Log out
    """
    auth_logout(request)
    messages.success(request, 'logout success!')
    return redirect('index')




