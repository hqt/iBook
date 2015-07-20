/**
 * Created by Huynh Quang Thao on 7/20/15.
 */

exports.newsFeed = function newsFeed (req, res) {
    console.log('new feeds');
    res.render('post/index', {
        name: 'thao',
        school: 'FPT University',
        family: {
            sister: 'Pham Huong Lan'
        }});
};