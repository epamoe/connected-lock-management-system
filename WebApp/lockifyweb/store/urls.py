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

]