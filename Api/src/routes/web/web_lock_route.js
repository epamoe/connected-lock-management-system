const express = require('express');
const router = express.Router();
const homeController = require('../../controllers/web/homeController');

//for home
router.get('', homeController.view);





module.exports = router;