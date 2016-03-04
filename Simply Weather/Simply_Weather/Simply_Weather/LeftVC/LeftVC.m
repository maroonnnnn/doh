//
//  LeftVC.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/22.
//  Copyright (c) 2016年 maroonnnnn. All rights reserved.
//

#import "LeftVC.h"

//添加城市 搜索
#import "AddCityVC.h"

//添加自定义cell头文件
#import "AddButtonCell.h"

#import "NavigationVC.h"


@interface LeftVC ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation LeftVC
{
    UITableView *_myTableView;
    BOOL _isEditing;
    
    NavigationVC *_nav;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _dataArray = [NSMutableArray array];
    
    //将沙盒中的数据导入数据源中
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"myCity"]) {
        NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"myCity"];
        [_dataArray addObjectsFromArray:arr];
    }
    
    [_myTableView reloadData];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    _isEditing = NO;
    [_myTableView setEditing:_isEditing animated:NO];

//    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _isEditing = NO;
    _nav = [NavigationVC shared];
    
    //创建基本label
    [self createLabel];
    
    //创建数据源
    [self createData];
    
    //新建TableView
    [self createTableView];
    
    //获取通知中心
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    //  注册观察者  通知的名字一致
    [nc addObserver:self selector:@selector(reloadWeathers) name:@"Position" object:nil];

}
- (void)reloadWeathers{
    [self positionLabelnButton];
}
- (void)positionLabelnButton{
    //如果有定位
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"myPosition"]) {
        //将定位从沙盒中读取出来
        NSString *position = [[NSUserDefaults standardUserDefaults] objectForKey:@"myPosition"];
        NSLog(@"position%@", position);
        _myCity = [UIButton buttonWithType:UIButtonTypeCustom];
        _myCity.frame = CGRectMake(66, 71, 150, 30);
        [_myCity setTitle:position forState:UIControlStateNormal];
        [_myCity setTitleColor:COLOR forState:UIControlStateNormal];
        _myCity.titleLabel.font = [UIFont systemFontOfSize:18];
        [_myCity addTarget:self action:@selector(currentCity:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_myCity];
        
        //添加定位图片
        _myPosition = [[UIImageView alloc] initWithFrame:CGRectMake(30, 73, 28, 28)];
        [_myPosition setImage:[UIImage imageNamed:@"city"]];
        [self.view addSubview:_myPosition];
    }
}
//设置标题label
- (void)createLabel{
    _myTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, 100, 40)];
    _myTitle.text = @"我的城市";
    _myTitle.font = [UIFont systemFontOfSize:23];
    [self.view addSubview:_myTitle];
    
    [self positionLabelnButton];

    //创建删除按钮
    UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
    delete.frame = CGRectMake(160, 40, 70, 30);
    [delete setTitle:@"编辑" forState:UIControlStateNormal];
    delete.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [delete setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [delete addTarget:self action:@selector(deleteCity) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:delete];
}

//当前定位城市点击事件
- (void)currentCity:(id)sender {
    //跳转到WeatherVC显示对应的天气
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    YRSideViewController *root = (id)window.rootViewController;
    [root hideSideViewController:YES];
//    UITabBarController *tab = (id)root.rootViewController;
//    tab.selectedIndex = 0;
    UINavigationController *nvc = (id)root.rootViewController;
    
    
    //  获取通知中心
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    //  创建通知
    NSNotification *selectVC = [[NSNotification alloc] initWithName:@"SelectVC" object:0 userInfo:nil];
    //  发送通知
    [nc postNotification:selectVC];
    
    [nvc popToRootViewControllerAnimated:YES];
}
//删除城市
- (void)deleteCity{
    NSLog(@"删除城市");
    if (_isEditing) {
        _isEditing = NO;
    }else{
        _isEditing = YES;
    }
    [_myTableView setEditing:_isEditing animated:YES];
}
//调用父类编辑方法  并重写
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [_myTableView setEditing:editing animated:animated];
}
//设置编辑模式为删除  可编辑后 需提交
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!_dataArray) {
        return UITableViewCellEditingStyleNone;
        
    }else if(indexPath.row != _dataArray.count) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}
//删除方法的实现  从数据源、TableView删除相应的城市，更新沙盒
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld", _nav.index);
    NSLog(@"%ld", indexPath.row);
    //有定位
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"myPosition"]) {
        if (_nav.index == indexPath.row + 1) {
            _nav.index--;
        }
    //没有定位
    }else{
        if (indexPath.row == 0) {
            _nav.index = indexPath.row;
            [_dataArray removeAllObjects];
            [_myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"myCity"];
            
            //  获取通知中心
            NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
            //  创建通知
            NSNotification *reloadWeathers = [[NSNotification alloc] initWithName:@"ReloadWeathers" object:nil userInfo:nil];
            //  发送通知
            [nc postNotification:reloadWeathers];
            return;
            
        }else{
            _nav.index--;
        }
    }
    
    
    
    //1 从数组中删除
    [_dataArray removeObjectAtIndex:indexPath.row];
    
    //2 从TableView中删除
    [_myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    //3 更新沙盒
    [[NSUserDefaults standardUserDefaults] setObject:_dataArray forKey:@"myCity"];
    
    //4 添加通知
    //  获取通知中心
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    //  创建通知
    NSNotification *reloadWeathers = [[NSNotification alloc] initWithName:@"ReloadWeathers" object:_dataArray userInfo:nil];
    //  发送通知
    [nc postNotification:reloadWeathers];

}


//新建TableView
-(void)createTableView{
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 100, WIDTH * 2/5, HEIGHT) style:UITableViewStylePlain];
    NSLog(@"%ld", _dataArray.count);
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
    
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
//创建数据源
- (void)createData{
    _dataArray = [[NSMutableArray alloc] init];
}


#pragma mark === TableView 协议 ===
//设置TableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!_dataArray) {
        return 1;
    }
    return _dataArray.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //最后一行添加城市按钮
    if (indexPath.row == _dataArray.count || !_dataArray) {
        
        AddButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ADDBUTTONCELL"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AddButtonCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    //cell上显示城市
    cell.textLabel.text = [NSString stringWithFormat:@"%@", _dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //跳转到AddCityVC
    if (indexPath.row == _dataArray.count) {
        
        AddCityVC *addCity = [[AddCityVC alloc] init];
        
        addCity.cityArray = _dataArray;
        
        [self presentViewController:addCity animated:YES completion:nil];

    
    }else{
        
        //跳转到WeatherVC显示对应的天气
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        YRSideViewController *root = (id)window.rootViewController;
        [root hideSideViewController:YES];
//        UITabBarController *tab = (id)root.rootViewController;
//        tab.selectedIndex = 0;
        UINavigationController *nvc = (id)root.rootViewController;
        
        NSString *index = nil;
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"myPosition"]) {
            index = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
        }else{
            index = [NSString stringWithFormat:@"%ld",indexPath.row];
        }
        

        
        
        //  获取通知中心
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        //  创建通知
        NSNotification *selectVC = [[NSNotification alloc] initWithName:@"SelectVC" object:index userInfo:nil];
        //  发送通知
        [nc postNotification:selectVC];
        
        [nvc popToRootViewControllerAnimated:YES];
    }
}

@end
