//
//  SetVC.h
//  Simply_Weather
//
//  Created by qianfeng on 16/2/23.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetVC : UIViewController

@property (nonatomic,strong) NSString *isSelect;

@property (nonatomic,strong) NSString *push;

+ (SetVC *)shared;

@end
