//
//  WeatherEECell.h
//  Simply_Weather
//
//  Created by qianfeng on 16/2/29.
//  Copyright (c) 2016年 maroonnnnn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NowWeatherModel.h"

@interface WeatherEECell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *brf;
@property (strong, nonatomic) IBOutlet UILabel *txt;


+ (WeatherEECell *)newsTableView:(UITableView *)tableView brf:(NSString *)brf txt:(NSString *)txt;
@end
