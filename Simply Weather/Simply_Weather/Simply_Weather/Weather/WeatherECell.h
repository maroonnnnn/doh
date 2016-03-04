//
//  WeatherECell.h
//  Simply_Weather
//
//  Created by qianfeng on 16/2/29.
//  Copyright (c) 2016年 maroonnnnn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NowWeatherModel.h"

@interface WeatherECell : UITableViewCell


- (WeatherECell *)newsTableView:(UITableView *)tableView model:(NowWeatherModel *)model;

@end
