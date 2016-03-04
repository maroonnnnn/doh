//
//  ScrollViewCell.h
//  Simply_Weather
//
//  Created by qianfeng on 16/2/26.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"


@interface ScrollViewCell : UITableViewCell



@property (nonatomic,strong) NSArray *picArr;
@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) NSArray *linkArr;
@property (nonatomic,strong) NSTimer *timer;


- (ScrollViewCell *)newsTableView:(UITableView *)tableView picArr:(NSArray *)picArr title:(NSArray *)titleArr linkArr:(NSArray *)linkArr;

@end
