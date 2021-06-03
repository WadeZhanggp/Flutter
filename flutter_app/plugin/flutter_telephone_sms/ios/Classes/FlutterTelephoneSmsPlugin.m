#import "FlutterTelephoneSmsPlugin.h"

@implementation FlutterTelephoneSmsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_telephone_sms"
            binaryMessenger:[registrar messenger]];
  FlutterTelephoneSmsPlugin* instance = [[FlutterTelephoneSmsPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
      result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    }else if ([@"callPhone" isEqualToString:call.method]) {
        NSDictionary *arg = call.arguments;
        NSString *phoneNumber = [arg objectForKey:@"phoneNumber"];
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneNumber];

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    else {
      result(FlutterMethodNotImplemented);
    }
}

@end
