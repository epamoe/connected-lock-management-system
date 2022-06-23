const { Router } = require('express');
const router = Router();
const lockController = require('../../controllers/mobile/lockController');
const userController = require('../../controllers/mobile/userController');
const codeController = require('../../controllers/mobile/codeController');
const cardController = require('../../controllers/mobile/cardController');
const bluetoothController = require('../../controllers/mobile/bluetoothController');

//for bluetooth access
router.post('/view_all_bluetooch_access', bluetoothController.viewAllAccessBluetooth);
router.post('/create_bluetooth', bluetoothController.createBluetoothAccess);
router.post('/remove_bluettoth_access', bluetoothController.deleteSpecificAccess);
router.post('/delete_all_bluetooth_access', bluetoothController.deleteAllAccess);
router.post('/edit_bluetooch_acces', bluetoothController.updateAccess);
router.post('/get_all_bluetooth_access_person', bluetoothController.getAllAccessUser)



//for card
router.post('/create_card', cardController.createCard);
router.post('/create_share_card', cardController.createShareCard);
router.post('/view_share_card', cardController.viewAllShareCard);
router.post('/view_all_card', cardController.viewAllCard);
router.post('/delete_specifique_card', cardController.deleteCard);
router.post('/delete_all_card', cardController.deleteAllCard);
router.post('/update_card', cardController.updateCard);


//for code
router.post('/create_code', codeController.createCode);
router.post('/create_share_code', codeController.createShareCode);
router.post('/view_share_code', codeController.viewShareCode);
router.post('/view_all_share_code', codeController.viewAllShareCode);
router.post('/view_all_code', codeController.viewAllCode);
router.post('/delete_specifique_code', codeController.deleteCode);
router.post('/delete_all_code', codeController.deleteAllCode);
router.post('/update_code', codeController.updateCode);
router.post('/get_all_code_access_person', codeController.getAllCodeAccessUser);
router.post('/update_password_to_lock', codeController.updatePasswordToLock);



//for lock
/* The above code is creating a route for the lockController.js file. */
router.post('/lock', lockController.view);
router.post('/add_lock', lockController.addLock);
router.put('/update_lock/:id', lockController.updateLock);
router.post('/rename_lock', lockController.renameLock);
router.delete('/reset_lock', lockController.resetLock);
router.post('/set_power', lockController.setLockPower);


//for user
router.post('/login_lockify', userController.loginLockify);
router.post('/register_lockify', userController.registerLockify);
router.get('/user/verify-email', userController.verifyEmail);





module.exports = router;