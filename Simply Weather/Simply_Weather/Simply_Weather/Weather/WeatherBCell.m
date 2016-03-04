//
//  WeatherBCell.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/27.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import "WeatherBCell.h"

@implementation WeatherBCell

+ (WeatherBCell *)newsTableView:(UITableView *)tableView model:(Model *)model{
    
    WeatherBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BCell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WeatherBCell" owner:self options:nil] lastObject];
    }
    
    cell.apiCity.text = [NSString stringWithFormat:@"空气质量指数： %@" , model.apiCity];
    cell.coCity.text = @"一氧化碳1小时平均值(ug/m³)：";
    cell.co.text = model.coCity;
    cell.no2City.text = @"二氧化氮1小时平均值(ug/m³)：";
    cell.no2.text = model.no2City;
    cell.o3City.text = @"臭氧1小时平均值(ug/m³)：";
    cell.o3.text = model.o3City;
    cell.so2City.text = @"二氧化硫1小时平均值(ug/m³)：";
    cell.so2.text = model.so2City;
    cell.pm10.text = @"PM10 1小时平均值(ug/m³)：";
    cell.pm10N.text = model.pm10City;
    cell.pm25.text = @"PM2.5 1小时平均值(ug/m³)：";
    cell.pm25N.text = model.pm25City;
    
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
