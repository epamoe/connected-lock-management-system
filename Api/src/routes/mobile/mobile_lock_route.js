const { Router } = require('express');
const router = Router();
const lockController = require('../../controllers/mobile/lockController');
const userController = require('../../controllers/mobile/userController');


//for lock
router.get('/lock/:id', lockController.view);
router.post('/add_lock', lockController.addLock);
router.put('/update_lock/:id', lockController.updateLock);
router.delete('/delete_lock/:id', lockController.deleteLock);


//for user only
router.post('/login_lockify', userController.loginLockify);
router.post('/register_lockify', userController.registerLockify);





module.exports = router;