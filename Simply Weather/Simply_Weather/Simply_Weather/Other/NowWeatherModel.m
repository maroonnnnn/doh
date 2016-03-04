//
//  NowWeatherModel.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/25.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import "NowWeatherModel.h"

@implementation NowWeatherModel

#define STRDIC @"suggestion"
#define STR @"now"

- (instancetype)initWithDictionay:(NSDictionary *)dic{
    if (self == [super init]) {
        
        _tmpNow = dic[STR][@"tmp"];
        
        _degWindN = dic[STR][@"wind"][@"deg"];
        _dirWindN = dic[STR][@"wind"][@"dir"];
        _scWindN = dic[STR][@"wind"][@"sc"];
        _spdWindN = dic[STR][@"wind"][@"spd"];
        
        _brfComf = dic[STRDIC][@"comf"][@"brf"];
        _txtComf = dic[STRDIC][@"comf"][@"txt"];
        
        _brfCw = dic[STRDIC][@"cw"][@"brf"];
        _txtCw = dic[STRDIC][@"cw"][@"txt"];
        
        _brfDrsg = dic[STRDIC][@"drsg"][@"brf"];
        _txtDrsg = dic[STRDIC][@"drsg"][@"txt"];
        
        _brfFlu = dic[STRDIC][@"flu"][@"brf"];
        _txtFlu = dic[STRDIC][@"flu"][@"txt"];
        
        _brfSport = dic[STRDIC][@"sport"][@"brf"];
        _txtSport = dic[STRDIC][@"sport"][@"txt"];
        
        _brfTrav = dic[STRDIC][@"trav"][@"brf"];
        _txtTrav = dic[STRDIC][@"trav"][@"txt"];
        
        _brfUv = dic[STRDIC][@"uv"][@"brf"];
        _txtUv = dic[STRDIC][@"uv"][@"txt"];
        
    }
    return self;
}

@end
