//
//  NewsModel.h
//  Simply_Weather
//
//  Created by qianfeng on 16/2/26.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *pic;
@property (nonatomic,strong) NSString *kpic;
@property (nonatomic,strong) NSString *comment;
@property (nonatomic,strong) NSString *link;
@property (nonatomic,strong) NSString *intro;
@property (nonatomic,strong) NSString *pubDate;
@property (nonatomic,strong) NSString *video_url;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
