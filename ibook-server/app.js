/** set variables for environment */
var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var session = require('express-session');
var flash = require('connect-flash');
var engines = require('consolidate');
var colors = require('colour');

/** constant variable */
var local_port = 3000;
var port = process.env.PORT || local_port;

var app = express();

// view engine setup
// instruct express to server up static assets
app.use(express.static(path.join(__dirname, 'public')));
// view as directory for all template files
app.set('views', path.join(__dirname, 'views'));
// hbs files should be handled by `handlebars`
// consolidate take care of loading `handlebars` and interfacing with express
app.engine('hbs', engines.handlebars);
app.engine('.html', engines.handlebars);
// default file extensions for template files
app.set('view engine', 'hbs');
app.set("view options", {layout: false});

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

app.use(flash());


// instruct the app to use `bodyParser()` middleware for all routes
// app.use(bodyParser()); // now deprecated
app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json());


// development error handler. will print stacktrace
if (app.get('env') === 'development') {
    app.use(function (err, req, res, next) {
        res.status(err.status || 500);
        res.render('error', {
            message: err.message,
            error: err
        });
    });
}

// routing
require('./routes/routes')(app);

// set server port
app.listen(port);
console.log("server is running at =>> http://localhost:" + port);

module.exports = app;