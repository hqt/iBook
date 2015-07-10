/**
 * Created by huynhthao on 7/6/15.
 */


var DB = require('./../config/mysql');

/*var User = DB.Model.extend({
   tableName: 'tblUsers',
    idAttribute: 'userId'
});*/

var User = DB.Model.extend({
   tableName: 'User',
    share: function() {
        return this.hasMany('Share', 'ShareID');
    }
});




module.exports = {
    User: User
};