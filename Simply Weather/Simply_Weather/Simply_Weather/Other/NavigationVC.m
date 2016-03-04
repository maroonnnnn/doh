//
//  NavigationVC.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/27.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import "NavigationVC.h"

@interface NavigationVC ()

@end

@implementation NavigationVC

+ (NavigationVC *)shared{
    static NavigationVC *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (vc == nil) {
            vc = [[NavigationVC alloc] init];
            vc.index = 0;
        }
    });
    return vc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
