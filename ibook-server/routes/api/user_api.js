/**
 * Created by Huynh Quang Thao on 7/27/15.
 */

var async = require('async');
var config = require('../../config/config');
var user_service = require('../../services/user_service');
var string_helper = require('../../helper/string_helper');

exports.signInAPI = function signInAPI (req, res) {

    var providerId;
    var private_key;
    var provider;
    var socialUserId;
    var firstname;
    var middlename;
    var lastname;
    var fullname;
    var image_url;
    var email;

    var  finalCallback = function (error, userData) {
        if (error) {
            console.log(error);
            return res.json({error: error});
        }
        return res.json(userData);
    };

    async.waterfall([

        // get all parameters from client
        function (callback) {
            private_key = string_helper.getPostParameter(req, 'private_key');
            provider = string_helper.getPostParameter(req, 'provider');
            socialUserId = string_helper.getPostParameter(req, 'social_userid');
            firstname = string_helper.getPostParameter(req, 'firstname');
            middlename = string_helper.getPostParameter(req, 'middlename');
            lastname = string_helper.getPostParameter(req, 'lastname');
            fullname = string_helper.getPostParameter(req, 'fullname');
            image_url = string_helper.getPostParameter(req, 'image_url');
            email = string_helper.getPostParameter(req, 'email');

            if (private_key !== config.privateKey) {
                return callback('private key mismatch');
            }

            if ((provider !== 'facebook') && (provider !== 'google plus')) {
                return callback('unsupported social network authentication');
            }

            if (socialUserId === '') {
                return callback('missing social network id field');
            }

            if (provider === 'facebook') {
                providerId = 1;
            } else {
                providerId = 2;
            }

            user_service.isUserExist(socialUserId, providerId, callback);
        },

        // test user are sign up or not. if not. create new user
        function (userId, callback) {
            if (userId > 0) {
                var params = {
                    user_id: userId,
                    result: 'signup'
                };
                finalCallback(null, params);
            }

            user_service.createUser('', '', email, firstname, middlename, lastname, image_url, 1,
                '', '', '',
                string_helper.getIPAddress(req),
                socialUserId, providerId, callback);
        },

        function (userId, callback) {
            var params = {
                user_id: userId,
                result: 'new'
            };
            callback(null, params);
        }
    ], finalCallback);
};
