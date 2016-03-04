//
//  Network.h
//  Simply_Weather
//
//  Created by qianfeng on 16/2/26.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

//下载网络数据完成时回调
typedef void(^Complete)(AFHTTPRequestOperation *operation, id responeObjc, NSError *error);


@interface Network : NSObject

//Get方式进行网络请求
+ (void)networkWithURL:(NSString *)url complete:(Complete)complete;

@end
