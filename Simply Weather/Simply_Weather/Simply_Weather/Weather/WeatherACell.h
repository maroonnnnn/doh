//
//  WeatherACell.h
//  Simply_Weather
//
//  Created by qianfeng on 16/2/27.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import <UIKit/UIKit.h>
//导入模型头文件
#import "Model.h"
#import "DailyForecastModel.h"
#import "HourlyForecastModel.h"
#import "NowWeatherModel.h"

@interface WeatherACell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *tmpNow;
@property (strong, nonatomic) IBOutlet UIImageView *C;
@property (strong, nonatomic) IBOutlet UILabel *txt_d;
@property (strong, nonatomic) IBOutlet UIImageView *weatherImage;

@property (strong, nonatomic) IBOutlet UIImageView *maxImage;
@property (strong, nonatomic) IBOutlet UIImageView *minImage;
@property (strong, nonatomic) IBOutlet UILabel *maxTmp;
@property (strong, nonatomic) IBOutlet UILabel *minTmp;

@property (strong, nonatomic) IBOutlet UILabel *hum;

@property (strong, nonatomic) IBOutlet UILabel *wind;
@property (strong, nonatomic) IBOutlet UILabel *sunraise;
@property (strong, nonatomic) IBOutlet UILabel *sunset;



@property (nonatomic,assign) BOOL daytime;

+ (WeatherACell *)newsTableView:(UITableView *)tableView model:(Model *)model dailyModel:(DailyForecastModel *)dailyModel nowModel:(NowWeatherModel *)nowModel;

@end
