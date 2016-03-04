//
//  NewsCell.h
//  Simply_Weather
//
//  Created by qianfeng on 16/2/26.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NewsCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *pic;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *intro;
@property (strong, nonatomic) IBOutlet UILabel *comment;

+ (NewsCell *)newsCellTableView:(UITableView *)tableView model:(NewsModel *)model;

@end
