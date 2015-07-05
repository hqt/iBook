/** set variables for environment */
var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var mongoose = require('mongoose');
var logger = require('morgan');
var passport = require('passport');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var session = require('express-session');
var flash = require('connect-flash');

/** constant variable */
var local_port = 3000;
var port = process.env.PORT || local_port;

// connecting database using Mongoose API
var dbConfig = require('./config/db');
mongoose.connect(dbConfig.url, function(err, res) {
    if (err) {
        console.log('connection to database ' + dbConfig.url + ' error', err);
    } else {
        console.log('connection to database ' + dbConfig.url + ' successfully');
    }
});

var app = express();

// view engine setup
// view as directory for all template files
app.set('views', path.join(__dirname, 'views'));
// use either 'jade' or 'ejs'
app.set('view engine', 'jade');

/** middleware configuration */

app.use(favicon(__dirname + '/public/favicon.png'));
app.use(logger('dev'));
// must use cookieParse before express-session
app.use(cookieParser());

// handling session in web application
app.use(session({
    secret: "ThaoHQSE60963",
    resave: true,
    saveUninitialized: true
}));

// instruct the app to use `bodyParser()` middleware for all routes
// app.use(bodyParser()); // now deprecated
app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json());

// instruct express to server up static assets
app.use(express.static(path.join(__dirname, 'public')));
// app.use(express.static('public'));

// Configuring Passport
app.use(passport.initialize());
app.use(passport.session());

// Using the flash middleware provided by connect-flash to store messages in session and displaying in templates
app.use(flash());

// Initialize Passport
var initPassport = require('./passport/init');
initPassport(passport);

// configuring route
var routes = require('./routes/index')(passport);
app.use('/', routes);

/// catch 404 and forward to error handler
app.use(function(req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

/*
// set routes
app.get('/', function(req, res) {
  	res.render('index');
});
*/

// development error handler. will print stacktrace
if (app.get('env') === 'development') {
    app.use(function(err, req, res, next) {
        res.status(err.status || 500);
        res.render('error', {
            message: err.message,
            error: err
        });
    });
}

// set server port
app.listen(port);
console.log("server is running at =>> http://localhost:" + port);

module.exports = app;