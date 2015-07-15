/**
 * Created by huynhthao on 7/11/15.
 */

"use strict";

var fs        = require("fs");
var path      = require("path");
var Sequelize = require("sequelize");
var env       = process.env.NODE_ENV || "development";
var config    = require("../config/mysql.js");
console.log("host: " + config.host);
var sequelize = new Sequelize(config.database, config.username, config.password, {
        host: config.host,
        dialect: config.dialect,
        port: config.port,
        //logging: console.log,
        logging: function(str) {
            console.log(str.blue)
        },
        define: {
            timestamps: false,
            freezeTableName : true
        }
});
var db = {};

// import all models file
fs
    .readdirSync(__dirname)
    .filter(function(file) {
        return (file.indexOf(".") !== 0) && (file !== "index.js");
    })
    .forEach(function(file) {
        var model = sequelize.import(path.join(__dirname, file));
        console.log("import " + model);
        db[model.name] = model;
    });

// import association if any
Object.keys(db).forEach(function(modelName) {
    if ("associate" in db[modelName]) {
        db[modelName].associate(db);
    }
});

var test = sequelize.authenticate()
    .then(function () {
        console.log("CONNECTED! ");
    })
    .catch(function (err) {
        console.log("SOMETHING DONE GOOFED");
    })
    .done();


// describe relationships
(function(m) {
    console.log("import relationship");
    console.log(m);
    m.Author.hasMany(m.Song);
    m.Song.belongsTo(m.User);
})(module.exports);



db.sequelize = sequelize;
db.Sequelize = Sequelize;

// export connection
//module.exports.sequelize = sequelize;
module.exports = db;
