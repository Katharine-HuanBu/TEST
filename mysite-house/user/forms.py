
from django import forms
from django.contrib.auth.models import User
from captcha.fields import CaptchaField
from django.contrib.auth import authenticate
'''/**
* @author: BuHuan
* @Title: LoginForm
* @ProjectName：Version 6
* @Description:1. Visitors can enter the user's name and password to log in;
2. Visitors can click on the picture of the verification code to view the verification code, and enter the verification code to verify the identity of users and tourists.
* @'''

# The login form
class LoginForm(forms.Form):

    #A field that defines the user name
    username = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'Username'}))
    # A field that defines the password
    password = forms.CharField(widget=forms.PasswordInput(attrs={'placeholder': 'Password'}))
    # verification code
    captcha = CaptchaField()

    class Meta:
        # Fields that define the user name and password
        fields = ('username', 'password', )
    #Verify password
    def clean_password(self):
        #Click to refresh the verification code
        cd = self.cleaned_data
        # Verify the user name and password
        user = authenticate(request=None, username = cd['username'], password=cd['password'])
        #Determine whether the user is non-null
        if user is not None:
            #If the CAPTCHA is incorrect, the user is not active
            if not user.is_active:
                raise forms.ValidationError('user is not active')
            return cd['password']
        else:
            #If the password or user name is incorrect, the user name or password is incorrect
            raise forms.ValidationError('username or password is valid')
#Register Form
class RegisterForm(forms.ModelForm):
    # A field that defines the password
    password = forms.CharField(label='Password', widget=forms.PasswordInput)
    # A field that defines the repassword
    repassword = forms.CharField(label='Repassword', widget=forms.PasswordInput)
    # Define CAPTCHA
    captcha = CaptchaField()
    #Determine the user name and password
    class Meta:
        model = User
        fields = ('username', 'password', )
    #Clear the second password
    def clean_repassword(self):
        cd = self.cleaned_data
        #Determine if the first password is the same as the second password
        if cd['password'] != cd['repassword']:
            #If the two passwords are not the same, the two passwords will be displayed differently
            raise forms.ValidationError('the two password are not the same')
        return cd['repassword']
#Change password form
class PasswordForm(forms.Form):
    # A field that defines the password
    password = forms.CharField(label='Password', widget=forms.PasswordInput)
    # A field that defines the repassword
    repassword = forms.CharField(label='Repassword', widget=forms.PasswordInput)
    # Define CAPTCHA
    captcha = CaptchaField()

    # Clear the second password
    def clean_repassword(self):
        cd = self.cleaned_data
        # Determine if the first password is the same as the second password
        if cd['password'] != cd['repassword']:
            # If the two passwords are not the same, the two passwords will be displayed differently
            raise forms.ValidationError('the two password are not the same')
        return cd['repassword']
