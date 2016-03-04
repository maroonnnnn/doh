//
//  WeatherACell.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/27.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import "WeatherACell.h"
#import "SetVC.h"

@implementation WeatherACell

+ (WeatherACell *)newsTableView:(UITableView *)tableView model:(Model *)model dailyModel:(DailyForecastModel *)dailyModel nowModel:(NowWeatherModel *)nowModel{

    WeatherACell *cell = [tableView dequeueReusableCellWithIdentifier:@"ACell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WeatherACell" owner:self options:nil]lastObject];
    }
    //根据日落判断  白天 夜晚
    NSArray *arr1 = [dailyModel.srAstroD componentsSeparatedByString:@":"];//日出时间
    NSArray *arr2 = [dailyModel.ssAstroD componentsSeparatedByString:@":"];//日落时间
    //当地时间                                     
    NSArray *arr3 = [model.locUpdate componentsSeparatedByString:@" "];
    NSArray *arr4 = [arr3[1] componentsSeparatedByString:@":"];
    
    int sr = [arr1[0] intValue] * 60 + [arr1[1] intValue];
    int ss = [arr2[0] intValue] * 60 + [arr2[1] intValue];
    int nowT = [arr4[0] intValue] * 60 + [arr4[1] intValue];
    //白天
    if (0 <= nowT & nowT <= sr || ss < nowT & nowT < 24*60) {
        cell.daytime = NO;
        cell.txt_d.text = dailyModel.txt_nD;
        cell.weatherImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", dailyModel.code_nCondD]];
    //夜晚
    }else{
        cell.daytime = YES;
        cell.txt_d.text = dailyModel.txt_dD;
        cell.weatherImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",dailyModel.code_dCondD]];
    }
    
    //湿度
    cell.hum.text = [NSString stringWithFormat:@"湿度：%@%% ", dailyModel.humDaily];
    //风力
    cell.wind.text = [NSString stringWithFormat:@"%@ %@", nowModel.dirWindN, nowModel.scWindN];
    //最高温  最低温
    cell.maxImage.image = [UIImage imageNamed:@"max"];
    cell.minImage.image = [UIImage imageNamed:@"min"];
    cell.maxTmp.text = dailyModel.maxTemp;
    cell.minTmp.text = dailyModel.minTemp;
    //日出日落时间
    cell.sunraise.text = [NSString stringWithFormat:@"日出：%@",dailyModel.srAstroD];
    cell.sunset.text = [NSString stringWithFormat:@"日落：%@", dailyModel.ssAstroD];
        
    //C F
    NSString *isSelect = [[NSUserDefaults standardUserDefaults] objectForKey:@"_isSelect"];
    
    if ([isSelect isEqualToString:@"1"]) {
        cell.C.image = [UIImage imageNamed:@"C"];
        cell.tmpNow.text = nowModel.tmpNow;
        
    }else if([isSelect isEqualToString:@"2"]){
        cell.C.image = [UIImage imageNamed:@"F"];
        cell.C.frame = CGRectMake(cell.C.frame.origin.x, cell.C.frame.origin.y + 20, cell.C.frame.size.width, cell.C.frame.size.height);
        NSString *temp = [NSString stringWithFormat:@"%.1lf", [nowModel.tmpNow floatValue]*1.8 + 32];
        cell.tmpNow.text = temp;
    }else{
        cell.C.image = nil;
        cell.maxImage.image = nil;
        cell.minImage.image = nil;
        cell.hum.text = nil;
        cell.wind.text = nil;
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
