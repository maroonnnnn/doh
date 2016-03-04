//
//  HourlyForecastModel.h
//  Simply_Weather
//
//  Created by qianfeng on 16/2/25.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HourlyForecastModel : NSObject

//hourly_forecast --> 数组 --> 0
@property (nonatomic,strong) NSString *dateHourly;//date--2016-02-25 16:00 时间
@property (nonatomic,strong) NSString *humHourly;//hum--43% 相对湿度
@property (nonatomic,strong) NSString *tmpHourly;//tmp--6 温度
@property (nonatomic,strong) NSString *popHourly;//pop--0 降水概率
//hourly_forecast --> 数组 --> 0 --> wind
@property (nonatomic,strong) NSString *degWindH;//deg--204
@property (nonatomic,strong) NSString *dirWindH;//dir--西南风
@property (nonatomic,strong) NSString *scWindH;//sc--微风
@property (nonatomic,strong) NSString *spdWindH;//spd--11


- (instancetype)initWithDictionay:(NSDictionary *)dic;

@end
