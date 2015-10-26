package com.liangziyun.qiniuupload;


import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.qiniu.android.storage.*;
import com.qiniu.android.http.*;

public class QiniuUpload extends CordovaPlugin {

    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
    }

    @Override
    public boolean execute(String action, JSONArray args,
                           CallbackContext callbackContext) throws JSONException {

        if (action.equals("start")) {
            return upload(args, callbackContext);
        } 

        return super.execute(action, args, callbackContext);
    }

    protected boolean upload(JSONArray args,final CallbackContext callbackContext)
            throws JSONException {
                // check if # of arguments is correct
        if (args.length() != 1) {
            callbackContext.error("参数错误");
            return true;
        }

        final JSONObject params = args.getJSONObject(0);

        if(!params.has("file") || !params.has("token") || !params.has("key")) {
            callbackContext.error("参数错误");
            return true;
        }

        String data = params.getString("file");
        String token = params.getString("token");
        String key   = params.getString("key");
        data = data.replace("file://","");

        UploadManager uploadManager = new UploadManager();
        uploadManager.put(data, key, token,
        new UpCompletionHandler() {
            @Override
            public void complete(String key, ResponseInfo info, JSONObject res) {
                //  res 包含hash、key等信息，具体字段取决于上传策略的设置。 
                //Log.i("qiniu", key + ",\r\n " + info + ",\r\n " + res);
                callbackContext.success(res);
            }
        }, null);
        return true;
    }
}