// const bcryptjs = require('bcryptjs');
const mysqlConnection = require('../../../DB/database');


exports.view = (req, res) => {
    var id = req.body.id;
    mysqlConnection.query('select * from store_lock where user_id = ?', [id], (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    })
}

exports.addLock = (req, res) => {
    var lock_name = req.body.lock_name;
    var lock_mac = req.body.lock_mac;
    var auto_lock_time = req.body.auto_lock_time;
    var lock_data = req.body.lock_data;
    var lock_status = req.body.lock_status;
    var percent = req.body.percent;
    var id_user = req.body.id_user;
    // res.json({ response: req.body });

    if (!lock_name || !lock_mac || !auto_lock_time || !lock_data || !lock_status || !percent || !id_user) {
        return res.json({ status: 'empty', message: 'Please no empty' });
    } else {
        let selectQuery = 'SELECT lock_mac FROM store_lock WHERE lock_mac = ? AND user_id = ? LIMIT 1';
        mysqlConnection.query(selectQuery, [lock_mac, id_user], async(err, result, fields) => {

            if (err) return res.json({ Status: "error selection" });
            if (result[0]) {
                let updateQuery = 'update store_lock set lock_name = ?, lock_mac = ?, auto_lock_time = ?, lock_data = ?, lock_status = ?, lock_percent = ?, user_id = ? where lock_mac = ? AND user_id = ?';
                mysqlConnection.query(updateQuery, [lock_name, lock_mac, auto_lock_time, lock_data, lock_status, percent, id_user, lock_mac, id_user], (error, rows, fields) => {
                    if (!error) {
                        res.json({
                            status: 'lock updated'
                        });
                    } else {
                        console.log(error);
                    }
                });
            } else {
                // let insertQuery = 'INSERT INTO store_lock ';
                mysqlConnection.query('INSERT INTO store_lock SET ?', { lock_name: lock_name, lock_mac: lock_mac, auto_lock_time: auto_lock_time, lock_data: lock_data, lock_status: lock_status, lock_percent: percent, user_id: id_user }, (error, results) => {
                    if (error) {
                        console.log(error);
                        return res.json({ status: "error" })
                    } else return res.json({ status: "success", success: "lock registered" })
                });
            }
        })
    }
}

exports.resetLock = (req, res) => {
    var lock_mac = req.body.lock_mac;
    var lock_data = req.body.lock_data;
    var id_user = req.body.id_user;
    var id_serrure = req.body.id_serrure;

    let reseted = 'delete from store_lock where id_lock = ? AND lock_data = ?'
    mysqlConnection.query(reseted, [id_serrure, lock_data], (error, rows, fields) => {
        if (!error) {
            res.json({
                status: "deleted"
            });
        } else {
            res.json({
                status: "error"
            });
        }
    })
}


exports.setLockPower = (req, res) => {
    var lock_mac = req.body.lock_mac;
    var power = req.body.power;
    var id_user = req.body.id_user;

    let setpower = 'update store_lock set lock_percent = ? WHERE lock_mac = ? AND user_id = ?';
    mysqlConnection.query(setpower, [power, lock_mac, id_user], (error, rows, field) => {
        if (!error) {
            res.json({
                status: 'success'
            });
        } else {
            res.json({
                status: 'failed'
            });
        }
    })
}
exports.renameLock = (req, res) => {
    var lock_mac = req.body.lock_mac;
    var lock_name = req.body.lock_name;
    var id_user = req.body.id_user;

    let rename = 'update store_lock set lock_name = ? WHERE lock_mac = ? AND user_id = ?';
    mysqlConnection.query(rename, [lock_name, lock_mac, id_user], (error, rows, field) => {
        if (!error) {
            res.json({
                status: 'success'
            });
        } else {
            res.json({
                status: 'failed'
            });
        }
    })
}

exports.updateLock = (req, res) => {
    const { id, username, name, lastname, mail, randomstr, hash } = req.body;
    console.log(req.body);
    mysqlConnection.query('update users set username = ?, name = ?, lastname = ?, mail = ?, randomstr = ?, hash = ? where id = ?;', [username, name, lastname, mail, randomstr, hash, id], (error, rows, fields) => {
        if (!error) {
            res.json({
                Status: 'User updated'
            });
        } else {
            console.log(error);
        }
    });
}

exports.deleteLock = (req, res) => {
    var id = req.body.id;
    mysqlConnection.query('delete from store_lock where id_lock = ?', [id], (error, rows, fields) => {
        if (!error) {
            res.json({
                Status: "deleted"
            });
        } else {
            res.json({
                Status: "error"
            });
        }
    })
}


// router.post('/login_lockify', (req, res) => {
//     const { email, password } = req.body;
//     if (!email || !password) {
//         return res.json({ status: 'empty', message: 'Please enter your email address and password' });
//     } else {
//         let selectQuery = 'SELECT * FROM users WHERE email = ? LIMIT 1';
//         mysqlConnection.query(selectQuery, [email], async(err, resultrows, fields) => {

//             if (!err) {
//                 if (!resultrows.length || !await bcryptjs.compare(password, resultrows[0].password)) {
//                     return res.json({ status: 'invalid credential', password: password });
//                 } else {
//                     return res.json({ status: 'success', data: resultrows });

//                 }
//             } else {
//                 return res.json({ status: "error" });
//             }

//         })
//     }
// })







// module.exports = router;