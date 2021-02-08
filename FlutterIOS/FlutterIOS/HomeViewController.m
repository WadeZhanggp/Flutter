//
//  HomeViewController.m
//  FlutterIOS
//
//  Created by zhangguangpeng on 2021/1/15.
//  Copyright © 2021 zhangguangpeng. All rights reserved.
//

#import "HomeViewController.h"
#import <Flutter/Flutter.h>

@interface HomeViewController ()



@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
}

- (IBAction)buttonAction:(id)sender {
    
    FlutterViewController *vc = [[FlutterViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.navigationController.navigationBar.hidden = YES;
    [self.navigationController pushViewController:vc animated:nil];
    //[self presentViewController:vc animated:YES completion:nil];
    
}


@end
