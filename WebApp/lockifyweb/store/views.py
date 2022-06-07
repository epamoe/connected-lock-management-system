from multiprocessing import context
from django.http import HttpResponse
from django.shortcuts import render, redirect
from  .models import*
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.contrib.auth.decorators import login_required

def log(request):
    if request.method == 'POST':
        email = request.POST.get('email')
        password = request.POST.get('password')
        print(email, password)

        user_obj = User.objects.filter(email = email).first()

        if user_obj is None:
            messages.error(request, 'User not found.')
            return redirect('log')

        if not user_obj.is_active:
            messages.error(request, 'Profile is not verified check your mail.')
            return redirect('log')

        user = authenticate(username = user_obj.username , password = password)
        if user is None:
            messages.error(request, 'Wrong password.')
            return redirect('log')
        
        login(request , user)
        return redirect('dashboard')

    return render(request , 'registration/login.html')


def logout_lockify(request):
    logout(request)
    return redirect('/')

@login_required(login_url = 'log')    
def viewDay(request):
    days = Day.objects.all()
    context={'days':days}
    return render(request, 'admin/day/index.html',context)

@login_required(login_url = 'log')
def createDay(request):
    
    if request.method == 'POST':
        day_name = request.POST.get('day_name')
        if Day.objects.filter(day_name=day_name).first():
            messages.error(request, 'duplicate datas!')
            return redirect('create_day')
        ret = Day.objects.create(day_name=day_name)
        ret.save()
        messages.success(request, 'succes!')
        return redirect('view_day')
    return render(request, 'admin/day/create.html') 

@login_required(login_url = 'log')
def updateDay(request, pk):
    day = Day.objects.get(id_day=pk)
    context = {'day': day}

    if request.method == 'POST':
        day = Day.objects.get(id_day=pk)
        day.day_name = request.POST['day_name']
        day.save()
        messages.success(request, 'Modification succes!')
        return redirect('view_day')
    return render(request, 'admin/day/edit.html',context)

@login_required(login_url = 'log')
def deleteDay(request, pk):
    day = Day.objects.get(id_day=pk)
    day.delete()
    days = Day.objects.all()
    context={'days':days}
    messages.success(request, 'Delete succes!')
    return redirect('view_day')

@login_required(login_url = 'log')
def viewRole(request):
    roles = Role.objects.all()
    context={'roles':roles}
    return render(request, 'admin/role/index.html',context)


@login_required(login_url = 'log')
def createRole(request):
    
    if request.method == 'POST':
        role_name = request.POST.get('role_name')
        description = request.POST.get('description')
        if Role.objects.filter(role_name=role_name).first():
            messages.error(request, 'duplicate datas!')
            return redirect('create_role')
        ret = Role.objects.create(role_name=role_name, description=description)
        ret.save()
        messages.success(request, 'succes!')
        return redirect('view_role')
    return render(request, 'admin/role/create.html') 

@login_required(login_url = 'log')
def updateRole(request, pk):
    role = Role.objects.get(id_role=pk)
    context = {'role': role}
    

    if request.method == 'POST':
        #print('Printing POST', request.POST)
        role = Role.objects.get(id_role=pk)
        role.role_name = request.POST['role_name']
        role.description = request.POST['description']
        role.save()
        messages.success(request, 'Modification succes!')
        return redirect('view_role')
    return render(request, 'admin/role/edit.html',context)

@login_required(login_url = 'log')
def deleteRole(request, pk):
    role = Role.objects.get(id_role=pk)
    role.delete()
    messages.success(request, 'Delete succes!')
    return redirect('view_role')


@login_required(login_url = 'log')
def viewUser(request):
    users = MyUser.objects.all()
    context={'users':users}
    return render(request, 'admin/users/index.html',context)

@login_required(login_url = 'log')
def createUser(request):
    roles = Role.objects.all()
    context={'roles':roles}
    if request.method == 'POST':
        username = request.POST.get('name')
        email = request.POST.get('email')
        phone_number = request.POST.get('phone_number')
        role_id = request.POST.get('role_id')
        #password= 'userlockify2022'
        password = request.POST.get('password')
        print("*******************************************")
        print( role_id, password)
        try:
            if User.objects.filter(username = username).first():
                messages.warning(request, 'Username is taken.')
                return redirect('create_user')
            if User.objects.filter(email = email).first():
                messages.warning(request, 'Email is taken.')
                return redirect('create_user')
            user_obj = User(username = username, email = email)
            user_obj.set_password(password)
            user_obj.save()
            promotor_obj = MyUser.objects.create(user = user_obj, phone_number = phone_number, role_id = role_id )
            promotor_obj.save()
            messages.success(request, 'succes!')
            return redirect('view_user')
        except Exception as e:
            print(e)
    return render(request , 'admin/users/create.html', context) 

