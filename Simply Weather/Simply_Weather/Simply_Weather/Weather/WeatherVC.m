//
//  WeatherVC.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/25.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import "WeatherVC.h"

//定位
#import "APIStoreSDK.h"
//数据模型
#import "DailyForecastModel.h"
#import "HourlyForecastModel.h"

//自定义cell
#import "WeatherACell.h"
#import "WeatherBCell.h"
#import "WeatherCCell.h"
#import "WeatherOneCCCell.h"
#import "WeatherCCCell.h"
#import "WeatherDCell.h"
#import "WeatherOneDCell.h"
#import "WeatherECell.h"

//管理控制器
#import "WeatherNavECell.h"


@interface WeatherVC ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation WeatherVC
{
    DailyForecastModel *_dailyModel;
    HourlyForecastModel *_hourlyModel;
    
    UITableView *_myTableView;
    BOOL _resultArray1;
    BOOL _resultArray2;
    BOOL _resultArray3;
    BOOL _resultArray4;
    
    BOOL _isExisting;
}

//视图将要出现时，进行网络请求，加载数据
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"_isSelect"]) {
        _isExisting = YES;
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"myCity"]) {
        //请求网络
        [self requestHttp];
    }

}
//请求网络
- (void)requestHttp{
    NSString *city = _myCity;
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
                _nowModel = [[NowWeatherModel alloc] initWithDictionay:dict];
                
                _dailyModelArr = [NSMutableArray array];
                for (NSDictionary *dic in dict[@"daily_forecast"]) {
                    _dailyModel = [[DailyForecastModel alloc] initWithDictionay:dic];
                    
                    [_dailyModelArr addObject:_dailyModel];
                }
                
                _hourlyModelArr = [NSMutableArray array];
                for (NSDictionary *dic in dict[@"hourly_forecast"]) {
                    _hourlyModel = [[HourlyForecastModel alloc] initWithDictionay:dic];
    
                    [_hourlyModelArr addObject:_hourlyModel];

                }
            }
        }
    };
    
    //回调失败
    callBack.onError = ^(long status, NSString* responseString) {
        NSLog(@"onError");
    };
    
    //回调完成
    callBack.onComplete = ^() {
        NSLog(@"更新数据完成");
        [self createTableView];
    };
    
    //部分参数
    NSString *uri = @"http://apis.baidu.com/heweather/weather/free";
    NSString *method = @"post";
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:city forKey:@"city"];
    
    //请求API
    [ApiStoreSDK executeWithURL:uri method:method apikey:apikey parameter:parameter callBack:callBack];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}
//创建TableView
- (void)createTableView{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"_isSelect"]) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-120) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [self.view addSubview:_myTableView];
        
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}



#pragma mark === TableView 协议 ===
//段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIButton *message = [UIButton buttonWithType:UIButtonTypeCustom];
    message.backgroundColor = [UIColor clearColor];
    //间距
    message.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 300, 30)];
    [message addSubview:label];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH-20, 20, 10, 10)];

    [message addSubview:imageView];
    
    //空气质量
    if ((section == 1) & _isExisting) {
        
        //获取当前点击分段的展开状态
        // 然后把它转为相反的状态
        if (_resultArray1) {
            imageView.image = [UIImage imageNamed:@"up"];
        }else{
            imageView.image = [UIImage imageNamed:@"down"];
        }
        
        label.text = [NSString stringWithFormat:@"空气质量：%@",_model.qltyCity];
        [message addTarget:self action:@selector(down1Click) forControlEvents:UIControlEventTouchUpInside];
        return message;
    }
    
    //今日各时段温度
    if ((section == 2) & _isExisting) {
        
        if (_resultArray2) {
            imageView.image = [UIImage imageNamed:@"up"];
        }else{
            imageView.image = [UIImage imageNamed:@"down"];
        }
        
        label.text = @"今日各时段天气";
        [message addTarget:self action:@selector(down2Click) forControlEvents:UIControlEventTouchUpInside];
        return message;
    }
    
    //7天天气预报
    if ((section == 3) & _isExisting) {
        
        if (_resultArray3) {
            imageView.image = [UIImage imageNamed:@"up"];
        }else{
            imageView.image = [UIImage imageNamed:@"down"];
        }
        
        label.text = @"7天天气预报";
        [message addTarget:self action:@selector(down3Click) forControlEvents:UIControlEventTouchUpInside];
        return message;
    }
    
    //生活指数
