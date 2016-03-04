//
//  NavigationVC.h
//  Simply_Weather
//
//  Created by qianfeng on 16/2/27.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationVC : UIViewController

@property (nonatomic,strong) UINavigationController *nav;
@property (nonatomic,assign) NSInteger index;


+ (NavigationVC *)shared;

@end
