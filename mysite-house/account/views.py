from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.http import HttpResponse
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth import authenticate, login, logout as auth_logout, hashers
from django.contrib import messages
from house.models import *
# Create your views here.
from account.forms import LoginForm, RegisterForm


def user_login(request):
    # if request.user.is_authenticated():
    #     return render(request, 'account/login.html', {'message': "You are logged in! Please quit"})
    if request.method == 'POST':
        form = LoginForm(request.POST)
        if form.is_valid():
            cd = form.cleaned_data
            user = authenticate(request, username = cd['username'], password=cd['password'])
            if user is not None:
                if user.is_active:
                    login(request, user)
                    return redirect('/')
                else:
                    return HttpResponse('user now is not per!')
            else:
                return render(request, 'account/login.html', {'message' : "username or password is valid"})
        else:
            form = LoginForm()
            return render(request, 'account/login.html', {'message' : "username or password is valid"})
    else:

        form = LoginForm()
        return render(request, 'account/login.html', {'form': form})

#Change the password
@login_required
def change_profile(request):
    """
    Modify personal information
    https://www.cnblogs.com/wcwnina/p/9246228.html
    https://www.cnblogs.com/NeedEnjoyLife/p/6842809.html
    :param request:
    :return:
    """
    #If the method of transmission is to transfer the value
    if request.method == 'POST':
        #message
        msg = ''
        #A user is a passing user
        user = request.user
        #The username is the username of the transfer
        username = request.POST['username']
        #The password is the transmission password
        password = request.POST['password']
        #The repassword is the transmission repassword
        repassword = request.POST['repassword']
        #If the user did not enter a username or password
        if username == '' and password == '':
            #The message prompts for an empty username or password
            msg = 'username or password is empty!!'
        else:
            #If the password is different from the second password
            if password:
                if password != repassword:
                    msg = 'the password is not same!'
                else:
                    # Change the password, encrypt it automatically
                    user.password = hashers.make_password(password)
            if username:
                #The user name is the user name
                user.username = username
            user.save()
            #Return to the login page
            return redirect('/account/login')
        #Return to the password change page
        return render(request, 'account/profile.html', {'message' : msg})
    else:
        #Return to the password change page
        return render(request, 'account/profile.html')

def register(request):
    """
    Registration logic
    :param request:
    :return:
    """
    if request.method == 'POST':
        user_form = RegisterForm(request.POST)
        if user_form.is_valid():
            new_user = user_form.save(commit=False)
            new_user.set_password(user_form.cleaned_data['password'])
            new_user.save()
            return redirect('/account/login/')
        else:
            user = User.objects.get(username=request.POST['username'])
            if user:
                return render(request, 'account/register.html', {'message': 'username is already usered!!'})
            else:
                return render(request, 'account/register.html', {'message' : 'the password is not same!'})
    else:
        # You have already logged in and need to log out first
        if request.user is not None:
            auth_logout(request)
        return render(request, 'account/register.html')
#
def logout(request):
    auth_logout(request)
    return HttpResponse('<script>window.alert("Ok!");location.href="/account/login"</script>')

@login_required
def center(request):
    """
    User Center
    :param request:
    :return:
    """
    #Get the username
    user = request.user
    #Check out the house information you rent
    orders = Rent.objects.filter(user=request.user)
    #Return to the user center interface
    return render(request, 'account/center.html', {
        'orders': orders,
    })




