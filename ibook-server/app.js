/** set variables for environment */
var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var passport = require('passport');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var session = require('express-session');
var flash = require('connect-flash');

/** constant variable */
var local_port = 3000;
var port = process.env.PORT || local_port;

var app = express();

// view engine setup
// view as directory for all template files
app.set('views', path.join(__dirname, 'views'));
// use either 'jade' or 'ejs'
app.set('view engine', 'ejs');

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
//app.use(passport.initialize());
//app.use(passport.session());
var LocalStrategy = require('passport-local').Strategy;

// custom libraries
// routes
var route = require('./routes/index');
// model
var  ModelDB= require('./models/model');

passport.use(new LocalStrategy(function(username, password, done) {
    new ModelDB.User({username: username}).fetch().then(function(data) {
        var user = data;
        if(user === null) {
            return done(null, false, {message: 'Invalid username or password'});
        } else {
            user = data.toJSON();
            if(!bcrypt.compareSync(password, user.password)) {
                return done(null, false, {message: 'Invalid username or password'});
            } else {
                return done(null, user);
            }
        }
    });
}));

passport.serializeUser(function(user, done) {
    done(null, user.username);
});

passport.deserializeUser(function(username, done) {
    new ModelDB.User({username: username}).fetch().then(function(user) {
        done(null, user);
    });
});

// Initialize Passport
//var initPassport = require('./passport/init');
//initPassport(passport);

// Using the flash middleware provided by connect-flash to store messages in session and displaying in templates
app.use(flash());

// configuring route
//var routes = require('./routes/index')(passport);
//app.use('/', routes);

/*
// GET
app.get('/', route.index);

// signin
// GET
app.get('/signin', route.signIn);
// POST
app.post('/signin', route.signInPost);

// signup
// GET
app.get('/signup', route.signUp);
// POST
app.post('/signup', route.signUpPost);

// logout
// GET
app.get('/signout', route.signOut);

*/

/// catch 404 and forward to error handler
app.use(function (req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});
=======
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
>>>>>>> server

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