@login_required(login_url = 'log')
def updateUser(request, pk):
    roles = Role.objects.all()
    myuser = MyUser.objects.get(id=pk)
    context = {'myuser':myuser,'roles':roles}
    if request.method == 'POST':
        user = User.objects.get(id=myuser.user.id)
        user.email = request.POST['email']
        user.username = request.POST['username']

        myuser.phone_number = request.POST['phone_number']
        role =  request.POST.get('role') 
        myuser.role = Role.objects.get(id_role=role)
        print(f'myuser: {myuser.role}')
        myuser.user = user
        user.save()
        myuser.save()
        messages.success(request, 'Modifications succes!')
        return redirect('view_user')
       
    
    return render(request , 'admin/users/edit.html', context)

@login_required(login_url = 'log')  
def deleteUser(request, pk):
    myuser = MyUser.objects.get(id=pk)
    user = User.objects.get(id=myuser.user.id)
    myuser.delete()
    user.delete()
    messages.success(request, 'Delete succes!')
    return redirect('view_user')


@login_required(login_url = 'log')
def viewLock(request):
    locks = Lock.objects.all()
    context={'locks':locks}
    return render(request, 'admin/locks/index.html',context)

@login_required(login_url = 'log')
def createLock(request):
    myusers = MyUser.objects.all()
    context={ 'myusers':myusers}
    if request.method == 'POST':
        lock_name = request.POST.get('lock_name')
        lock_mac = request.POST.get('lock_mac')
        auto_lock_time = request.POST.get('auto_lock_time')
        lock_data = request.POST.get('lock_data')
        lock_status = request.POST.get('lock_status')
        lock_percent = request.POST.get('lock_percent')
        user_id = request.POST.get('user_id')
        try:
            if Lock.objects.filter(lock_mac = lock_mac).first():
                messages.warning(request, 'lock Mac is taken.')
                return redirect('create_lock')
            if Lock.objects.filter(lock_name = lock_name).first():
                messages.warning(request, ' lock name is taken.')
                return redirect('create_lock')
            lock = Lock.objects.create(lock_name = lock_name, lock_mac = lock_mac, auto_lock_time = auto_lock_time, lock_data = lock_data, lock_status = lock_status, lock_percent = lock_percent, user_id = user_id)
            lock.save()
            messages.success(request, 'succes!')
            return redirect('view_lock')
        except Exception as e:
            print(e)
    return render(request , 'admin/locks/create.html', context) 

@login_required(login_url = 'log')
def updateLock(request, pk):
    myusers = MyUser.objects.all()
    locks = Lock.objects.get(id_lock = pk)
    context={ 'myusers':myusers}
    if request.method == 'POST':
        lock = Lock.objects.get(id_lock = pk)
        lock.lock_name= request.POST['lock_name']
        lock.lock_mac = request.POST['lock_mac']
        lock.auto_lock_time = request.POST['auto_lock_time']
        lock.lock_data = request.POST['lock_data']
        lock.lock_status = request.POST['lock_status']
        lock.lock_percent = request.POST['lock_percent']
        myuser =  request.POST.get('user_id')
        print(myuser)
        lock.user = MyUser.objects.get(id=myuser)
        lock.save()
        messages.success(request, 'Modifications succes!')
        return redirect('view_lock')
       
    
    return render(request , 'admin/locks/edit.html', context)

@login_required(login_url = 'log')  
def deleteLock(request, pk):
    lock = Lock.objects.get(id_lock=pk)
    lock.delete()
    messages.success(request, 'Delete succes!')
    return redirect('view_lock')


@login_required(login_url = 'log')
def viewAction(request):
    actions = Action.objects.all()
    context={'actions':actions}
    return render(request, 'admin/actions/index.html',context)

