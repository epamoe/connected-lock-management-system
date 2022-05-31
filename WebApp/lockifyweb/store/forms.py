from django import forms
from store.models import MyUser
from django.contrib.auth.models import User

class MyUserForm(forms.Form):
    username = forms.CharField(min_length=6, required=True)
    email = forms.EmailField(required=True)
    password = forms.CharField(min_length=8, widget=forms.PasswordInput)
    


    # def clean_email(self):
    #     email = self.data['email']
    #     if User.objects.filter(email=email).exist():
    #         raise forms.ValidationError('Cette adresse est deja enregistré')
    #     return self.data

    class Meta:
        model = MyUser
        fields = ['username', 'email', 'password', 'phone_number', 'role']

    def save(self, commit=True):
        username = self.cleaned_data['username']
        email = self.cleaned_data['email']
        password = self.cleaned_data['username']
        user = User.create_user(username=username, email=email,password=password)
        myuser = MyUser.create(user=user, phone_number=self.cleaned_data['phone_number'], role=self.cleaned_data['role'])
        return myuser