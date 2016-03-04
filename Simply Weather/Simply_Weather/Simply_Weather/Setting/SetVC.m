//
//  SetVC.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/23.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import "SetVC.h"

//导入Cell的XIB头文件
#import "SetTempCell.h"
//功能按钮
#import "DCPathButton.h"

@interface SetVC ()<UITableViewDelegate,UITableViewDataSource,DCPathButtonDelegate>

@end

@implementation SetVC
{
    UITableView *_myTableView;
    
    UIButton *_CelsiusButton;
    UIButton *_FahrenheitButton;
}


//单例
+ (SetVC *)shared{
    static SetVC *set = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (set == nil) {
            set = [[SetVC alloc] init];
        }
    });
    return set;
}
//视图消失的时候
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //将温度单位选择存入沙盒中
    [[NSUserDefaults standardUserDefaults] setObject:_isSelect forKey:@"_isSelect"];
}
//视图将要出现的时候
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _isSelect = [[NSUserDefaults standardUserDefaults] objectForKey:@"_isSelect"];
    [_myTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏设置
    [self setNavigationBar];
    
    //创建TableView
    [self createTableView];
    
    //设置按钮
    [self configureDCPathButton];
    
}
//导航栏设置
- (void)setNavigationBar{
    //推出左侧视图的按钮和图片
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"thth"] style:UIBarButtonItemStylePlain target:self action:@selector(leftVC)];
    
    self.navigationController.navigationBar.backgroundColor = COLOR;
}
- (void)leftVC{
    //获取window的根视图
    YRSideViewController *root = (id)[[UIApplication sharedApplication] keyWindow].rootViewController;
    [root showLeftViewController:YES];
}
//创建TableView
- (void)createTableView{
    CGSize size = [UIScreen mainScreen].bounds.size;
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
}

