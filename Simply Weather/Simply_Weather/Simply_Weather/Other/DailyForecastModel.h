//
//  DailyForecastModel.h
//  Simply_Weather
//
//  Created by qianfeng on 16/2/25.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyForecastModel : NSObject

//daily_forecast --> 数组 --> 0
@property (nonatomic,strong) NSString *dateDaily;//date--2016-02-25 预报日期
@property (nonatomic,strong) NSString *humDaily;//hum--14% 相对湿度
@property (nonatomic,strong) NSString *pcpnDaily;//pcpn--0.0mm 降水量
@property (nonatomic,strong) NSString *popDaily;//pop--0 降水概率
@property (nonatomic,strong) NSString *presDaily;//pres--1003 气压
@property (nonatomic,strong) NSString *visDaily;//vis--10km 能见度
//daily_forecast --> 数组 --> 0 --> tmp
@property (nonatomic,strong) NSString *maxTemp;//max--6
@property (nonatomic,strong) NSString *minTemp;//min-- -5
//daily_forecast --> 数组 --> 0 --> wind
@property (nonatomic,strong) NSString *degWindD;//deg--192
@property (nonatomic,strong) NSString *dirWindD;//dir--无持续风向
@property (nonatomic,strong) NSString *scWindD;//sc--微风
@property (nonatomic,strong) NSString *spdWindD;//spd--2
//daily_forecast --> 数组 --> 0 --> astro
@property (nonatomic,strong) NSString *srAstroD;//sr--06:54 日出时间
@property (nonatomic,strong) NSString *ssAstroD;//ss--18:00 日落时间
//daily_forecast --> 数组 --> 0 --> cond
@property (nonatomic,strong) NSString *code_dCondD;//cond_d101 白天天气状况代码
@property (nonatomic,strong) NSString *txt_dD;//txt_d--多云 白天天气状况描述
@property (nonatomic,strong) NSString *code_nCondD;//cond_n104 夜间天气状况代码
@property (nonatomic,strong) NSString *txt_nD;//txt_n--阴 夜间天气状况描述


- (instancetype)initWithDictionay:(NSDictionary *)dic;
@end
