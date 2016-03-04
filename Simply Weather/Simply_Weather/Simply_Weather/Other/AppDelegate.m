//
//  AppDelegate.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/22.
//  Copyright (c) 2016年 maroonnnnn. All rights reserved.
//

#import "AppDelegate.h"
//导入视图控制器
//左视图
#import "LeftVC.h"
//中间视图
#import "WeatherVC.h"

//定义视图数组
#define Titles @[@"我的天气",  @"今日热点", @"记事本", @"设置"]
#define Image @[@"cloud",  @"news", @"edit", @"settingsButton"]

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //根视图设置
    [self setRoot];
    
    
    //设置状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    return YES;
}

- (void)setRoot{
    //创建根视图
    YRSideViewController *sideVC = [[YRSideViewController alloc] init];
    
    //1 创建左视图对象
    LeftVC *left = [[LeftVC alloc] init];
//    UINavigationController *leftnav = [[UINavigationController alloc] initWithRootViewController:left];
    sideVC.leftViewController = left;
    //  设置左侧栏展示大小
    sideVC.leftViewShowWidth = WIDTH * 3/5;
    //  设置左侧栏展示动画
    [sideVC showLeftViewController:YES];
    
    WeathersVC *weathers = [[WeathersVC alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:weathers];
    
    //导航栏设置
    nvc.navigationBar.barStyle = UIBarStyleBlack;
    //设置不透明
    nvc.navigationBar.translucent = YES;
    //镂空处颜色
    nvc.navigationBar.tintColor = [UIColor whiteColor];
    //bar的背景颜色
    nvc.navigationBar.barTintColor = COLOR;
    
    sideVC.rootViewController = nvc;
    /*
    //2 创建中间视图
    WeathersVC *weathers = [[WeathersVC alloc] init];
    SetVC *set = [SetVC shared];
//    NewsVC *news = [[NewsVC alloc] init];
    NewsTabVC *news = [[NewsTabVC alloc] init];
    NoteVC *note = [[NoteVC alloc] init];
    NSArray *vcs = @[weathers, news, note, set];
    
    
    
    //  创建标签栏控制器
    UITabBarController *tab = [[UITabBarController alloc] init];
    tab.tabBar.tintColor = COLOR;
    
    //将四个视图添加到tabbar上
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < vcs.count; i ++) {
        //创建导航栏控制器
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vcs[i]];
        
        UIImage *image = [UIImage imageNamed:Image[i]];
        
        //设置tabbar的标题
        nvc.tabBarItem = [[UITabBarItem alloc] initWithTitle:Titles[i] image:image selectedImage:nil];
        

        nvc.navigationBar.barStyle = UIBarStyleBlack;
        //设置不透明
        nvc.navigationBar.translucent = YES;
        //镂空处颜色
        nvc.navigationBar.tintColor = [UIColor whiteColor];
        //bar的背景颜色
        nvc.navigationBar.barTintColor = COLOR;
        
        
        [arr addObject:nvc];
    }
    tab.viewControllers = arr;
    sideVC.rootViewController = weathers;
*/

    
    
    
    self.window.rootViewController = sideVC;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