#pragma mark === TableView 协议 ===
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //第一行 行高 100
    if (indexPath.row == 0) {
        return 100;
    //其余行高 40
    }else return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //第一行
    if (indexPath.row == 0) {
        SetTempCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"SetTempCell" owner:self options:nil]lastObject];
        
        if (cell == nil) {
            cell = [[SetTempCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TEMPCell"];
        }
        
        [cell addSubview:[self setCButton]];
        [cell addSubview:[self setFButton]];
        return cell;
    }
    
    //其余行
    static NSString *cellID = @"SETCELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    switch (indexPath.row) {
        case 1:
            cell.textLabel.text = @"1";
            break;
        case 2:
            cell.textLabel.text = @"2";
            break;
        default:
            break;
    }
    return cell;
}
//创建CButton
- (UIButton *)setCButton{
    _CelsiusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _CelsiusButton.frame = CGRectMake(200, 35, 50, 50);
    [_CelsiusButton setTitle:@"°C" forState:UIControlStateNormal];
    _CelsiusButton.layer.cornerRadius = 25;
    
    //选中状态  边框与title改变颜色
    if ([_isSelect isEqualToString:@"1"]) {
        _CelsiusButton.layer.borderColor = COLOR.CGColor;
        [_CelsiusButton setTitleColor:COLOR forState:UIControlStateNormal];
    }else{
        _CelsiusButton.layer.borderColor = [UIColor blackColor].CGColor;
        [_CelsiusButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    _CelsiusButton.layer.borderWidth = 2;
    [_CelsiusButton addTarget:self action:@selector(CButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    return _CelsiusButton;
}
//CButton点击事件
- (void)CButtonClick{
    _isSelect = @"1";
    
    //CButton改变颜色
    _CelsiusButton.layer.borderColor = COLOR.CGColor;
    [_CelsiusButton setTitleColor:COLOR forState:UIControlStateNormal];
    
    //FButton变黑色
    _FahrenheitButton.layer.borderColor = [UIColor blackColor].CGColor;
    _FahrenheitButton.titleLabel.textColor = [UIColor blackColor];
}
//创建FButton
- (UIButton *)setFButton{
    _FahrenheitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _FahrenheitButton.frame = CGRectMake(290, 35, 50, 50);
    [_FahrenheitButton setTitle:@"°F" forState:UIControlStateNormal];
    _FahrenheitButton.layer.cornerRadius = 25;
    
    //选中状态  边框与title改变颜色
    if ([_isSelect isEqualToString:@"2"]) {
        _FahrenheitButton.layer.borderColor = COLOR.CGColor;
        [_FahrenheitButton setTitleColor:COLOR forState:UIControlStateNormal];
    }else{
        _FahrenheitButton.layer.borderColor = [UIColor blackColor].CGColor;
        [_FahrenheitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];;
    }
    
    _FahrenheitButton.layer.borderWidth = 2;
    [_FahrenheitButton addTarget:self action:@selector(FButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    return _FahrenheitButton;
}
//FButton点击事件
- (void)FButtonClick{
    _isSelect = @"2" ;

    
    //FButton改变颜色
    _FahrenheitButton.layer.borderColor = COLOR.CGColor;
    [_FahrenheitButton setTitleColor:COLOR forState:UIControlStateNormal];
    
    //CButton变黑色
    _CelsiusButton.layer.borderColor = [UIColor blackColor].CGColor;
    _CelsiusButton.titleLabel.textColor = [UIColor blackColor];
}


- (void)configureDCPathButton{
    DCPathButton *button = [[DCPathButton alloc] initWithCenterImage:[UIImage imageNamed:@"settingsButton"] highlightedImage:[UIImage imageNamed:@"settingsButton"]];
    button.delegate = self;
    
    DCPathItemButton *itemButton_1 = [[DCPathItemButton alloc] initWithImage:[UIImage imageNamed:@"cloudcloud"] highlightedImage:[UIImage imageNamed:@"cloudcloud"] backgroundImage:nil backgroundHighlightedImage:nil];
    DCPathItemButton *itemButton_2 = [[DCPathItemButton alloc] initWithImage:[UIImage imageNamed:@"editt"] highlightedImage:[UIImage imageNamed:@"editt"] backgroundImage:nil backgroundHighlightedImage:nil];
    DCPathItemButton *itemButton_3 = [[DCPathItemButton alloc] initWithImage:[UIImage imageNamed:@"newss@1x"] highlightedImage:[UIImage imageNamed:@"newss@1x"] backgroundImage:nil backgroundHighlightedImage:nil];
    
    [button addPathItems:@[itemButton_1,itemButton_2,itemButton_3]];
    button.bloomRadius = 120;
    button.allowSounds = YES;
    button.allowCenterButtonRotation = YES;
    button.bottomViewColor = [UIColor lightGrayColor];
    
    //子按钮出来的方向
    button.bloomDirection = kDCPathButtonBloomDirectionTopRight;
    
    button.dcButtonCenter = CGPointMake(10 + button.frame.size.width/2, HEIGHT - button.frame.size.height/2 - 10);
    button.bottomViewColor = [UIColor clearColor];
    
    [self.view addSubview:button];
}
- (void)pathButton:(DCPathButton *)dcPathButton clickItemButtonAtIndex:(NSUInteger)itemButtonIndex{
    if (itemButtonIndex == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    
    for (int i = 0; i < [self.navigationController.viewControllers count]; i++) {
        if(itemButtonIndex == 1){
            if ([self.navigationController.viewControllers[i] isMemberOfClass:[NoteVC class]]) {
                [self.navigationController popToViewController:self.navigationController.viewControllers[i] animated:YES];
                return;
            }
        }else if (itemButtonIndex == 2){
            if ([self.navigationController.viewControllers[i] isMemberOfClass:[NewsTodayVCs class]]) {
                [self.navigationController popToViewController:self.navigationController.viewControllers[i] animated:YES];
                return;
            }
        }
    }
    if (itemButtonIndex == 1){
        NoteVC *vc = [[NoteVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(itemButtonIndex == 2){
        NewsTodayVCs *vc = [[NewsTodayVCs alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
