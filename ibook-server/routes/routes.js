/**
 * Created by Huynh Quang Thao on 7/20/15.
 */

var express = require('express');

var profile_controller = require('../routes/profile_controller');
var post_controller = require('../routes/post_controller');
var user_api = require('../routes/api/user_api');
var book_api = require('../routes/api/book_api');

module.exports = function(app){
    app.get('/', post_controller.newsFeed);
    app.get('/profile/:id', profile_controller.singleProfile);

    // api functions
    app.post('/signup_api', user_api.signInAPI);
    app.get('/bookgenre_api', book_api.getAllBookGenre);
    app.post('/bookgenre_api', book_api.subscribeBookGenre);
};