//    if ((section == 4) & _isExisting) {
//        label.text = @"生活指数";
//        [message addTarget:self action:@selector(down4Click) forControlEvents:UIControlEventTouchUpInside];
//        return message;
//    }
    
    return nil;
}
//折叠1
- (void)down1Click{
    //刷新这个分段
    _resultArray1 = !_resultArray1;
    [_myTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
}
//折叠2
- (void)down2Click{
    //刷新这个分段
    _resultArray2 = !_resultArray2;
    [_myTableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
}
//折叠4
- (void)down3Click{
    //刷新这个分段
    _resultArray3 = !_resultArray3;
    [_myTableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
}

//段高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 0;
        case 1:
            return 50;
        case 2:
            return 50;
        case 3:
            return 50;
        case 4:
            return 0;
        default:
            break;
    }
    return 30;
}
//每段行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return _resultArray1;
        case 2:
            if (_resultArray2) {
                return _hourlyModelArr.count + 1;
            }else{
                return 0;
            }
        case 3:
            if (_resultArray3) {
                return _dailyModelArr.count + 1;
            }
            else{
                return 0;
            }
        case 4:
            return 1;
        default:
            return 0;
    }
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 250;
        case 1:
            return 220;
        case 2:
            if (indexPath.row == 0) {
                return 30;
            }
            return 50;
        case 3:
            if (indexPath.row == 0) {
                return 30;
            }
            return 50;
        case 4:
            return 50;
        default:
            break;
    }
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //第一行
    if (indexPath.section == 0) {
        return [WeatherACell newsTableView:tableView model:_model dailyModel:_dailyModelArr[0] nowModel:_nowModel];
    }
    
    //第二行
    else if (indexPath.section == 1) {
        return [WeatherBCell newsTableView:tableView model:_model];
    }
    
    //第三行
    else if (indexPath.section == 2){
        //信息行
        if (indexPath.row == 0) {
            return [WeatherOneCCCell newsTableView:tableView];
        //数据行
        }else{
            WeatherCCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCCell"];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"WeatherCCCell" owner:self options:nil]lastObject];
            }
            HourlyForecastModel *model = _hourlyModelArr[indexPath.row - 1];
            //温度
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"_isSelect"] isEqualToString:@"1"]) {
                cell.tmp.text = [NSString stringWithFormat:@"%@°C",model.tmpHourly];
            }else{
                cell.tmp.text = [NSString stringWithFormat:@"%.1f°F", [model.tmpHourly intValue] * 1.8 + 32];
            }
            //时间
            cell.time.text = model.dateHourly;
            //降水概率
            cell.pop.text = model.popHourly;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    
    //第四行
    else if (indexPath.section == 3){
        //信息行
        if (indexPath.row == 0) {
            return [WeatherOneDCell newsTableView:tableView];
        
        //数据行
        }else{
            WeatherDCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DCell"];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"WeatherDCell" owner:self options:nil]lastObject];
            }
            DailyForecastModel *model = _dailyModelArr[indexPath.row - 1];
            //日期
            cell.date.text = model.dateDaily;
            if (indexPath.row == 1) {
                cell.date.text = @"今天";
            }else if (indexPath.row == 2){
                cell.date.text = @"明天";
            }
            //天气
            cell.txtd.text = model.txt_dD;
            cell.coded.image = [UIImage imageNamed:model.code_dCondD];
            cell.max.text = model.maxTemp;
            cell.min.text = model.minTemp;
            cell.coden.image = [UIImage imageNamed:model.code_nCondD];
            cell.txtn.text = model.txt_nD;
            //降水量
            cell.pop.text = model.popDaily;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    
    //第五行
    else if (indexPath.section == 4){
        static NSString *cellID = @"WEATHERECELL";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"_isSelect"]) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"生活指数";
            cell.textLabel.font = [UIFont systemFontOfSize:18];
        }
        return cell;
    }
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = @"1";
    
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 4) {
        
        WeatherNavECell *eCell = [[WeatherNavECell alloc] init];
        eCell.model = _nowModel;
        
        [self.navigationController pushViewController:eCell animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
