/**
 * Created by huynhthao on 7/11/15.
 */

var Sequelize = require('sequelize');

var getUser = function (req, res) {
    User.findAll().success(function (users) {
        res.send(users);
    });
};