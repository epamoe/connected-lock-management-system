from django.shortcuts import render

def home(request):
     context = {}
     return render(request, 'index.html', context)


def dashboard(request):
     context = {}
     return render(request, 'dashboard.html', context)


def cart(request):
     context = {}
     return render(request, 'store/cart.html', context)

def checkout(request):
      context = {}
      return render(request, 'store/checkout.html', context)