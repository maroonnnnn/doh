//
//  NewsTodayVC.m
//  Simply_Weather
//
//  Created by qianfeng on 16/3/3.
//  Copyright (c) 2016年 maroonnnnn. All rights reserved.
//

#import "NewsTodayVC.h"

//网络请求
#import "Network.h"
//新闻模型
#import "NewsModel.h"
//自定义的Cell
#import "ScrollViewCell.h"
#import "NewsCell.h"
//网页
#import "NewsURLVC.h"

#import "NavigationVC.h"

@interface NewsTodayVC ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation NewsTodayVC
{
    UITableView *_myTableView;
    
    //ScrollCell 传入的值
    NSMutableArray *_dataArray;
    NSMutableArray *_picArr;
    NSMutableArray *_titleArr;
    NSMutableArray *_linkArr;
    
    //ScrollView的定时器  页面跳转关闭
    NSTimer *_timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数组
    _dataArray = [NSMutableArray array];
    _picArr = [NSMutableArray array];
    _titleArr = [NSMutableArray array];
    _linkArr = [NSMutableArray array];
    
    //网络请求
    [self createData];
    
    [self createTableView];
    
    //获取通知中心
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    //  注册观察者  通知的名字一致
    [nc addObserver:self selector:@selector(cellClick:) name:@"cellClick" object:nil]; 
}
- (void)cellClick:(NSNotification *)not{
    NewsURLVC *vc = [[NewsURLVC alloc] init];
    vc.url = (id)not.object;
    [self.navigationController pushViewController:vc animated:YES];
    self.navigationController.navigationBar.hidden = YES;
}


//网络请求
- (void)createData{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"myLink"];
    NSString *url = [NSString stringWithFormat:@"%@%@", URLLL, dic[_myItem]];
    
    [Network networkWithURL:url complete:^(AFHTTPRequestOperation *operation, id responeObjc, NSError *error) {
        
        if (!error) {
            int i = 0;
            for (NSDictionary *dic in responeObjc[@"data"][@"list"]) {
                //创建model
                NewsModel *model = [[NewsModel alloc] initWithDic:dic];
                i++;
                if (i < 5) {
                    [_picArr addObject:model.kpic];
                    [_titleArr addObject:model.title];
                    [_linkArr addObject:model.link];
                }else{
                    //取前4个pic和title
                    [_dataArray addObject:model];
                }
            }
            
        }else{NSLog(@"%@", error);}
        
        [_myTableView reloadData];
    }];
    
    //数据处理完，创建TableView
    
}


//创建TableView
- (void)createTableView{
    //初始化数据源数组
    _dataArray = [NSMutableArray array];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-114)];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_myTableView];
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 200;
    }else{
        return 100;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //ScrollView
    if (indexPath.row == 0) {
        ScrollViewCell *cell = [[ScrollViewCell alloc] newsTableView:tableView picArr:_picArr title:_titleArr linkArr:_linkArr];
        _timer = cell.timer;
        return cell;
    //列表页
    }else{
        return [NewsCell newsCellTableView:tableView model:_dataArray[indexPath.row]];
    }
}
//cell被选中时，跳到相应的网页
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsURLVC *news = [[NewsURLVC alloc] init];
    news.url = [_dataArray[indexPath.row] link];
    
    [_timer invalidate];
    
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController pushViewController:news animated:YES];
}
@end
