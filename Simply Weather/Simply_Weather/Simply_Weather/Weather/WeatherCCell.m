//
//  WeatherCCell.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/27.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import "WeatherCCell.h"
#import "HourlyForecastModel.h"

@implementation WeatherCCell
{
    NSNumber *_temp;
}

//获取屏幕的宽高
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

+ (WeatherCCell *)newsTableView:(UITableView *)tableView hourlyModelArr:(NSMutableArray *)hourlyModelArr{
    
    WeatherCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WeatherCCell" owner:self options:nil]lastObject];
    }


    NSMutableArray *tmp = [NSMutableArray array];
    NSMutableArray *date = [NSMutableArray array];
    NSMutableArray *hum = [NSMutableArray array];
    NSMutableArray *pop = [NSMutableArray array];
    for (int i = 0; i < hourlyModelArr.count; i++) {
        HourlyForecastModel *model = hourlyModelArr[i];

        //温度
        [tmp addObject:model.tmpHourly];

        //时间
        NSArray *arr = [model.dateHourly componentsSeparatedByString:@" "];
        [date addObject:arr[1]];
        
        //降水量
        [hum addObject:model.humHourly];
        
        //降水概率
        [pop addObject:model.popHourly];
    }

    
    //创建时间ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(70, 0, 0, 0)];
    scrollView.contentSize = CGSizeMake(tmp.count * 70, 250);
    scrollView.delegate = cell;
    [cell addSubview:scrollView];
    
    for (int i = 0; i < tmp.count; i++) {
        //创建时间label
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * 70, 210, 50, 20)];
        timeLabel.text = date[i];
        timeLabel.font = [UIFont systemFontOfSize:15];
        timeLabel.textColor = [UIColor blackColor];
        [scrollView addSubview:timeLabel];
        
        //创建温度Label
        UILabel *tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * 70, 20, 50, 50)];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"_isSelect"] isEqualToString:@"1"]) {
            tmpLabel.text = [NSString stringWithFormat:@"%@°C",tmp[i]];
        }else{
            tmpLabel.text = [NSString stringWithFormat:@"%.1f°F", [tmp[i] intValue] * 1.8 + 32];
        }
        tmpLabel.textColor = [UIColor blackColor];
        tmpLabel.font = [UIFont boldSystemFontOfSize:18];
        [scrollView addSubview:tmpLabel];
        
        //创建降水概率Label
        UILabel *popLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * 70, 160, 50, 20)];
        popLabel.text = pop[i];
        popLabel.textColor = [UIColor blackColor];
        popLabel.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:popLabel];
    }
    

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
