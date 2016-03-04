//
//  WeatherEECell.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/29.
//  Copyright (c) 2016年 maroonnnnn. All rights reserved.
//

#import "WeatherEECell.h"

@implementation WeatherEECell

+ (WeatherEECell *)newsTableView:(UITableView *)tableView brf:(NSString *)brf txt:(NSString *)txt{
    WeatherEECell *cell = [tableView dequeueReusableCellWithIdentifier:@"EECell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WeatherEECell" owner:self options:nil]lastObject];
    }
    
    cell.brf.text = brf;
    cell.txt.text = txt;
    
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
