//
//  WeatherECell.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/29.
//  Copyright (c) 2016年 maroonnnnn. All rights reserved.
//

#import "WeatherECell.h"
#import "WeatherEECell.h"

//获取屏幕的宽高
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface WeatherECell()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation WeatherECell
{
    UITableView *_myTableView;
    NowWeatherModel *_model;
    NSMutableArray *_resultArray;
    
}


- (WeatherECell *)newsTableView:(UITableView *)tableView model:(NowWeatherModel *)model{
    
    static NSString *cellID = @"ECELL";
    WeatherECell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[WeatherECell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    _model = model;
    
    _resultArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 7; i++) {
        [_resultArray addObject:[NSNumber numberWithBool:NO]];
    }
    
    [self createTableView];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//创建TableView
- (void)createTableView{
    CGSize size = [UIScreen mainScreen].bounds.size;
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.contentView addSubview:_myTableView];
    
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark === TableView 协议 ===
//段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}
//段高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
//设置段
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    //生活指数
    UIButton *message = [UIButton buttonWithType:UIButtonTypeCustom];
    message.backgroundColor = [UIColor clearColor];
    //间距
    message.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 30)];
    
    switch (section) {
        case 0:
            label.text = @"舒适度指数";
            break;
        case 1:
            label.text = @"洗车指数";
            break;
        case 2:
            label.text = @"穿衣指数";
            break;
        case 3:
            label.text = @"感冒指数";
            break;
        case 4:
            label.text = @"运动指数";
            break;
        case 5:
            label.text = @"旅游指数";
            break;
        case 6:
            label.text = @"紫外线指数";
            break;
        default:
            return nil;
            break;
    }

    [message addSubview:label];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH-20, 10, 10, 10)];
    
    //获取当前点击分段的展开状态
    // 然后把它转为相反的状态
    if ([_resultArray[section] boolValue]) {
        imageView.image = [UIImage imageNamed:@"up"];
    }else{
        imageView.image = [UIImage imageNamed:@"down"];
    }
    
    [message addSubview:imageView];
    
    message.tag = section;
    
    [message addTarget:self action:@selector(downClick:) forControlEvents:UIControlEventTouchUpInside];
    return message;
}
//折叠
- (void)downClick:(UIButton *)button{
    // 获取当前点击分段的展开状态
    BOOL bo = [_resultArray[button.tag] boolValue];
    
    // 然后把它转为相反的状态
    [_resultArray replaceObjectAtIndex:button.tag withObject:[NSNumber numberWithBool:!bo]];
    
    //刷新这个分段
    [_myTableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag] withRowAnimation:UITableViewRowAnimationFade];
}
//每段行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            if ([_resultArray[0] boolValue]) {
                return 1;
            }
            return 0;
        case 1:
            if ([_resultArray[1] boolValue]) {
                return 1;
            }
            return 0;
        case 2:
            if ([_resultArray[2] boolValue]) {
                return 1;
            }
            return 0;
        case 3:
            if ([_resultArray[3] boolValue]) {
                return 1;
            }
            return 0;
        case 4:
            if ([_resultArray[4] boolValue]) {
                return 1;
            }
            return 0;
        case 5:
            if ([_resultArray[5] boolValue]) {
                return 1;
            }
            return 0;
        case 6:
            if ([_resultArray[6] boolValue]) {
                return 1;
            }
            return 0;
        default:
            return 0;
    }
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return [WeatherEECell newsTableView:tableView brf:_model.brfComf txt:_model.txtComf];
        case 1:
            return [WeatherEECell newsTableView:tableView brf:_model.brfCw txt:_model.txtCw];
        case 2:
            return [WeatherEECell newsTableView:tableView brf:_model.brfDrsg txt:_model.txtDrsg];
        case 3:
            return [WeatherEECell newsTableView:tableView brf:_model.brfFlu txt:_model.txtFlu];
        case 4:
            return [WeatherEECell newsTableView:tableView brf:_model.brfSport txt:_model.txtSport];
        case 5:
            return [WeatherEECell newsTableView:tableView brf:_model.brfTrav txt:_model.txtTrav];
        case 6:
            return [WeatherEECell newsTableView:tableView brf:_model.brfUv txt:_model.txtUv];
        default:
            return nil;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
