//
//  WeatherCCCell.h
//  Simply_Weather
//
//  Created by qianfeng on 16/3/2.
//  Copyright (c) 2016年 maroonnnnn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HourlyForecastModel.h"

@interface WeatherCCCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *tmp;
@property (strong, nonatomic) IBOutlet UILabel *pop;


- (WeatherCCCell *)newsTableView:(UITableView *)tableView hourlyModelArr:(HourlyForecastModel *)hourlyModelArr;

@end
