const { Router } = require('express');
const router = Router();
const bcryptjs = require('bcryptjs');

const mysqlConnection = require('../database');

router.get('/', (req, res) => {
    res.status(200).json('Server on port 4000 and Database is connected.');
});



//This function allows us concatenate 'id' to url => localhost:4000/id
router.get('/users/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('select * from users where id = ?', [id], (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    })
});

router.post('/login_lockify', (req, res) => {
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
})

router.post('/register_lockify', (req, res) => {
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
})

router.post('/users', (req, res) => {
    const { id, username, name, lastname, mail, randomstr, hash } = req.body;
    console.log(req.body);
    mysqlConnection.query('insert into users(id, username, name, lastname, mail, randomstr, hash) values (?, ?, ?, ?, ?, ?, ?)', [id, username, name, lastname, mail, randomstr, hash], (error, rows, fields) => {
        if (!error) {
            res.json({ Status: "User saved" })
        } else {
            console.log(error);
        }
    });
})

router.put('/users/:id', (req, res) => {
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
});

router.delete('/users/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('delete from users where id = ?', [id], (error, rows, fields) => {
        if (!error) {
            res.json({
                Status: "User deleted"
            });
        } else {
            res.json({
                Status: error
            });
        }
    })
});

module.exports = router;