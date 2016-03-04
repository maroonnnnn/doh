//
//  NewsModel.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/26.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        _title = dic[@"title"];
        _link = dic[@"link"];
        _pic = dic[@"pic"];
        _kpic = dic[@"kpic"];
        NSNumber *number = dic[@"comment"];
        _comment = [NSString stringWithFormat:@"%d", [number intValue]];
        _intro = dic[@"intro"];
        NSNumber *number1 = dic[@"pubDate"];
        _pubDate = [NSString stringWithFormat:@"%d", [number1 intValue]];
        _video_url = dic[@"video_info"][@"url"];
    }
    return self;
}

@end
