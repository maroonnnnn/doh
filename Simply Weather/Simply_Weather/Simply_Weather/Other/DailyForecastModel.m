//
//  DailyForecastModel.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/25.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import "DailyForecastModel.h"

@implementation DailyForecastModel


- (instancetype)initWithDictionay:(NSDictionary *)dic{
    if (self == [super init]) {
        
        NSArray *arr = [dic[@"date"] componentsSeparatedByString:@"-"];
        _dateDaily = [NSString stringWithFormat:@"%@-%@", arr[1], arr[2]];
        _humDaily = dic[@"hum"];
        _pcpnDaily = dic[@"pcpn"];
        _popDaily = dic[@"pop"];
        _presDaily = dic[@"pres"];
        _visDaily = dic[@"vis"];
        
        _maxTemp = dic[@"tmp"][@"max"];
        _minTemp = dic[@"tmp"][@"min"];
        
        _degWindD = dic[@"wind"][@"deg"];
        _dirWindD = dic[@"wind"][@"dir"];
        _scWindD = dic[@"wind"][@"sc"];
        _spdWindD = dic[@"wind"][@"spd"];
        
        _srAstroD = dic[@"astro"][@"sr"];
        _ssAstroD = dic[@"astro"][@"ss"];
        
        _code_dCondD = dic[@"cond"][@"code_d"];
        _code_nCondD = dic[@"cond"][@"code_n"];
        _txt_dD = dic[@"cond"][@"txt_d"];
        _txt_nD = dic[@"cond"][@"txt_n"];
    }
    return self;
}

@end
