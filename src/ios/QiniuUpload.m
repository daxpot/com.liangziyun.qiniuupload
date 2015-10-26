#import "CDVQiniuUpload.h"
#import "QiniuSDK.h"

@implementation CDVQiniuUpload

-(void)start:(CDVInvokedUrlCommand *)command
{
    NSDictionary *params = [command.arguments objectAtIndex:0];
    if (!params)
    {
        CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:commandResult callbackId:command.callbackId];
        return ;
    }
    if(![params objectForKey:@"file"] || ![params objectForKey:@"token"] || ![params objectForKey:@"key"])
    {
        CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:commandResult callbackId:command.callbackId];
        return ;
    }
    NSString *token = [params objectForKey:@"token"];
    NSString *file  = [params objectForKey:@"file"];
    NSString *key   = [params objectForKey:@"key"];
    self.currentCallbackId = command.callbackId;
    file = [file stringByReplacingOccurrencesOfString:@"file://" withString:@""];
    
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    [upManager putFile:file key:key token:token
        complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            
        CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@""];
        if (resp == nil)
        {
            commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"上传失败"];
        }
        [self.commandDelegate sendPluginResult:commandResult callbackId:self.currentCallbackId];
    } option:nil];
}

@end