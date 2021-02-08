//
//  AppDelegate.m
//  FlutterIOS
//
//  Created by zhangguangpeng on 2021/1/13.
//  Copyright © 2021 zhangguangpeng. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import <Flutter/Flutter.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
//    HomeViewController *con = [[HomeViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:con];
//    [self.window setRootViewController:nav];
//    [self.window makeKeyAndVisible];
    FlutterViewController *con = [[FlutterViewController alloc] init];
    //UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:con];
    [self.window setRootViewController:con];
    [self.window makeKeyAndVisible];
    return YES;
}




@end
