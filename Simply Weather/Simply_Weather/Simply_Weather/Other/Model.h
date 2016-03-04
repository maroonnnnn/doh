//
//  Model.h
//  Simply_Weather
//
//  Created by qianfeng on 16/2/25.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

//api --> city
@property (nonatomic,strong) NSString *apiCity;//api--30 空气质量指数
@property (nonatomic,strong) NSString *coCity;//co--1 一氧化碳1小时平均值(ug/m³)
@property (nonatomic,strong) NSString *no2City;//no2--33 二氧化氮1小时平均值(ug/m³)
@property (nonatomic,strong) NSString *o3City;//o3--53 臭氧1小时平均值(ug/m³)
@property (nonatomic,strong) NSString *so2City;//so2--14 二氧化硫1小时平均值(ug/m³)
@property (nonatomic,strong) NSString *pm10City;//pm10--56 PM10 1小时平均值(ug/m³)
@property (nonatomic,strong) NSString *pm25City;//pm25--36 PM2.5 1小时平均值(ug/m³)
@property (nonatomic,strong) NSString *qltyCity;//qlty--良 空气质量类别

//basic
@property (nonatomic,strong) NSString *cityBasic;//city--北京
@property (nonatomic,strong) NSString *cntyBasic;//cnty--中国
@property (nonatomic,strong) NSString *idBasic;//id--CN101010100
@property (nonatomic,strong) NSString *latBasic;//lat--39.904000
@property (nonatomic,strong) NSString *lonBasic;//lon--116.391000
//basic --> update
@property (nonatomic,strong) NSString *locUpdate;//loc--当地时间


- (instancetype)initWithDictionay:(NSDictionary *)dic;

@end