@login_required(login_url = 'log')
def createAction(request):
    locks = Lock.objects.all()
    myusers = MyUser.objects.all()
    context={'locks':locks, 'myusers':myusers}
    if request.method == 'POST':
        action_name = request.POST.get('action_name')
        lock_id = request.POST.get('lock_id')
        user_id = request.POST.get('user_id')
        try:
            action = Action.objects.create(action_name = action_name, user_id = user_id, lock_id = lock_id )
            action.save()
            messages.success(request, 'succes!')
            return redirect('view_action')
        except Exception as e:
            print(e)
    return render(request , 'admin/actions/create.html', context) 

@login_required(login_url = 'log')
def updateAction(request, pk):
    locks = Lock.objects.all()
    myusers = MyUser.objects.all()
    actions = Action.objects.get(id_action = pk)
    context={'actions':actions,'locks':locks, 'myusers':myusers}
    if request.method == 'POST':
        action = Action.objects.get(id_action = pk)
        action.action_name= request.POST['action_name']
        lock = request.POST.get('lock_id')
        myuser =  request.POST.get('user_id')
        print(lock)
        action.lock = Lock.objects.get(id_lock=lock)
        action.user = MyUser.objects.get(id=myuser)
        action.save()
        messages.success(request, 'Modifications succes!')
        return redirect('view_action')
       
    
    return render(request , 'admin/actions/edit.html', context)

@login_required(login_url = 'log')  
def deleteAction(request, pk):
    action = Action.objects.get(id_action=pk)
    action.delete()
    messages.success(request, 'Delete succes!')
    return redirect('view_action')


@login_required(login_url = 'log')
def viewPassage_mode(request):
    passage_modes = Passage_mode.objects.all()
    context={'passage_modes':passage_modes}
    return render(request, 'admin/passage_modes/index.html',context)

@login_required(login_url = 'log')
def createPassage_mode(request):
    locks = Lock.objects.all()
    context={'locks':locks}
    if request.method == 'POST':
        start_date = request.POST.get('start_date')
        end_date = request.POST.get('end_date')
        status = request.POST.get('status')
        lock_id = request.POST.get('locks_id')
        print(lock_id)
        try:

            passage_mode = Passage_mode.objects.create(start_date = start_date, end_date = end_date, status=status, locks_id = lock_id )
            passage_mode.save()
            messages.success(request, 'succes!')
            return redirect('view_passage_mode')
        except Exception as e:
            print(e)
    return render(request , 'admin/passage_modes/create.html', context) 

@login_required(login_url = 'log')
def updatePassage_mode(request, pk):
    locks = Lock.objects.all()
    passage_mode = Passage_mode.objects.get(id_passage_mode = pk)
    context={'passage_mode':passage_mode,'locks':locks}
    if request.method == 'POST':
        passage_mode = Passage_mode.objects.get(id_passage_mode = pk)
        passage_mode.start_date= request.POST['start_date']
        passage_mode.end_date= request.POST['end_date']
        passage_mode.status= request.POST['status']
        lock = request.POST.get('locks_id')
        passage_mode.lock = Lock.objects.get(id_lock=lock)
        passage_mode.save()
        messages.success(request, 'Modifications succes!')
        return redirect('view_passage_mode')
    return render(request , 'admin/passage_modes/edit.html', context)

@login_required(login_url = 'log')  
def deletePassage_mode(request, pk):
    passage_mode = Passage_mode.objects.get(id_passage_mode=pk)
    passage_mode.delete()
    messages.success(request, 'Delete succes!')
    return redirect('view_passage_mode')


@login_required(login_url = 'log')
def viewCode(request):
    codes = Code.objects.all()
    context={'codes':codes}
    return render(request, 'admin/codes/index.html',context)

@login_required(login_url = 'log')
def createCode(request):
    locks = Lock.objects.all()
    myusers = MyUser.objects.all()
    context={'locks':locks, 'myusers':myusers}
    if request.method == 'POST':
        code = request.POST.get('code')
        description = request.POST.get('description')
        start_date = request.POST.get('start_date')
        end_date = request.POST.get('end_date')
        is_set = request.POST.get('is_set')
        lock_id = request.POST.get('lock_id')
        user_id = request.POST.get('user_id')
        try:
            code = Code.objects.create(code = code, description = description, start_date = start_date, end_date = end_date, is_set = is_set, user_id = user_id, lock_id = lock_id )
            code.save()
            messages.success(request, 'succes!')
            return redirect('view_code')
        except Exception as e:
            print(e)
    return render(request , 'admin/codes/create.html', context) 

