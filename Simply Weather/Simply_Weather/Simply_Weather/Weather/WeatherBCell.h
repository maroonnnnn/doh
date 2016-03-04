//
//  WeatherBCell.h
//  Simply_Weather
//
//  Created by qianfeng on 16/2/27.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import <UIKit/UIKit.h>
//导入模型头文件
#import "Model.h"



@interface WeatherBCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *apiCity;
@property (strong, nonatomic) IBOutlet UILabel *coCity;
@property (strong, nonatomic) IBOutlet UILabel *no2City;
@property (strong, nonatomic) IBOutlet UILabel *o3City;
@property (strong, nonatomic) IBOutlet UILabel *so2City;
@property (strong, nonatomic) IBOutlet UILabel *pm10;
@property (strong, nonatomic) IBOutlet UILabel *pm25;

@property (strong, nonatomic) IBOutlet UILabel *co;
@property (strong, nonatomic) IBOutlet UILabel *no2;
@property (strong, nonatomic) IBOutlet UILabel *o3;
@property (strong, nonatomic) IBOutlet UILabel *so2;
@property (strong, nonatomic) IBOutlet UILabel *pm10N;
@property (strong, nonatomic) IBOutlet UILabel *pm25N;







+ (WeatherBCell *)newsTableView:(UITableView *)tableView model:(Model *)model;
@end
