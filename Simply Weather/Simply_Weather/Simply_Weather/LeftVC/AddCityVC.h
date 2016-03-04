//
//  AddCityVC.h
//  Simply_Weather
//
//  Created by qianfeng on 16/2/25.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import <UIKit/UIKit.h>
//添加模型
#import "Model.h"
#import "DailyForecastModel.h"
#import "HourlyForecastModel.h"
#import "NowWeatherModel.h"

@interface AddCityVC : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *cityText;

@property (nonatomic,strong) NSMutableArray *cityArray;

@property (nonatomic,strong) Model *model;
@property (nonatomic,strong) NSMutableArray *dailyModelArr;
@property (nonatomic,strong) NSMutableArray *hourlyModelArr;
@property (nonatomic,strong) NowWeatherModel *nowModel;

@end
