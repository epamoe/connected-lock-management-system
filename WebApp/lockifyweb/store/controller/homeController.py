from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from  store.models import*


def home(request):
     context = {}
     return render(request, 'index.html', context)

@login_required(login_url = 'log')
def dashboard(request):
     cards = Card.objects.all().count
     codes = Code.objects.all().count
     locks = Lock.objects.all().count
     users = MyUser.objects.all().count
     cards_list = Card.objects.all()
     codes_list = Code.objects.all()
     locks_list = Lock.objects.all()
     users_list = MyUser.objects.all()
     context = {'cards':cards,'codes':codes,'locks':locks,'users':users,'cards_list':cards_list,'codes_list':codes_list,'locks_list':locks_list,'users_list':users_list}
     return render(request, 'dashboard.html', context)


def viewCardUser(request):
    cards = Card.objects.all()
    print(cards)
    context={'cards':cards}
    return render(request, 'user/cards/index.html',context)


def viewLockUser(request):
    locks= Lock.objects.select_related().filter(user=request.user.myuser.user_id)
    print(locks)
    context={'locks':locks}
    return render(request, 'user/locks/index.html',context)


def viewCodeUser(request):
    codes = Code.objects.all()
    print(codes)
    context={'codes':codes}
    return render(request, 'user/codes/index.html',context)


def viewFingerPrintUser(request):
    fingerPrint = FingerPrint.objects.all()
    print(fingerPrint)
    context={'fingerPrint':fingerPrint}
    return render(request, 'user/fingerPrint/index.html',context)

def details(request):
     context = {}
     return render(request, 'user/details.html', context)

