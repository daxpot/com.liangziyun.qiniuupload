#import <Cordova/CDVPlugin.h>


@interface CDVQiniuUpload : CDVPlugin {
}
@property (nonatomic, strong) NSString *currentCallbackId;
- (void)start:(CDVInvokedUrlCommand *)command;
@end