const bcryptjs = require('bcryptjs');
const mysqlConnection = require('../../../DB/database');
const nodemailer = require('nodemailer');


//sen a mail 
var transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'noreply.eventick@gmail.com',
        pass: 'vobizhhxnufadjor'
    },
    tls: {
        rejectUnauthorized: false
    }
})

exports.loginLockify = (req, res) => {
    const { email, password } = req.body;
    if (!email || !password) {
        return res.json({ status: 'empty', message: 'Please enter your email address and password' });
    } else {
        var active = 1;
        let selectQuery = 'SELECT * FROM auth_user WHERE email = ? AND is_active = ? LIMIT 1';
        mysqlConnection.query(selectQuery, [email, active], async(err, resultrows, fields) => {

            if (!err) {
                if (!resultrows.length || !await bcryptjs.compare(password, resultrows[0].password)) {
                    return res.json({ status: 'invalid credential', password: password });
                } else {
                    if (resultrows[0].is_active == '0') {
                        return res.json({ status: 'no_active', data: 'please verify your account' });
                    } else {
                        let sel = 'SELECT id FROM store_myuser WHERE user_id = ? ';
                        mysqlConnection.query(sel, [resultrows[0].id], (error1, result, fields) => {
                            if (!error1) {
                                console.log(result[0].id);
                                return res.json({ status: 'success', myid: result[0].id, data: resultrows });
                            } else {
                                console.log(error1);
                                return res.json({ status: 'error', error1: error1 });
                            }
                        })

                    }
                }
            } else {
                return res.json({ status: "error" });
            }
        })
    }
}

exports.registerLockify = async(req, res) => {
    var host = 'lockify.herokuapp.com';
    var username = req.body.username;
    var email = req.body.email;
    var tel = req.body.tel;
    var passw = await bcryptjs.hash(req.body.password, 10);
    if (!username || !email || !tel || !passw) {
        return res.json({ status: 'empty', message: 'Please no empty' });
    } else {
        let selectQuery = 'SELECT email FROM auth_user WHERE email = ? LIMIT 1';
        mysqlConnection.query(selectQuery, [email], async(err, result, fields) => {

            if (err) return res.json({ Status: "error" });
            if (result[0]) return res.json({ status: "exist", error: "Email has already been registered" });
            else {
                mysqlConnection.query('INSERT INTO auth_user SET ?', { password: passw, is_superuser: "0", username: username, first_name: tel, email: email, is_staff: "0", is_active: "0" }, (error, results) => {
                    if (error) return res.json({ status: "error" })
                    else {

                        let selectQuery = 'SELECT first_name,id FROM auth_user WHERE email = ? LIMIT 1';
                        mysqlConnection.query(selectQuery, [email], async(err, result, fields) => {
                            if (err) return res.json({ status: "error" })
                            else {
                                mysqlConnection.query('INSERT INTO store_myuser SET ?', { phone_number: result[0].first_name, role_id: "2", user_id: result[0].id }, (error, results) => {
                                    if (error) {
                                        console.log('**************************');
                                        console.log(error);
                                        return res.json({ status: "error" })
                                    } else {
                                        var mailOptions = {
                                            from: ' "Verify your account" <>',
                                            to: email,
                                            subject: 'Lockify Verification',
                                            html: `<h2> ${username} ! Thank for registering on our site </h2>
                                                   <h4> Please verify your mail to continue...</h4>
                                                   <a href="https://${host}/user/verify-email?email=${email}">Verify your email</a>`
                                        }

                                        transporter.sendMail(mailOptions, function(error, info) {
                                            if (error) {
                                                console.log(error);
                                            } else {
                                                console.log('Verification email is sent to your account');
                                                return res.json({ status: "success", success: "verify your account" });
                                            }
                                        })
                                    }
                                })

                            }
                        })
                    }
                });
            }
        })
    }
}


exports.verifyEmail = async(req, res) => {
    try {
        const email = req.query.email;
        if (!email) {
            return res.json({ status: 'empty', message: 'Please no empty' });
        } else {
            let selectQuery = 'SELECT email FROM auth_user WHERE email = ? LIMIT 1';
            mysqlConnection.query(selectQuery, [email], async(err, result, fields) => {
                if (err) return res.json({ Status: "error" });
                if (result[0]) {
                    var verif = "1";
                    let updateQuery = 'UPDATE auth_user SET is_active = ? WHERE email = ? LIMIT 1';
                    mysqlConnection.query(updateQuery, [verif, email], async(err, result, fields) => {
                        if (err) return res.json({ Status: "error" });
                        else {
                            return res.json({ status: "success", smg: "Success verify Email, you can now login" });
                        }
                    })
                }
            })
        }
    } catch (err) {
        console.log(err);
    }

}