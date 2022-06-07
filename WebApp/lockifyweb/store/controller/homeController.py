from django.shortcuts import render
from django.contrib.auth.decorators import login_required

def home(request):
     context = {}
     return render(request, 'index.html', context)

@login_required(login_url = 'log')
def dashboard(request):
     context = {}
     return render(request, 'dashboard.html', context)


def cart(request):
     context = {}
     return render(request, 'store/cart.html', context)

def checkout(request):
      context = {}
      return render(request, 'store/checkout.html', context)