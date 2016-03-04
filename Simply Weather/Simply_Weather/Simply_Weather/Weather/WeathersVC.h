//
//  WeathersVC.h
//  Simply_Weather
//
//  Created by qianfeng on 16/2/25.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import "GUITabPagerViewController.h"

@interface WeathersVC : GUITabPagerViewController

@property (nonatomic,strong) NSMutableArray *cityArray;

@property (nonatomic,strong) NSString *push;

//单例
+ (WeathersVC *)sharedManager;

@end
