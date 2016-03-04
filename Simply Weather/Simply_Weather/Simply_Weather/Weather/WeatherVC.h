//
//  WeatherVC.h
//  Simply_Weather
//
//  Created by qianfeng on 16/2/25.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "NowWeatherModel.h"

@interface WeatherVC : UIViewController

@property (nonatomic,strong) NSString *position;
@property (nonatomic,strong) NSString *myCity;

@property (nonatomic,strong) Model *model;
@property (nonatomic,strong) NSMutableArray *dailyModelArr;
@property (nonatomic,strong) NSMutableArray *hourlyModelArr;
@property (nonatomic,strong) NowWeatherModel *nowModel;


@property (strong, nonatomic) IBOutlet UIImageView *bgImage;

@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;



@end
