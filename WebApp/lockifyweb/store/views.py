from multiprocessing import context
from django.http import HttpResponse
from django.shortcuts import render, redirect
from store.forms import MyUserForm
from  .models import*
from django.contrib import messages

def viewRoom(request):
    rooms = Room.objects.all()
    context={'rooms':rooms}
    return render(request, 'admin/room/index.html',context)


def createRoom(request):
    
    if request.method == 'POST':
        room_name = request.POST.get('room_name')
        description = request.POST.get('description')
        if Room.objects.filter(room_name=room_name).first():
            messages.error(request, 'duplicate datas!')
            return redirect('create_room')
        ret = Room.objects.create(room_name=room_name, description=description)
        ret.save()
        messages.success(request, 'succes!')
        return redirect('view_room')
    return render(request, 'admin/room/create.html') 


def updateRoom(request, pk):
    room = Room.objects.get(id_room=pk)
    context = {'room': room}
    #form = RoomForm(instance=room)

    if request.method == 'POST':
        #print('Printing POST', request.POST)
        room = Room.objects.get(id_room=pk)
        room.room_name = request.POST['room_name']
        room.description = request.POST['description']
        room.save()
        messages.success(request, 'Modification succes!')
        return redirect('view_room')
    return render(request, 'admin/room/edit.html',context)

def deleteRoom(request, pk):
    room = Room.objects.get(id_room=pk)
    room.delete()
    rooms = Room.objects.all()
    context={'rooms':rooms}
    messages.success(request, 'Delete succes!')
    return redirect('view_room')


    
def viewDay(request):
    days = Day.objects.all()
    context={'days':days}
    return render(request, 'admin/day/index.html',context)


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

def deleteDay(request, pk):
    day = Day.objects.get(id_day=pk)
    day.delete()
    days = Day.objects.all()
    context={'days':days}
    messages.success(request, 'Delete succes!')
    return redirect('view_day')



def viewRole(request):
    roles = Role.objects.all()
    context={'roles':roles}
    return render(request, 'admin/role/index.html',context)


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

def deleteRole(request, pk):
    role = Role.objects.get(id_role=pk)
    role.delete()
    roles = Role.objects.all()
    context={'roles':roles}
    messages.success(request, 'Delete succes!')
    return redirect('view_role')


def viewUser(request):
    users = MyUser.objects.all()
    context={'users':users}
    return render(request, 'admin/users/index.html',context)


def createUser(request):
    roles = Role.objects.all()
    context={'roles':roles}
    if request.method == 'POST':
        username = request.POST.get('name')
        email = request.POST.get('email')
        phone_number = request.POST.get('phone_number')
        role_id = request.POST.get('role_id')
        password= "userlockify2022"
        # password = request.POST.get('password')
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
   
def deleteUser(request, pk):
    myuser = MyUser.objects.get(id=pk)
    user = User.objects.get(id=myuser.user.id)
    myuser.delete()
    user.delete()
    messages.success(request, 'Delete succes!')
    return redirect('view_user')