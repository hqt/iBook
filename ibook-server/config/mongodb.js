/**
 * Created by huynhthao on 6/28/15.
 */

var database_name = "notedb";

module.exports = {
    'url' : process.env.MONGOLAB_URI
    ||  process.env.MONGOHQ_URI
    ||  'mongodb://localhost/' + database_name
};
