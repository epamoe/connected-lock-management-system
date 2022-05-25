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


    