//
//  WeatherOneDCell.m
//  Simply_Weather
//
//  Created by qianfeng on 16/3/2.
//  Copyright (c) 2016年 maroonnnnn. All rights reserved.
//

#import "WeatherOneDCell.h"

@implementation WeatherOneDCell

+ (WeatherOneDCell *)newsTableView:(UITableView *)tableView{
    WeatherOneDCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OneDCell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WeatherOneDCell" owner:self options:nil]lastObject];
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
