//
//  WeatherCCell.h
//  Simply_Weather
//
//  Created by qianfeng on 16/2/27.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherCCell : UITableViewCell<UIScrollViewDelegate>




+ (WeatherCCell *)newsTableView:(UITableView *)tableView hourlyModelArr:(NSMutableArray *)hourlyModelArr;

@end
