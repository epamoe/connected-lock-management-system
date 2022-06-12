from django.urls import path
from . import views
import store.controller.homeController as homeController


urlpatterns = [
	#Leave as empty string for base url
	path('', homeController.home),
	path('dashboard/', homeController.dashboard, name="dashboard"),
	path('details/', homeController.details, name="details"),

	path('log', views.log, name="log"),
	path('logout_lockify', views.logout_lockify, name="logout_lockify"),
	# path('checkout/', views.checkout, name="checkout"),



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
	path('lock_user/', homeController.viewLockUser, name="view_lockuser"),
	path('create_lock/', views.createLock, name="create_lock"),
	path('updateLock/<str:pk>', views.updateLock, name="update_lock"),
	path('deleteLock/<str:pk>', views.deleteLock, name="delete_lock"),

	path('action/', views.viewAction, name="view_action"),
	path('create_action/', views.createAction, name="create_action"),
	path('updateAction/<str:pk>', views.updateAction, name="update_action"),
	path('deleteAction/<str:pk>', views.deleteAction, name="delete_action"),

	path('passage_mode/', views.viewPassage_mode, name="view_passage_mode"),
	path('create_passage_mode/', views.createPassage_mode, name="create_passage_mode"),
	path('updatePassage_mode/<str:pk>', views.updatePassage_mode, name="update_passage_mode"),
	path('deletePassage_mode/<str:pk>', views.deletePassage_mode, name="delete_passage_mode"),

	path('code/', views.viewCode, name="view_code"),
	path('code_user/', homeController.viewCodeUser, name="view_codeuser"),
	path('create_code/', views.createCode, name="create_code"),
	path('updateCode/<str:pk>', views.updateCode, name="update_code"),
	path('deleteCode/<str:pk>', views.deleteCode, name="delete_code"),

	path('card/', views.viewCard, name="view_card"),
	path('card_user/', homeController.viewCardUser, name="view_carduser"),
	path('create_card/', views.createCard, name="create_card"),
	path('updateCard/<str:pk>', views.updateCard, name="update_card"),
	path('deleteCard/<str:pk>', views.deleteCard, name="delete_card"),

	path('fingerPrint/', views.viewFingerPrint, name="view_fingerPrint"),
	path('fingerPrint_user/', homeController.viewFingerPrintUser, name="view_fingerPrintuser"),
	path('create_fingerPrint/', views.createFingerPrint, name="create_fingerPrint"),
	path('updateFingerPrint/<str:pk>', views.updateFingerPrint, name="update_fingerPrint"),
	path('deleteFingerPrint/<str:pk>', views.deleteFingerPrint, name="delete_fingerPrint"),

	path('bluetooth/', views.viewBluetooth, name="view_bluetooth"),
	path('create_bluetooth/', views.createBluetooth, name="create_bluetooth"),
	path('updateBluetooth/<str:pk>', views.updateBluetooth, name="update_bluetooth"),
	path('deleteBluetooth/<str:pk>', views.deleteBluetooth, name="delete_bluetooth"),

	path('history/', views.viewHistory, name="view_history"),
	# path('deleteHistory/<str:pk>', views.deleteHistory, name="delete_history"),
]