@login_required(login_url = 'log')
def updateCode(request, pk):
    locks = Lock.objects.all()
    myusers = MyUser.objects.all()
    codes = Code.objects.get(id = pk)
    context={'codes':codes,'locks':locks, 'myusers':myusers}
    if request.method == 'POST':
        code = Code.objects.get(id = pk)
        code.code= request.POST['code']
        code.description = request.POST['description']
        code.start_date = request.POST['start_date']
        code.end_date = request.POST['end_date']
        code.is_set = request.POST['is_set']
        lock = request.POST.get('lock_id')
        myuser =  request.POST.get('user_id')
        print(lock)
        code.lock = Lock.objects.get(id_lock=lock)
        code.user = MyUser.objects.get(id=myuser)
        code.save()
        messages.success(request, 'Modifications succes!')
        return redirect('view_code')
       
    
    return render(request , 'admin/codes/edit.html', context)

@login_required(login_url = 'log')  
def deleteCode(request, pk):
    code = Code.objects.get(id=pk)
    code.delete()
    messages.success(request, 'Delete succes!')
    return redirect('view_code')


@login_required(login_url = 'log')
def viewCard(request):
    cards = Card.objects.all()
    context={'cards':cards}
    return render(request, 'admin/cards/index.html',context)

@login_required(login_url = 'log')
def createCard(request):
    locks = Lock.objects.all()
    myusers = MyUser.objects.all()
    context={'locks':locks, 'myusers':myusers}
    if request.method == 'POST':
        card = request.POST.get('card')
        description = request.POST.get('description')
        start_date = request.POST.get('start_date')
        end_date = request.POST.get('end_date')
        is_set = request.POST.get('is_set')
        lock_id = request.POST.get('lock_id')
        user_id = request.POST.get('user_id')
        try:
            card = Card.objects.create(card = card, description = description, start_date = start_date, end_date = end_date, is_set = is_set, user_id = user_id, lock_id = lock_id )
            card.save()
            messages.success(request, 'succes!')
            return redirect('view_card')
        except Exception as e:
            print(e)
    return render(request , 'admin/cards/create.html', context) 

@login_required(login_url = 'log')
def updateCard(request, pk):
    locks = Lock.objects.all()
    myusers = MyUser.objects.all()
    cards = Card.objects.get(id = pk)
    context={'cards':cards,'locks':locks, 'myusers':myusers}
    if request.method == 'POST':
        card = Card.objects.get(id = pk)
        card.card= request.POST['card']
        card.description = request.POST['description']
        card.start_date = request.POST['start_date']
        card.end_date = request.POST['end_date']
        card.is_set = request.POST['is_set']
        lock = request.POST.get('lock_id')
        myuser =  request.POST.get('user_id')
        print(lock)
        card.lock = Lock.objects.get(id_lock=lock)
        card.user = MyUser.objects.get(id=myuser)
        card.save()
        messages.success(request, 'Modifications succes!')
        return redirect('view_card')
       
    
    return render(request , 'admin/cards/edit.html', context)

@login_required(login_url = 'log')   
def deleteCard(request, pk):
    card = Card.objects.get(id=pk)
    card.delete()
    messages.success(request, 'Delete succes!')
    return redirect('view_card')


@login_required(login_url = 'log')
def viewFingerPrint(request):
    fingerPrints = FingerPrint.objects.all()
    context={'fingerPrints':fingerPrints}
    return render(request, 'admin/fingerPrints/index.html',context)

@login_required(login_url = 'log')
def createFingerPrint(request):
    locks = Lock.objects.all()
    myusers = MyUser.objects.all()
    context={'locks':locks, 'myusers':myusers}
    if request.method == 'POST':
        fingerPrint = request.POST.get('fingerPrint')
        description = request.POST.get('description')
        start_date = request.POST.get('start_date')
        end_date = request.POST.get('end_date')
        is_set = request.POST.get('is_set')
        lock_id = request.POST.get('lock_id')
        user_id = request.POST.get('user_id')
        try:
            fingerPrint = FingerPrint.objects.create(fingerPrint = fingerPrint, description = description, start_date = start_date, end_date = end_date, is_set = is_set, user_id = user_id, lock_id = lock_id )
            fingerPrint.save()
            messages.success(request, 'succes!')
            return redirect('view_fingerPrint')
        except Exception as e:
            print(e)
    return render(request , 'admin/fingerPrints/create.html', context) 

