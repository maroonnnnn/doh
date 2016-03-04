//
//  HourlyForecastModel.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/25.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import "HourlyForecastModel.h"

@implementation HourlyForecastModel


- (instancetype)initWithDictionay:(NSDictionary *)dic{
    if (self == [super init]) {
        //时间
        NSArray *arr = [dic[@"date"] componentsSeparatedByString:@" "];
        _dateHourly = arr[1];
        
        _humHourly = dic[@"hum"];
        _tmpHourly = dic[@"tmp"];
        _popHourly = dic[@"pop"];
        
        _degWindH = dic[@"wind"][@"deg"];
        _dirWindH = dic[@"wind"][@"dir"];
        _scWindH = dic[@"wind"][@"sc"];
        _spdWindH = dic[@"wind"][@"spd"];
    }
    return self;
}

@end
