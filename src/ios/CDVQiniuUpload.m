#import "CDVQiniuUpload.h"

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
}

@end