//
//  Model.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/25.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import "Model.h"

@implementation Model

#define API @"aqi"
#define CITY @"city"
#define BASIC @"basic"

- (instancetype)initWithDictionay:(NSDictionary *)dic{
    if (self == [super init]) {
        
        _apiCity = dic[API][CITY][@"aqi"];
        _coCity = dic[API][CITY][@"co"];
        _no2City = dic[API][CITY][@"no2"];
        _o3City = dic[API][CITY][@"o3"];
        _so2City = dic[API][CITY][@"so2"];
        _pm10City = dic[API][CITY][@"pm10"];
        _pm25City = dic[API][CITY][@"pm25"];
        _qltyCity = dic[API][CITY][@"qlty"];
        
        _cityBasic = dic[BASIC][@"city"];
        _cntyBasic = dic[BASIC][@"cnty"];
        _idBasic = dic[BASIC][@"id"];
        _latBasic = dic[BASIC][@"lat"];
        _lonBasic = dic[BASIC][@"lon"];
        
        _locUpdate = dic[BASIC][@"update"][@"loc"];
        
    }
    return self;
}

@end
