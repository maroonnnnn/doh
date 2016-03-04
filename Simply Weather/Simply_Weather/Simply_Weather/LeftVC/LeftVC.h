//
//  LeftVC.h
//  Simply_Weather
//
//  Created by qianfeng on 16/2/22.
//  Copyright (c) 2016年 maroonnnnn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftVC : UIViewController


@property (nonatomic,strong) UIImageView *myPosition;
@property (nonatomic,strong) UIButton *myCity;
@property (nonatomic,strong) UILabel *myTitle;

@property (nonatomic,strong) NSMutableArray *dataArray;

@end
