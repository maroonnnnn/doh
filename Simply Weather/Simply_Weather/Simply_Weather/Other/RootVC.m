//
//  RootVC.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/23.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import "RootVC.h"
#import "AppDelegate.h"
#import "YRSideViewController.h"

@interface RootVC ()

@end

@implementation RootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    //推出左侧视图的按钮和图片
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mic"] style:UIBarButtonItemStylePlain target:self action:@selector(leftVC)];
    
    self.navigationController.navigationItem.leftBarButtonItem = item;
    
    self.navigationController.navigationBar.translucent = NO;
    
    //镂空处颜色
    self.navigationController.toolbar.barTintColor = [UIColor grayColor];
}

- (void)leftVC{
    //获取window的根视图
    YRSideViewController *root = (id)[[UIApplication sharedApplication] keyWindow].rootViewController;
    [root showLeftViewController:YES];
}

@end
