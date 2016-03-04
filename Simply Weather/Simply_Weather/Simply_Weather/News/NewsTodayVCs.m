//
//  NewsTodayVCs.m
//  Simply_Weather
//
//  Created by qianfeng on 16/3/3.
//  Copyright (c) 2016年 maroonnnnn. All rights reserved.
//

#import "NewsTodayVCs.h"

//功能按钮
#import "DCPathButton.h"
//子视图
#import "NewsTodayVC.h"
//添加多视图滚动
#import "GUITabPagerViewController.h"
//添加新闻标题
#import "MoreNewsItem.h"

@interface NewsTodayVCs ()<DCPathButtonDelegate,GUITabPagerDataSource, GUITabPagerDelegate>

@end

@implementation NewsTodayVCs
{
    NSMutableArray *_listTop;
    NSMutableArray *_listBottom;
    NSMutableDictionary *_listDic;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    NSArray *myNews = [[NSUserDefaults standardUserDefaults] objectForKey:@"myNews"];
    _listTop = myNews[0];
//    NSLog(@"listTop%@", _listTop);
    
    //刷新
    [self reloadData];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //沙盒中不存在，则创建沙盒，初始化新闻列表
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"myNews"]) {
        NSMutableArray *listTop = [[NSMutableArray alloc] initWithArray:@[@"头条",@"娱乐",@"体育",@"财经",@"科技",@"军事",@"搞笑"]];
        NSMutableArray *listBottom = [[NSMutableArray alloc] initWithArray:@[@"汽车",@"社会",@"历史",@"教育",@"数码",@"健康",@"游戏",@"时尚",@"女性",@"家居",@"博客",@"NBA",@"专栏",@"育儿",@"八卦",@"星座",@"收藏"]];
//        NSArray *myNews = @[listTop, listBottom];
        [[NSUserDefaults standardUserDefaults] setObject:listTop forKey:@"listTop"];
        [[NSUserDefaults standardUserDefaults] setObject:listBottom forKey:@"listBottom"];
    }
    //标题对应的接口参数存入字典
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"myLink"]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (int i = 0; i < ARRAY.count; i++) {
            [dic setObject:LINK[i] forKey:ARRAY[i]];
        }
        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"myLink"];
    }
    
    
    //设置导航栏
    [self setNavigationBar];
    //功能按钮
    [self configureDCPathButton];
    
    
    //视图控制器设置代理
    [self setDataSource:self];
    [self setDelegate:self];
    
    
}
- (void)setNavigationBar{
    //推出左侧视图的按钮和图片
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"thth"] style:UIBarButtonItemStylePlain target:self action:@selector(leftVC)];
    
    //添加新的标题
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"] style:UIBarButtonItemStylePlain target:self action:@selector(moreNewsItem)];
}
- (void)leftVC{
    //获取window的根视图
    YRSideViewController *root = (id)[[UIApplication sharedApplication] keyWindow].rootViewController;
    [root showLeftViewController:YES];
}
- (void)moreNewsItem{
    MoreNewsItem *more = [[MoreNewsItem alloc] init];
    [self.navigationController pushViewController:more animated:YES];
}



#pragma mark === ViewControllerLifeCycle 视图控制器设置===
//视图的数量
- (NSInteger)numberOfViewControllers{

    return _listTop.count;
}
//vcs
- (UIViewController *)viewControllerForIndex:(NSInteger)index{
    NewsTodayVC *vc = [[NewsTodayVC alloc] init];
    
    vc.myItem = _listTop[index];
    return vc;
}
//设置顶部按钮的title
- (NSString *)titleForTabAtIndex:(NSInteger)index{
    return _listTop[index];
}
//tab区的高
- (CGFloat)tabHeight{
    return 50.0f;
}
//tab区标题的字体设置
- (UIFont *)titleFont{
    return [UIFont fontWithName:@"Noteworthy" size:20.0f];
}
//tab区字体颜色
- (UIColor *)titleColor{
    return [UIColor grayColor];
}





- (void)configureDCPathButton{
    DCPathButton *button = [[DCPathButton alloc] initWithCenterImage:[UIImage imageNamed:@"newss@1x"] highlightedImage:[UIImage imageNamed:@"newss@1x"]];
    button.delegate = self;
    
    DCPathItemButton *itemButton_1 = [[DCPathItemButton alloc] initWithImage:[UIImage imageNamed:@"cloudcloud"] highlightedImage:[UIImage imageNamed:@"cloudcloud"] backgroundImage:nil backgroundHighlightedImage:nil];
    DCPathItemButton *itemButton_2 = [[DCPathItemButton alloc] initWithImage:[UIImage imageNamed:@"editt"] highlightedImage:[UIImage imageNamed:@"editt"] backgroundImage:nil backgroundHighlightedImage:nil];
    DCPathItemButton *itemButton_3 = [[DCPathItemButton alloc] initWithImage:[UIImage imageNamed:@"settingsButton"] highlightedImage:[UIImage imageNamed:@"settingsButton"] backgroundImage:nil backgroundHighlightedImage:nil];
    
    [button addPathItems:@[itemButton_1,itemButton_2,itemButton_3]];
    button.bloomRadius = 120;
    button.allowSounds = YES;
    button.allowCenterButtonRotation = YES;
    button.bottomViewColor = [UIColor lightGrayColor];
    
    //子按钮出来的方向
    button.bloomDirection = kDCPathButtonBloomDirectionTopRight;
    
    button.dcButtonCenter = CGPointMake(10 + button.frame.size.width/2, HEIGHT - button.frame.size.height/2 - 70);
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
            if ([self.navigationController.viewControllers[i] isMemberOfClass:[SetVC class]]) {
                [self.navigationController popToViewController:self.navigationController.viewControllers[i] animated:YES];
                return;
            }
        }
    }
    
    if (itemButtonIndex == 1){
        NoteVC *vc = [[NoteVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        SetVC *vc = [SetVC shared];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
