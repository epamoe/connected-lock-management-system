const mysqlConnection = require('../../../DB/database');
var moment = require('moment');





//delete specifique card
exports.deleteSpecificAccess = (req, res) => {
    var id = req.body.id;
    mysqlConnection.query('select * from store_bluetooth where id = ?', [id], (error, rows, fields) => {
        if (error) return res.json({ Status: "error" });
        if (rows[0]) {
            mysqlConnection.query('DELETE from store_bluetooth where id = ?', [id], (error, rows, fields) => {
                if (!error) {
                    res.json({ status: "deleted" });
                } else {
                    console.log(error);
                }
            })
        } else {
            return res.json({ status: "not exist", error: "access no exist" });
        }
    })
}


//delete all card
exports.deleteAllAccess = (req, res) => {
    var lock_id = req.body.lock_id;
    mysqlConnection.query('DELETE from store_bluetooth where lock_id = ?', [lock_id], (error, rows, fields) => {
        if (!error) {
            res.json({ status: "deleted" });
        } else {
            res.json({ status: "error" });
            console.log(error);
        }
    })

}



//update specifique card
exports.updateAccess = (req, res) => {
    var card = req.body.card;
    var lock_id = req.body.lock_id;
    var description = req.body.description;
    var user_id = req.body.user_id;
    var start = req.body.start_date;
    var end = req.body.end_date;

    const start_date = moment.unix(start).format("YYYY-MM-DD HH:mm:ss");
    const end_date = moment.unix(end).format("YYYY-MM-DD HH:mm:ss");

    mysqlConnection.query('select * from store_bluetooth where lock_id = ? AND card = ?', [lock_id, card], (error, rows, fields) => {
        if (error) return res.json({ Status: "error" });
        if (rows[0]) {
            mysqlConnection.query('UPDATE store_bluetooth SET ?', { card: card, description: description, start_date: start_date, end_date: end_date, is_set: "1", lock_id: lock_id, user_id: user_id }, (error, results) => {
                if (error) return res.json({ status: "error" })
                else {
                    console.log('card updated successfuly');
                    return res.json({ status: "updated", success: "good card" });
                }
            });

        } else {
            return res.json({ status: " not exist", error: "card not exist for this lock" });
        }
    })

}

exports.createBluetoothAccess = (req, res) => {
    var lock_id = req.body.lock_id;
    var description = req.body.description;
    var email = req.body.email;
    var start = req.body.start_date;
    var end = req.body.end_date;

    var a = start / 1000;
    var b = end / 1000;
    const start_date = moment.unix(a).format("YYYY-MM-DD HH:mm:ss");
    const end_date = moment.unix(b).format("YYYY-MM-DD HH:mm:ss");

    mysqlConnection.query('select id from auth_user where email=?', [email], (error1, rows1, fields) => {
        if (error1) return res.json({ status: "error", error1: error1 });
        else {
            mysqlConnection.query('select id from store_myuser where user_id=?', [rows1[0].id], (error2, rows2, fields) => {
                if (error2) return res.json({ status: "error", error2: error2 });
                else {
                    mysqlConnection.query('select * from store_bluetooth where lock_id = ? AND user_id = ?', [lock_id, rows2[0].id], (error3, rows, fields) => {
                        if (error3) return res.json({ status: "error", error3: error3 });
                        if (rows[0]) return res.json({ status: "exist", error: "access already exist" });
                        else {
                            mysqlConnection.query('INSERT INTO store_bluetooth SET ?', { description: description, start_date: start_date, end_date: end_date, is_set: "1", lock_id: lock_id, user_id: rows2[0].id }, (error4, results) => {
                                if (error4) return res.json({ status: "error", error4: error4 })
                                else {
                                    console.log('card registered successfuly');
                                    return res.json({ status: "success", success: "good card" });
                                }
                            });
                        }
                    })
                }
            })
        }

    })
}





exports.viewAllAccessBluetooth = (req, res) => {
    var id = req.body.lock_id;
    mysqlConnection.query('select store_bluetooth.id, store_bluetooth.description,store_bluetooth.start_date,store_bluetooth.end_date,store_bluetooth.is_set, auth_user.username, auth_user.email from store_bluetooth,auth_user,store_myuser where store_bluetooth.lock_id=? AND store_bluetooth.user_id = store_myuser.id AND auth_user.id=store_myuser.user_id', [id], (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    })
}

exports.getAllAccessUser = (req, res) => {
    var id = req.body.user_id;
    mysqlConnection.query('select store_bluetooth.id, store_bluetooth.description,store_bluetooth.start_date,store_bluetooth.end_date,store_bluetooth.is_set, store_lock.lock_name, store_lock.lock_mac, store_lock.lock_data,store_lock.lock_percent from store_bluetooth,store_lock where store_bluetooth.user_id = ? AND store_bluetooth.lock_id=store_lock.id_lock', [id], (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        } else {
            console.log(error);
            res.json(error);
        }
    })

}