/**
 * Created by huynhthao on 7/6/15.
 */

var config = {
    host: 'localhost',
    username: 'root',
    password: 'root',
    port: 8889,
    database: "BookDB",
    charset: 'UTF8_GENERAL_CI',
    dialect: "mysql"
};

var mysql = require('mysql');

var pool = mysql.createPool({
   connectionLimit: 10,
    host     : 'localhost',
    user     : 'root',
    password : 'root',
    database : 'BookDB',
    port: 8889
});

// run this function for testing connection
var testConnection = function testConnection() {
    pool.getConnection(function(err, connection){
        if (err) {
            throw err;
        }

        connection.query('SELECT 1 + 1 AS solution', function(err, rows, fields) {
            if (err) throw err;

            console.log('The solution is: ', rows[0].solution);

            connection.release();
        });
    });

};

testConnection();

module.exports.pool = pool;

