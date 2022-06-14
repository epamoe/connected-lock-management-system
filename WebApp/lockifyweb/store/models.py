from distutils.command.upload import upload
from tkinter import CASCADE
from django.db import models
from django.contrib.auth.models import User


# Create your models here.

class Role(models.Model):
    id_role = models.AutoField(primary_key=True)
    role_name = models.CharField(max_length=30, null=False)
    description = models.TextField(max_length=30, null=True)



class MyUser(models.Model):
    user = models.OneToOneField(User,on_delete=models.CASCADE, related_name= 'myuser')
    phone_number = models.IntegerField(null=False)
    role = models.ForeignKey(Role, on_delete= models.CASCADE)
    image = models.ImageField ( default = 'default.png', upload_to ='profile_images', null=False)



class Day(models.Model):
    id_day = models.AutoField(primary_key=True)
    day_name = models.CharField(max_length=30, null=False)


class Lock(models.Model):
    id_lock= models.AutoField(primary_key=True)
    lock_name = models.CharField(max_length=30, null=False)
    lock_mac = models.CharField(null=False, max_length=30)
    auto_lock_time= models.IntegerField(null=False)
    lock_data = models.CharField(null=False, max_length=5000)
    lock_status = models.CharField(null=False, max_length=30)
    lock_percent = models.IntegerField(null=False)
    user = models.ForeignKey(MyUser, on_delete= models.CASCADE, null=False )

class FingerPrint(models.Model):
    fingerPrint = models.CharField(null=True, max_length=30)
    description= models.CharField(max_length=100, null=False)
    start_date = models.DateTimeField(max_length=30, null=False)
    end_date= models.DateTimeField(max_length=30, null=False)
    is_set = models.IntegerField(null=False, default='0')
    user = models.ForeignKey(MyUser, on_delete= models.CASCADE, null=False )
    lock = models.ForeignKey(Lock, on_delete= models.CASCADE, null=False )


class Card(models.Model):
    card = models.CharField(null=True,max_length=30)
    description= models.CharField(max_length=30, null=False)
    start_date = models.DateTimeField(max_length=30, null=False)
    end_date= models.DateTimeField(max_length=30, null=False)
    is_set = models.IntegerField(null=False, default="0")
    user = models.ForeignKey(MyUser, on_delete= models.CASCADE, null=False )
    lock = models.ForeignKey(Lock, on_delete= models.CASCADE, null=False )


class Bluetooth(models.Model):
    description= models.CharField(max_length=30, null=False)
    start_date = models.DateTimeField(max_length=30, null=False)
    end_date= models.DateTimeField(max_length=30, null=False)
    is_set = models.IntegerField(null=False, default="0")
    user = models.ForeignKey(MyUser, on_delete= models.CASCADE, null=False )
    lock = models.ForeignKey(Lock, on_delete= models.CASCADE, null=False)

class Code(models.Model):
    code = models.CharField(null=True, max_length=30)
    description= models.CharField(max_length=30, null=False)
    start_date = models.DateTimeField(max_length=30, null=False)
    end_date= models.DateTimeField(max_length=30, null=False)
    is_set = models.IntegerField(null=False, default="0")
    user = models.ForeignKey(MyUser, on_delete= models.CASCADE, null=False )
    lock = models.ForeignKey(Lock, on_delete= models.CASCADE, null=False )

class Action(models.Model):
    id_action= models.AutoField(primary_key=True)
    action_name= models.CharField(max_length=30, null=False)
    lock = models.ForeignKey(Lock, on_delete= models.CASCADE, null=False)
    user = models.ForeignKey(MyUser, on_delete= models.CASCADE, null=False)


class Passage_mode(models.Model):
    id_passage_mode= models.AutoField(primary_key=True)
    start_date = models.DateTimeField(max_length=30 , null=False)
    end_date= models.DateTimeField(max_length=30, null=False)
    status= models.CharField(max_length=30, null=False)
    locks = models.ForeignKey(Lock, on_delete= models.CASCADE, null=False)


class Associate_passage_mode(models.Model):
    passage_mode = models.ForeignKey(Passage_mode, on_delete= models.CASCADE, null=False)
    day= models.ForeignKey(Day, on_delete= models.CASCADE, null=False)


class History(models.Model):
    day = models.ForeignKey(Day, on_delete= models.CASCADE, null=False)
    action= models.ForeignKey(Action, on_delete= models.CASCADE, null=False)
    created_at = models.DateTimeField(null=False)
   