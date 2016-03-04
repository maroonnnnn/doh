//
//  AddCityVC.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/25.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import "AddCityVC.h"
#import "APIStoreSDK.h"
#import "LeftVC.h"



@interface AddCityVC ()

@end

@implementation AddCityVC
{
    DailyForecastModel *_dailyModel;
    HourlyForecastModel *_hourlyModel;
    
    //回调成功 找到城市
    BOOL _isSuccess;
}


- (IBAction)addCity:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//视图出现的时候弹起键盘
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_cityText becomeFirstResponder];
//    self.navigationController.navigationBar.hidden = YES;
}
//视图消失的时候收起键盘
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_cityText resignFirstResponder];
}
- (IBAction)searchCity:(id)sender {

    NSString *city = _cityText.text;
    NSString *apikey = @"a30f128baf8a2c4f2f03d8e92b646852";
    
    //实例化一个回调
    APISCallBack *callBack = [APISCallBack alloc];
    
    //回调成功
    callBack.onSuccess = ^(long status, NSString* responseString) {
        NSLog(@"onSuccess");
        if(responseString != nil) {
//            NSLog(@"%@", responseString);
            
            
            
            //解析数据  把格式化的JSON格式的字符串转换成字典
            NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            
            //未找到该城市
            NSArray *arr = [NSArray arrayWithArray:dic[@"HeWeather data service 3.0"]];
            if ([arr[0][@"status"] isEqualToString:@"unknown city"]) {
                _isSuccess = NO;
                
            }else{
                
                //回调成功
                _isSuccess = YES;
                
                //添加数据
                for (NSDictionary *dict in dic[@"HeWeather data service 3.0"]) {
                    
                    //创建模型 将数据加入对应模型
                    _model = [[Model alloc] initWithDictionay:dict];
                    _nowModel = [[NowWeatherModel alloc] initWithDictionay:dict];
                }
            }
        }
    };
    

    //回调失败
    callBack.onError = ^(long status, NSString* responseString) {
        NSLog(@"onError");
//        NSLog(@"%@", responseString);
        
        //回调失败
        _isSuccess = NO;
        
        //动画
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2-70, HEIGHT/2-30, 140, 60)];
        [UIView animateWithDuration:2 animations:^{
            [self createErrorLabel:label];
            label.text = @"请检查网络";
            
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    };
    
    //回调完成
    callBack.onComplete = ^() {
        NSLog(@"搜索完成");
        
        //没有找到
        if (!_isSuccess) {
            //动画
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2-60, HEIGHT/2-30, 120, 60)];
            [UIView animateWithDuration:2 animations:^{
                [self createErrorLabel:label];
                label.text = @"输入有误";
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
            }];
            
        //找到城市
        }else{
            
            [_cityArray addObject:_model.cityBasic];
            
            //如果沙盒为空 新建
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"myCity"]==nil) {
                
                [[NSUserDefaults standardUserDefaults] setObject:_cityArray forKey:@"myCity"];
                
                //  第一次运行时，将温度单位设置为摄氏度
                if (![[NSUserDefaults standardUserDefaults] objectForKey:@"_isSelect"]) {
                    NSString *isSelect = @"1";
                    [[NSUserDefaults standardUserDefaults] setObject:isSelect forKey:@"_isSelect"];
                }
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                
                //如果沙盒中已存在
                //读取沙盒数据
                
                //判断添加城市是否已存在
                BOOL _isExist = NO;
                NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"myCity"];
                for (NSString *cityStr in array) {
                    
                    //城市已存在
                    if ([cityStr isEqualToString:_model.cityBasic]) {
                        _isExist = YES;
                        //动画
                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2-100, HEIGHT/2-30, 200, 60)];
                        [UIView animateWithDuration:2 animations:^{
                            [self createErrorLabel:label];
                            label.text = @"城市已存在，无需再添加";
                        } completion:^(BOOL finished) {
                            [label removeFromSuperview];
                        }];
                    }
                }
                
                //城市不存在
                if (!_isExist) {
                    NSArray *tempCityArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"myCity"];
                    
                    NSMutableArray *arr = [[NSMutableArray alloc] init];
                    [arr addObjectsFromArray:tempCityArray];
                    [arr addObject:_model.cityBasic];
                    
                    
                    //添加到TableView的数据源中
                    LeftVC *left = [[LeftVC alloc]init];
                    left.dataArray = arr;
                    
                    //覆盖沙盒中原有的数据
                    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"myCity"];
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
//                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }
    };
    
    //部分参数
    NSString *uri = @"http://apis.baidu.com/heweather/weather/free";
    NSString *method = @"post";
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:city forKey:@"city"];
    
    
    //请求API
    [ApiStoreSDK executeWithURL:uri method:method apikey:apikey parameter:parameter callBack:callBack];
    
}

//输入有误时 提示框
- (void)createErrorLabel:(UILabel *)label{
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor blackColor];
    label.alpha = 0.5;
    [self.view addSubview:label];
}

- (IBAction)speech:(id)sender {
    NSLog(@"使用了话筒");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    _cityArray = [[NSMutableArray alloc] init];
    _isSuccess = YES;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
