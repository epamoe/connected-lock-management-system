const mysql = require('mysql');

const mysqlConnection = mysql.createConnection({
        host: 'database-1.clb5mrb89pnl.us-east-1.rds.amazonaws.com',
        user: 'admin',
        password: 'lockify237',
        database: 'lockify'
    })
    // Host: sql4.freesqldatabase.com
    // Database name: sql4498253
    // Database user: sql4498253
    // Database password: CHU89szmpF
    // Port number: 3306

// const mysqlConnection = mysql.createConnection({
//     host: 'localhost',
//     user: 'root',
//     password: '',
//     database: 'lockify'
// })

mysqlConnection.connect(function(error) {
    if (error) {
        console.log(error);
        return;
    } else {
        console.log('Database is connected');
    }
});

module.exports = mysqlConnection;