/**
 * Created by Huynh Quang Thao on 7/20/15.
 */

module.exports.getPostParameter = function (req, param_name) {
    var value = req.body[param_name];
    if (typeof value === 'undefined') value = '';
    return value;
};

module.exports.getIPAddress = function(req) {
    var ip = req.headers['x-forwarded-for'] ||
        req.connection.remoteAddress ||
        req.socket.remoteAddress ||
        req.connection.socket.remoteAddress;
    return ip;
}