//
//  WeathersVC.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/25.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import "WeathersVC.h"

//添加多视图滚动
#import "GUITabPagerViewController.h"
//子视图
#import "WeatherVC.h"

//定位
#import <MapKit/MapKit.h>
//AFNetWorking
#import "AFHTTPRequestOperationManager.h"
#import "Network.h"

//城市模型
#import "Model.h"
//搜索头文件
#import "APIStoreSDK.h"
//功能按钮
#import "DCPathButton.h"

#import "NavigationVC.h"



//遵循位置管理协议
@interface WeathersVC ()<GUITabPagerDataSource, GUITabPagerDelegate,CLLocationManagerDelegate,DCPathButtonDelegate>

@end

@implementation WeathersVC
{
    //位置管理类  (定位)
    CLLocationManager *_locationManager;
    //AFNetworking
    AFHTTPRequestOperationManager *_manager;
    //存放城市模型
    Model *_model;
    //定位城市
    NSString *_city;
    
    NavigationVC *_nav;
    
}

+ (WeathersVC *)sharedManager{
    static WeathersVC *weathers = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (weathers == nil) {
            weathers = [[WeathersVC alloc] init];
        }
    });
    return weathers;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"%ld", _nav.index);
    if (_nav.index) {
        [self selectTabbarIndex:_nav.index animation:YES];
    }
    
    //读取沙盒中的城市数据
    _cityArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"myCity"];
    NSLog(@"_cityArray%@", _cityArray);
    
    //刷新
    [self reloadData];
    [self selectTabbarIndex:_nav.index animation:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _nav = [NavigationVC shared];
    
    //导航栏设置
    [self setNavigationBar];
    
    //视图控制器设置代理
    [self setDataSource:self];
    [self setDelegate:self];
    
    //获取当前所有添加的城市
    _cityArray = [NSMutableArray array];

    
    //创建功能按钮
    [self configureDCPathButton];

    
    //获取通知中心
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    //  注册观察者  通知的名字一致
    [nc addObserver:self selector:@selector(reloadWeathers:) name:@"ReloadWeathers" object:nil];
    [nc addObserver:self selector:@selector(selectVC:) name:@"SelectVC" object:nil];
    
}
- (void)reloadWeathers:(NSNotification *)not{
    if ((id)not.object == nil) {
        _cityArray = nil;
    }else{
        _cityArray = (id)not.object;
    }
    [self selectTabbarIndex:_nav.index animation:NO];
    [self reloadData];
}
- (void)selectVC:(NSNotification *)not{
    NSInteger index = [(id)not.object integerValue];
    _nav.index = index;
    [self selectTabbarIndex:index];
}

#pragma mark === 导航栏设置 ===
- (void)setNavigationBar{
    //推出左侧视图的按钮和图片
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"thth"] style:UIBarButtonItemStylePlain target:self action:@selector(leftVC)];
    
    //重新定位
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"geolocation"] style:UIBarButtonItemStylePlain target:self action:@selector(positionNow)];
}
- (void)leftVC{
    //获取window的根视图
    YRSideViewController *root = (id)[[UIApplication sharedApplication] keyWindow].rootViewController;
    [root showLeftViewController:YES];
}
- (void)positionNow{
    NSLog(@"重新定位");
    //悬浮  重新定位中...
    _city = nil;
    [self location];
    
    //动画
    [UIView animateWithDuration:3 animations:^{
        [self relocation];
    } completion:^(BOOL finished) {
        
        UILabel *label = (id)[self.view viewWithTag:94];
        [label removeFromSuperview];
    }];
    
}
- (void)relocation{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2-70, HEIGHT/2-100, 140, 60)];
    label.text = @"重新定位中...";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor blackColor];
    label.alpha = 0.5;
    label.tag = 94;
    [self.view addSubview:label];
}
//定位
- (void)location{
    _locationManager = [[CLLocationManager alloc] init];
    //
    [_locationManager requestWhenInUseAuthorization];
    
    //开启定位服务
    [_locationManager startUpdatingLocation];
    
    //指定代理类
    _locationManager.delegate = self;
 
}

//位置更新后回调
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //关闭定位
    [_locationManager stopUpdatingLocation];
    
    CLLocation *location = [locations lastObject];
//    NSLog(@"%.6f   %.6f", location.coordinate.latitude, location.coordinate.longitude);
    
//    NSString *url = [NSString stringWithFormat:@"http://weather.tv163.com/service/globalWeather.do?latlng=%.6f,%.6f&lang=zh-zn", location.coordinate.latitude, location.coordinate.longitude];
//    
//    [Network networkWithURL:url complete:^(AFHTTPRequestOperation *operation, id responeObjc, NSError *error) {
//        
//        NSLog(@"%@", responeObjc[@"cityName"]);
//        _city = responeObjc[@"cityName"];
//        [self requestHttp:_city];
//        
//    }];
    
    //反编码  经纬度位置-->地理信息
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //创建CLLocation对象
    CLLocation *myLocation = [[CLLocation alloc] initWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    [geocoder reverseGeocodeLocation:myLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error) {
            NSLog(@"反编码失败:%@", error);
        }else{
            
            CLPlacemark *placemark = [placemarks lastObject];

            if (placemark.addressDictionary[@"City"]) {
//                NSLog(@"city%@", placemark.addressDictionary[@"City"]);
                NSMutableString *string = placemark.addressDictionary[@"City"];
                
                NSRange range = [string rangeOfString:@"市" options:NSBackwardsSearch];
                if (range.location == NSNotFound) {
                    _city = string;
                }else{
                    NSArray *arr = [string componentsSeparatedByString:@"市"];
                    _city = arr[0];
                }
                

                
//                NSLog(@"%@", _city);
                
            }else if (placemark.addressDictionary[@"State"]){
//                NSLog(@"state%@", placemark.addressDictionary[@"State"]);
                NSString *str = placemark.addressDictionary[@"State"];
                NSArray *arr = [str componentsSeparatedByString:@" "];
                if (arr.count > 2) {
                    _city = [NSString stringWithFormat:@"%@%@", arr[0], arr[1]];
                }else{
                    _city = str;
                }
            }
            
            
            
            
            
//            NSLog(@"_city%@", _city);
            [[NSUserDefaults standardUserDefaults] setObject:_city forKey:@"myPosition"];
            

            //通知LeftVC有定位显示
            //  获取通知中心
            NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
            //  创建通知
            NSNotification *position= [[NSNotification alloc] initWithName:@"Position" object:nil userInfo:nil];
            //  发送通知
            [nc postNotification:position];
            
            [self reloadData];
            
            [self selectTabbarIndex:0 animation:YES];
        }
    }];
}


