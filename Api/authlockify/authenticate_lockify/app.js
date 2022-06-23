const express = require('express');
const app = express();
const expressLayouts = require('express-ejs-layouts');
var bodyParser = require('body-parser');

// // Settings
app.set('port', process.env.PORT || 5000);

// Middlewares
app.use(express.json());
app.use(bodyParser.urlencoded({ extented: true }));

//static files
app.use(express.static('public'))
    //for backoffice
app.use('./backend/css', express.static(__dirname + 'public/backend/css'));
app.use('./backend/js', express.static(__dirname + 'public/backend/js'));
app.use('./backend/img', express.static(__dirname + 'public/backend/img'));
//for home
app.use('./home/css', express.static(__dirname + 'public/home/css'));
app.use('./home/js', express.static(__dirname + 'public/home/js'));
app.use('./home/img', express.static(__dirname + 'public/home/img'));


// Routes
// Mobile Route
app.use(require('./src/routes/mobile/mobile_lock_route'));
// Web route
app.use(require('./src/routes/web/web_lock_route'));



// set template
app.use(expressLayouts);
app.set('views', './views');
app.set('layout', './layouts/home');
app.set('view engine', 'ejs');

//error page
app.use((req, res, next) => {
    var err = new Error("Page not Found");
    err.status = 404;
    next(err);
});


app.use((req, res, next) => {
    res.status(err.status || 500);
    res.send(err);
});

// Starting the server
app.listen(app.get('port'), () => {
    console.log('Server on port', app.get('port'));
});