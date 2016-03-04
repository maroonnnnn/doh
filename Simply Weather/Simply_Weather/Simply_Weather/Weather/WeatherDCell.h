//
//  WeatherDCell.h
//  Simply_Weather
//
//  Created by qianfeng on 16/2/29.
//  Copyright (c) 2016年 maroonnnnn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherDCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UILabel *txtd;
@property (strong, nonatomic) IBOutlet UIImageView *coded;
@property (strong, nonatomic) IBOutlet UILabel *max;
@property (strong, nonatomic) IBOutlet UILabel *min;
@property (strong, nonatomic) IBOutlet UIImageView *coden;
@property (strong, nonatomic) IBOutlet UILabel *txtn;
@property (strong, nonatomic) IBOutlet UILabel *pop;


@end
