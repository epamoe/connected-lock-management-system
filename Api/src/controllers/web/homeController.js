const bcryptjs = require('bcryptjs');
const mysqlConnection = require('../../../DB/database');


exports.view = (req, res) => {
    res.render('index.ejs');
}