/**
 * Created by huynhthao on 6/29/15.
 */

var facebook = require('./facebook');
var twitter = require('./twitter');
var login = require('./login');
var signup = require('./signup');
var User = require('../models/user');

module.exports = function(passport){

    // Passport needs to be able to serialize and deserialize users to support persistent login sessions
    passport.serializeUser(function(user, done) {
        console.log('serializing user: ');
        console.log(user);
        // done(null, user._id);
        done(null, user.username);
    });

    passport.deserializeUser(function(id, done) {
        // MongoDB way for query
        /*User.findById(id, function(err, user) {
            console.log('deserializing user:',user);
            done(err, user);
        });*/

        // Bookshelf way for query. Using Javascript Promise API
        new Model.User({username: username})
            .fetch()
            .then(function(user) {
                console.log('deserializing user:',user);
                done(null, user);
            });
    });

    // Setting up Passport Strategies for Login and SignUp/Registration
    login(passport);
    signup(passport);

    // Setting up Passport Strategies for Facebook and Twitter
    // facebook(passport);
    // twitter(passport);

};