@login_required(login_url = 'log')
def updateFingerPrint(request, pk):
    locks = Lock.objects.all()
    myusers = MyUser.objects.all()
    fingerPrints = FingerPrint.objects.get(id = pk)
    context={'fingerPrints':fingerPrints,'locks':locks, 'myusers':myusers}
    if request.method == 'POST':
        fingerPrint = FingerPrint.objects.get(id = pk)
        fingerPrint.fingerPrint= request.POST['fingerPrint']
        fingerPrint.description = request.POST['description']
        fingerPrint.start_date = request.POST['start_date']
        fingerPrint.end_date = request.POST['end_date']
        fingerPrint.is_set = request.POST['is_set']
        lock = request.POST.get('lock_id')
        myuser =  request.POST.get('user_id')
        print(lock)
        fingerPrint.lock = Lock.objects.get(id_lock=lock)
        fingerPrint.user = MyUser.objects.get(id=myuser)
        fingerPrint.save()
        messages.success(request, 'Modifications succes!')
        return redirect('view_fingerPrint')
       
    
    return render(request , 'admin/fingerPrints/edit.html', context)

@login_required(login_url = 'log') 
def deleteFingerPrint(request, pk):
    fingerPrint = FingerPrint.objects.get(id=pk)
    fingerPrint.delete()
    messages.success(request, 'Delete succes!')
    return redirect('view_fingerPrint')


@login_required(login_url = 'log')
def viewBluetooth(request):
    bluetooths = Bluetooth.objects.all()
    context={'bluetooths':bluetooths}
    return render(request, 'admin/bluetooth/index.html',context)

@login_required(login_url = 'log')
def createBluetooth(request):
    locks = Lock.objects.all()
    myusers = MyUser.objects.all()
    context={'locks':locks, 'myusers':myusers}
    if request.method == 'POST':
        description = request.POST.get('description')
        start_date = request.POST.get('start_date')
        end_date = request.POST.get('end_date')
        is_set = request.POST.get('is_set')
        lock_id = request.POST.get('lock_id')
        user_id = request.POST.get('user_id')
        try:
            bluetooth = Bluetooth.objects.create( description = description, start_date = start_date, end_date = end_date, is_set = is_set, user_id = user_id, lock_id = lock_id )
            bluetooth.save()
            messages.success(request, 'succes!')
            return redirect('view_bluetooth')
        except Exception as e:
            print(e)
    return render(request , 'admin/bluetooth/create.html', context) 

@login_required(login_url = 'log')
def updateBluetooth(request, pk):
    locks = Lock.objects.all()
    myusers = MyUser.objects.all()
    bluetooths = Bluetooth.objects.get(id = pk)
    context={'bluetooths':bluetooths,'locks':locks, 'myusers':myusers}
    if request.method == 'POST':
        bluetooth = Bluetooth.objects.get(id = pk)
        bluetooth.description = request.POST['description']
        bluetooth.start_date = request.POST['start_date']
        bluetooth.end_date = request.POST['end_date']
        bluetooth.is_set = request.POST['is_set']
        lock = request.POST.get('lock_id')
        myuser =  request.POST.get('user_id')
        print(lock)
        bluetooth.lock = Lock.objects.get(id_lock=lock)
        bluetooth.user = MyUser.objects.get(id=myuser)
        bluetooth.save()
        messages.success(request, 'Modifications succes!')
        return redirect('view_bluetooth')
       
    
    return render(request , 'admin/bluetooth/edit.html', context)

@login_required(login_url = 'log')  
def deleteBluetooth(request, pk):
    bluetooth = Bluetooth.objects.get(id=pk)
    bluetooth.delete()
    messages.success(request, 'Delete succes!')
    return redirect('view_bluetooth')

@login_required(login_url = 'log')
def viewHistory(request):
    histories = History.objects.all()
    context={'histories':histories}
    return render(request, 'admin/histories/index.html',context)

