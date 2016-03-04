//
//  SetTempCell.h
//  Simply_Weather
//
//  Created by qianfeng on 16/2/24.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetTempCell : UITableViewCell
//@property (strong, nonatomic) IBOutlet UIButton *CelsiusButton;
//@property (strong, nonatomic) IBOutlet UIButton *FahrenheitButton;
@property (nonatomic,strong) UIButton *CelsiusButton;
@property (nonatomic,strong) UIButton *FahrenheitButton;
@property (nonatomic,assign) BOOL isSelect;//温度模式选择状态

@end
