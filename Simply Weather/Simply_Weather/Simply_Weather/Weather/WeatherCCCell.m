//
//  WeatherCCCell.m
//  Simply_Weather
//
//  Created by qianfeng on 16/3/2.
//  Copyright (c) 2016年 maroonnnnn. All rights reserved.
//

#import "WeatherCCCell.h"

@implementation WeatherCCCell

- (WeatherCCCell *)newsTableView:(UITableView *)tableView hourlyModelArr:(HourlyForecastModel *)hourlyModel{
    WeatherCCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCCell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WeatherCCCell" owner:self options:nil]lastObject];
    }

    _tmp.text = hourlyModel.tmpHourly;
    _time.text = hourlyModel.dateHourly;
    _pop.text = hourlyModel.popHourly;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
