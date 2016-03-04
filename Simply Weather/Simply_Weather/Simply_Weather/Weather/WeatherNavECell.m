//
//  WeatherNavECell.m
//  Simply_Weather
//
//  Created by qianfeng on 16/3/1.
//  Copyright (c) 2016年 maroonnnnn. All rights reserved.
//

#import "WeatherNavECell.h"

#import "WeatherEECell.h"

@interface WeatherNavECell ()<UITableViewDataSource, UITableViewDelegate>


//获取屏幕的宽高
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define COLOR [UIColor colorWithRed:0/255.0 green:155/255.0 blue:50/255.0 alpha:0.8]
@end

@implementation WeatherNavECell
{
    UITableView *_myTableView;
    
    NSMutableArray *_resultArray;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.title = @"生活指数";
    
    _resultArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 7; i++) {
        [_resultArray addObject:[NSNumber numberWithBool:NO]];
    }
    
    [self createTableView];
}



//创建TableView
- (void)createTableView{
    CGSize size = [UIScreen mainScreen].bounds.size;
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, size.width, size.height) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
    
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark === TableView 协议 ===
//段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}
//段高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
//设置段
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    //生活指数
    UIButton *message = [UIButton buttonWithType:UIButtonTypeCustom];
//    message.backgroundColor = [UIColor clearColor];
    message.backgroundColor = [UIColor whiteColor];
    //间距
    message.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 300, 30)];
    
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
    label.font = [UIFont boldSystemFontOfSize:20];
//    label.textColor = COLOR;
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