//请求网络
- (void)requestHttp:(NSString *)position{
    NSString *city = position;
    NSString *apikey = @"a30f128baf8a2c4f2f03d8e92b646852";
    
    //实例化一个回调
    APISCallBack *callBack = [APISCallBack alloc];
    
    //回调成功
    callBack.onSuccess = ^(long status, NSString* responseString) {
        NSLog(@"onSuccess");
        if(responseString != nil) {
            
            //解析数据  把格式化的JSON格式的字符串转换成字典
            NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            
            //添加数据
            for (NSDictionary *dict in dic[@"HeWeather data service 3.0"]) {
                
                //创建模型 将数据加入对应模型
                _model = [[Model alloc] initWithDictionay:dict];
            }
        }
    };
    
    //回调失败
    callBack.onError = ^(long status, NSString* responseString) {
        NSLog(@"onError");
    };
    
    //回调完成
    callBack.onComplete = ^() {
//        NSLog(@"更新数据完成");
    };
    
    //部分参数
    NSString *uri = @"http://apis.baidu.com/heweather/weather/free";
    NSString *method = @"post";
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:city forKey:@"city"];
    
    //请求API
    [ApiStoreSDK executeWithURL:uri method:method apikey:apikey parameter:parameter callBack:callBack];
}


#pragma mark === ViewControllerLifeCycle 视图控制器设置===
//视图的数量
- (NSInteger)numberOfViewControllers{
    NSLog(@"%@", _cityArray);
    //没有城市
    if (!_cityArray) {
        //有无定位
        return 1;
        
    //有城市
    }else{
        //有定位
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"myPosition"]) {
            return _cityArray.count + 1;
        //没有定位
        }else{
            return _cityArray.count;
        }
    }

}

//vcs
- (UIViewController *)viewControllerForIndex:(NSInteger)index{
    WeatherVC *vc = [[WeatherVC alloc] init];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"myPosition"] || [[NSUserDefaults standardUserDefaults] objectForKey:@"myCity"]) {
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"_isSelect"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"_isSelect"];
        }
    }

    
    //没有城市添加定位城市
    if (!_cityArray) {
        //没有定位
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"myPosition"]) {
            vc.myCity = @"请添加城市或进行定位";
        //有定位
        }else{
            vc.myCity = [[NSUserDefaults standardUserDefaults] objectForKey:@"myPosition"];
        }

    //有城市
    }else{
        //有定位
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"myPosition"]) {
            if (index == 0) {
                vc.myCity = [[NSUserDefaults standardUserDefaults] objectForKey:@"myPosition"];
            }else{
                vc.myCity = _cityArray[index - 1];
            }
        //没有定位
        }else{
            vc.myCity = _cityArray[index];
        }
    }
    return vc;
}

//设置顶部按钮的title
- (NSString *)titleForTabAtIndex:(NSInteger)index{
    //有城市
    if (_cityArray) {
        //有定位
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"myPosition"]) {
            if (index == 0) {
                return [[NSUserDefaults standardUserDefaults] objectForKey:@"myPosition"];
            }else{
                return _cityArray[index - 1];
            }
        //没有定位
        }else{
            return _cityArray[index];
        }
    //没有城市
    }else{
        //有定位
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"myPosition"]) {
            return [[NSUserDefaults standardUserDefaults] objectForKey:@"myPosition"];
        //没有定位
        }else{
            return @"请添加城市或进行定位";
        }
    }
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
    DCPathButton *button = [[DCPathButton alloc] initWithCenterImage:[UIImage imageNamed:@"cloudcloud"] highlightedImage:[UIImage imageNamed:@"cloudcloud"]];
    button.delegate = self;
    
    DCPathItemButton *itemButton_1 = [[DCPathItemButton alloc] initWithImage:[UIImage imageNamed:@"editt"] highlightedImage:[UIImage imageNamed:@"editt"] backgroundImage:nil backgroundHighlightedImage:nil];
    DCPathItemButton *itemButton_2 = [[DCPathItemButton alloc] initWithImage:[UIImage imageNamed:@"newss@1x"] highlightedImage:[UIImage imageNamed:@"newss@1x"] backgroundImage:nil backgroundHighlightedImage:nil];
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
        NoteVC *vc = [[NoteVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (itemButtonIndex == 1){
        NewsTodayVCs *vc = [[NewsTodayVCs alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        SetVC *vc = [SetVC shared];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)tabPager:(GUITabPagerViewController *)tabPager didTransitionToTabAtIndex:(NSInteger)index{
    _nav.index = index;
//    NSLog(@"%ld", _nav.index);
}

@end
