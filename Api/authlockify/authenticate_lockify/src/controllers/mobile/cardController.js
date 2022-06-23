const mysqlConnection = require('../../../DB/database');
var moment = require('moment');




exports.viewAllCard = (req, res) => {
    var id = req.body.lock_id;
    mysqlConnection.query('select * from store_card where lock_id = ?', [id, ], (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    })
}

exports.viewCard = (req, res) => {
    var id = req.body.lock_id;
    var id_user = req.body.user_id;
    mysqlConnection.query('select * from store_card where lock_id = ? AND user_id = ?', [id, id_user], (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    })
}


//delete specifique card
exports.deleteCard = (req, res) => {
    var card = req.body.card;
    var lock_id = req.body.lock_id;


    mysqlConnection.query('select * from store_card where lock_id = ? AND card = ?', [lock_id, card], (error, rows, fields) => {
        if (error) return res.json({ Status: "error" });
        if (rows[0]) {
            mysqlConnection.query('DELETE from store_card where lock_id = ? AND card = ?', [lock_id, card], (error, rows, fields) => {
                if (!error) {
                    res.json({ status: "deleted" });
                } else {
                    console.log(error);
                }
            })
        } else {
            return res.json({ status: " not exist", error: "card not exist for this lock" });
        }
    })
}


//delete all card
exports.deleteAllCard = (req, res) => {
    var lock_id = req.body.lock_id;
    mysqlConnection.query('DELETE from store_card where lock_id = ?', [lock_id], (error, rows, fields) => {
        if (!error) {
            res.json({ status: "deleted" });
        } else {
            console.log(error);
        }
    })

}



//update specifique card
exports.updateCard = (req, res) => {
    var card = req.body.card;
    var lock_id = req.body.lock_id;
    var description = req.body.description;
    var user_id = req.body.user_id;
    var start = req.body.start_date;
    var end = req.body.end_date;

    const start_date = moment.unix(start).format("YYYY-MM-DD HH:mm:ss");
    const end_date = moment.unix(end).format("YYYY-MM-DD HH:mm:ss");

    mysqlConnection.query('select * from store_card where lock_id = ? AND card = ?', [lock_id, card], (error, rows, fields) => {
        if (error) return res.json({ Status: "error" });
        if (rows[0]) {
            mysqlConnection.query('UPDATE store_card SET ?', { card: card, description: description, start_date: start_date, end_date: end_date, is_set: "1", lock_id: lock_id, user_id: user_id }, (error, results) => {
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

exports.createCard = (req, res) => {
    // return res.json({ Status: "test" });
    var card = req.body.card;
    var lock_id = req.body.lock_id;
    var description = req.body.description;
    var user_id = req.body.user_id;
    var start = req.body.start_date;
    var end = req.body.end_date;

    // const start_date = date("Y-m-d H:i:s", start / 1000);
    const start_date = moment.unix(start).format("YYYY-MM-DD HH:mm:ss");
    const end_date = moment.unix(end).format("YYYY-MM-DD HH:mm:ss");
    // const end_date = date("Y-m-d H:i:s", end / 1000);

    mysqlConnection.query('select * from store_card where lock_id = ? AND card = ?', [lock_id, card], (error, rows, fields) => {
        if (error) return res.json({ Status: "error" });
        if (rows[0]) return res.json({ status: "exist", error: "card already exist" });
        else {
            mysqlConnection.query('INSERT INTO store_card SET ?', { card: card, description: description, start_date: start_date, end_date: end_date, is_set: "1", lock_id: lock_id, user_id: user_id }, (error, results) => {
                if (error) return res.json({ status: "error" })
                else {
                    console.log('card registered successfuly');
                    return res.json({ status: "success", success: "good card" });
                }
            });
        }
    })
}

exports.viewShareCard = (req, res) => {
    var id = req.body.id;
    var id_user = req.body.user_id;
    mysqlConnection.query('select store_card.card, store_card.description,store_card.start_date,store_card.end_date,store_card.is_set,store_card.user_id,store_card.lock_id, auth_user.username, auth_user.email from store_card,auth_user where store_card.lock_id=? AND store_card.user_id = ? AND auth_user.id=store_card.user_id', [id, id_user], (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    })
}