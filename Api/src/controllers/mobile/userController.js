const bcryptjs = require('bcryptjs');
const mysqlConnection = require('../../../DB/database');




exports.loginLockify = (req, res) => {
        const { email, password } = req.body;
        if (!email || !password) {
            return res.json({ status: 'empty', message: 'Please enter your email address and password' });
        } else {
            let selectQuery = 'SELECT * FROM users WHERE email = ? LIMIT 1';
            mysqlConnection.query(selectQuery, [email], async(err, resultrows, fields) => {

                if (!err) {
                    if (!resultrows.length || !await bcryptjs.compare(password, resultrows[0].password)) {
                        return res.json({ status: 'invalid credential', password: password });
                    } else {
                        return res.json({ status: 'success', data: resultrows });

                    }
                } else {
                    return res.json({ status: "error" });
                }

            })
        }
    }
    // ok
exports.registerLockify = (req, res) => {
    var username = req.body.username;
    var email = req.body.email;
    var tel = req.body.tel;
    var Npassword = req.body.password;
    if (!username || !email || !tel || !Npassword) {
        return res.json({ status: 'empty', message: 'Please no empty' });
    } else {
        let selectQuery = 'SELECT email FROM users WHERE email = ? LIMIT 1';
        mysqlConnection.query(selectQuery, [email], async(err, result, fields) => {

            if (err) return res.json({ Status: "error" });
            if (result[0]) return res.json({ status: "exist", error: "Email has already been registered" });
            else {
                const password = bcryptjs.hash(Npassword, 8);
                mysqlConnection.query('INSERT INTO users SET ?', { name: username, email: email, numero_telephone: tel, password: password, id_role: "2" }, (error, results) => {
                    if (error) return res.json({ status: "error" })
                    else return res.json({ status: "success", success: "user has been registered" })
                });
            }
        })
    }
}