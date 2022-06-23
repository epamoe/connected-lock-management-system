const mysql = require('mysql');

const mysqlConnection = mysql.createConnection({
    host: 'sql6.freesqldatabase.com',
    user: 'sql6493719',
    password: '4PUGaRVWvJ',
    database: 'sql6493719'
})

// const mysqlConnection = mysql.createConnection({
//     host: 'localhost',
//     user: 'root',
//     password: '',
//     database: 'lockify_bd'
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