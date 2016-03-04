//
//  WeatherOneCCCell.m
//  Simply_Weather
//
//  Created by qianfeng on 16/3/2.
//  Copyright (c) 2016年 maroonnnnn. All rights reserved.
//

#import "WeatherOneCCCell.h"

@implementation WeatherOneCCCell

+ (WeatherOneCCCell *)newsTableView:(UITableView *)tableView{
    WeatherOneCCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OneCCCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WeatherOneCCCell" owner:self options:nil]lastObject];
    }
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
