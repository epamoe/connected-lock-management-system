from multiprocessing import context
from django.http import HttpResponse
from django.shortcuts import render, redirect
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
    #form = RoomForm(instance=room)

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
