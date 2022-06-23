const mysqlConnection = require('../../../DB/database');
var moment = require('moment');




exports.viewAllCode = (req, res) => {
    var id = req.body.lock_id;
    mysqlConnection.query('select * from store_code where lock_id = ? ', [id], (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    })
}

exports.viewCode = (req, res) => {
    var id = req.body.lock_id;
    var id_user = req.body.user_id;
    mysqlConnection.query('select * from store_code where lock_id = ? AND user_id = ?', [id, id_user], (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    })
}


//delete specifique code
exports.deleteCode = (req, res) => {
    var code = req.body.code;
    var lock_id = req.body.lock_id;
    mysqlConnection.query('DELETE from store_code where lock_id = ? AND code = ?', [lock_id, code], (error, rows, fields) => {
        if (!error) {
            res.json({ status: "deleted" });
        } else {
            console.log(error);
        }
    })
}


//delete all code
exports.deleteAllCode = (req, res) => {
    var lock_id = req.body.lock_id;
    mysqlConnection.query('DELETE from store_code where lock_id = ?', [lock_id], (error, rows, fields) => {
        if (!error) {
            res.json({ status: "deleted" });
        } else {
            res.json({ status: "error" });
            console.log(error);
        }
    })

}



//update specifique code
exports.updateCode = (req, res) => {
    var code = req.body.code;
    var lock_id = req.body.lock_id;
    var description = req.body.description;
    var user_id = req.body.user_id;
    var start = req.body.start_date;
    var end = req.body.end_date;

    const start_date = moment.unix(start).format("YYYY-MM-DD HH:mm:ss");
    const end_date = moment.unix(end).format("YYYY-MM-DD HH:mm:ss");

    mysqlConnection.query('select * from store_code where lock_id = ? AND code = ?', [lock_id, code], (error, rows, fields) => {
        if (error) return res.json({ Status: "error" });
        if (rows[0]) {
            mysqlConnection.query('UPDATE store_code SET ?', { code: code, description: description, start_date: start_date, end_date: end_date, is_set: "1", lock_id: lock_id, user_id: user_id }, (error, results) => {
                if (error) return res.json({ status: "error" })
                else {
                    console.log('code updated successfuly');
                    return res.json({ status: "updated", success: "good code" });
                }
            });

        } else {
            return res.json({ status: " not exist", error: "code not exist for this lock" });
        }
    })

}

exports.createCode = (req, res) => {
    // return res.json({ Status: "test" });
    var code = req.body.code;
    var lock_id = req.body.lock_id;
    var description = req.body.description;
    var user_id = req.body.user_id;
    var start = req.body.start_date;
    var end = req.body.end_date;

    // const start_date = date("Y-m-d H:i:s", start / 1000);
    var a = start / 1000;
    var b = end / 1000;
    var start_date = moment.unix(a).format("YYYY-MM-DD HH:mm:ss");
    var end_date = moment.unix(b).format("YYYY-MM-DD HH:mm:ss");
    // const end_date = date("Y-m-d H:i:s", end / 1000);
    console.log(start_date)
    console.log(end_date)

    mysqlConnection.query('select * from store_code where lock_id = ? AND code = ?', [lock_id, code], (error, rows, fields) => {
        if (error) return res.json({ status: "error" });
        if (rows[0]) return res.json({ status: "exist", error: "code already exist" });
        else {
            mysqlConnection.query('INSERT INTO store_code SET ?', { code: code, description: description, start_date: start_date, end_date: end_date, is_set: "1", lock_id: lock_id, user_id: user_id }, (error, results) => {
                if (error) return res.json({ status: "error" })
                else {
                    console.log('code registered successfuly');
                    return res.json({ status: "success", success: "good code" });
                }
            });
        }
    })
}



exports.createShareCode = (req, res) => {
    // return res.json({ Status: "test" });
    var code = req.body.code;
    var lock_id = req.body.lock_id;
    var description = req.body.description;
    var email_user = req.body.email_user;
    var user_id = req.body.user_id;
    var start = req.body.start_date;
    var end = req.body.end_date;

    // const start_date = date("Y-m-d H:i:s", start / 1000);
    var a = start / 1000;
    var b = end / 1000;
    var start_date = moment.unix(a).format("YYYY-MM-DD HH:mm:ss");
    var end_date = moment.unix(b).format("YYYY-MM-DD HH:mm:ss");
    // const end_date = date("Y-m-d H:i:s", end / 1000);
    console.log(start_date)
    console.log(end_date)

    mysqlConnection.query('select * from store_code where lock_id = ? AND code = ?', [lock_id, code], (error, rows, fields) => {
        if (error) return res.json({ status: "error" });
        if (rows[0]) return res.json({ status: "exist", error: "code already exist" });
        else {
            //select id of user
            mysqlConnection.query('select id from auth_user where email = ?', [email_user], (error, idrows, fields) => {
                if (error) return res.json({ status: "error" });
                else {
                    mysqlConnection.query('select * from store_code where lock_id = ? AND user_id = ?', [lock_id, idrows[0].id], (error, nrows, fields) => {
                        if (error) return res.json({ status: "error" });
                        if (nrows[0].lenght > 0) return res.json({ status: "exist", error: "user already have access" });
                        else {
                            mysqlConnection.query('INSERT INTO store_code SET ?', { code: code, description: description, start_date: start_date, end_date: end_date, is_set: "0", lock_id: lock_id, user_id: idrows[0].id }, (error, results) => {
                                if (error) return res.json({ status: "error" })
                                else {
                                    console.log('code registered successfuly');
                                    return res.json({ status: "success", success: "good access" });
                                }
                            });
                        }
                    });
                }
            });


        }
    })
}


exports.viewShareCode = (req, res) => {
    var id = req.body.id;
    var id_user = req.body.user_id;
    mysqlConnection.query('select store_code.code, store_code.description,store_code.start_date,store_code.end_date,store_code.is_set,store_code.user_id,store_code.lock_id, auth_user.username, auth_user.email from store_code,auth_user where store_code.lock_id=? AND store_code.user_id = ? AND auth_user.id=store_code.user_id', [id, id_user], (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    })
}

exports.viewAllShareCode = (req, res) => {
    var id = req.body.lock_id;
    mysqlConnection.query('select store_code.id, store_code.code, store_code.description,store_code.start_date,store_code.end_date,store_code.is_set, auth_user.username, auth_user.email from store_code,auth_user where store_code.lock_id=? AND store_code.user_id=auth_user.id', [id], (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    })
}