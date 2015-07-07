/**
 * Created by huynhthao on 7/6/15.
 */


require('../config/mysql').connection.connect();
var DB = require('../config/mysql');

console.log('hehe: ' + DB);

var User = DB.Model.extend({
   tableName: 'tblUsers',
    idAttribute: 'userId'
});

module.exports = {
    User: User
};