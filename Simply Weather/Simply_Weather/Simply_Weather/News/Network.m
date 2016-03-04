//
//  Network.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/26.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import "Network.h"

@implementation Network

//Get请求实现
+ (void)networkWithURL:(NSString *)url complete:(Complete)complete
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        complete(operation, responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        complete(operation, nil, error);
    }];
    
}


@end
