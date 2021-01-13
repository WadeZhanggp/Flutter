//
//  ViewController.m
//  FlutterIOS
//
//  Created by zhangguangpeng on 2021/1/13.
//  Copyright © 2021 zhangguangpeng. All rights reserved.
//

#import "ViewController.h"
#import <Flutter/Flutter.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)action{
    FlutterViewController *vc = [[FlutterViewController alloc] init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}


@end
