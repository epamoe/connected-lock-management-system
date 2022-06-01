from django.urls import path

from . import views
import store.controller.homeController as homeController


urlpatterns = [
	#Leave as empty string for base url
	path('', homeController.home),
	path('dashboard/', homeController.dashboard, name="dashboard"),

	# path('cart/', views.cart, name="cart"),
	# path('checkout/', views.checkout, name="checkout"),
	path('room/', views.viewRoom, name="view_room"),
	path('create_room/', views.createRoom, name="create_room"),
	path('updateRoom/<str:pk>', views.updateRoom, name="update_room"),
	path('deleteRoom/<str:pk>', views.deleteRoom, name="delete_room"),



	path('day/', views.viewDay, name="view_day"),
	path('create_day/', views.createDay, name="create_day"),
	path('updateDay/<str:pk>', views.updateDay, name="update_day"),
	path('deleteDay/<str:pk>', views.deleteDay, name="delete_day"),


	path('role/', views.viewRole, name="view_role"),
	path('create_role/', views.createRole, name="create_role"),
	path('updateRole/<str:pk>', views.updateRole, name="update_role"),
	path('deleteRole/<str:pk>', views.deleteRole, name="delete_role"),


	path('user/', views.viewUser, name="view_user"),
	path('create_user/', views.createUser, name="create_user"),
	path('updateUser/<str:pk>', views.updateUser, name="update_user"),
	# path('updateUser/<str:pk>', views.UpdateUser.as_view(), name="update_user"),
	path('deleteUser/<str:pk>', views.deleteUser, name="delete_user"),

	path('lock/', views.viewLock, name="view_lock"),
	path('create_lock/', views.createLock, name="create_lock"),
	path('updateLock/<str:pk>', views.updateLock, name="update_lock"),
	path('deleteLock/<str:pk>', views.deleteLock, name="delete_lock"),

	path('action/', views.viewAction, name="view_action"),
	path('create_action/', views.createAction, name="create_action"),
	path('updateAction/<str:pk>', views.updateAction, name="update_action"),
	path('deleteAction/<str:pk>', views.deleteAction, name="delete_action"),
]