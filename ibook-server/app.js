var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var passport = require('passport');
var colors = require('colors');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var session = require('express-session');
var flash = require('connect-flash');
var mysql = require('mysql');
var bcrypt = require('bcrypt-nodejs');

/** constant variable */
var local_port = 3000;
var port = process.env.PORT || local_port;
console.log(('port: ' + port).red);

var app = express();

// view engine setup
// instruct express to server up static assets
app.use(express.static(path.join(__dirname, 'public')));
app.set('view engine', 'mustache');
// view as directory for all template files
app.set('views', path.join(__dirname, 'views'));
//app.register(".mustache", require('stache'));    /// why ???

/** middleware configuration */

app.use(favicon(__dirname + '/public/favicon.png'));

app.use(logger('dev'));

// must use cookieParse before express-session
app.use(cookieParser());

app.use(session({
    secret: "ThaoHQSE60963",
    resave: true,
    saveUninitialized: true
}));

app.use(flash());

app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json());

var async = require('async');
var authorService = require('./services/author_service');

//authorService.getAllAuthors();

var solve = function() {
  async.waterfall([
      // a long working task. huh
      function (callback) {
          setTimeout(function() {
              console.log('hello world!');
              callback();
          }, 2000);
      },

      function (callback) {
          authorService.helperAsync();
          callback();
      },

      function (callback) {
          setTimeout(function() {
              console.log('bye bye!');
          }, 2000);
      }

  ]);
};

solve();

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

// set server port
app.listen(port);
console.log("server is running at =>> http://localhost:" + port);

module.exports = app;