var exec = require('cordova/exec');

/*
    options:{
        file:"file path",
        token:"token",
        key:"key"
    }
*/
module.exports = {
    upload: function (options, onSuccess, onError) {
        exec(onSuccess, onError, "QiniuUpload", "start", [options]);
    }
};
