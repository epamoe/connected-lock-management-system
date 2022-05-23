from django.urls import path

from . import views
import store.controller.homeController as homeController


urlpatterns = [
	#Leave as empty string for base url
	path('', homeController.home),
	# path('cart/', views.cart, name="cart"),
	# path('checkout/', views.checkout, name="checkout"),

]