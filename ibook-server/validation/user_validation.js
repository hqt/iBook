/**
 * Created by Huynh Quang Thao on 7/20/15.
 */

var async = require('async');

var userValidation = function userValidation(username, password, email, firstName, lastName, avatarURL, // username table
                                             quote, about, homepage,                                    // profile table
                                             profileView, lastLoginIP,                                  // activity table
                                             callback) {
    // database connection
    var dbc;
    // user id for later reference
    var userId;

};