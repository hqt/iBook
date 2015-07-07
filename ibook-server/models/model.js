/**
 * Created by huynhthao on 7/6/15.
 */


var DB = require('./../config/mysql');

var User = DB.Model.extend({
   tableName: 'tblUsers',
    idAttribute: 'userId'
});

module.exports = {
    User: User
};