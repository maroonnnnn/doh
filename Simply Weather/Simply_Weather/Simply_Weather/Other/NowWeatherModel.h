//
//  NowWeatherModel.h
//  Simply_Weather
//
//  Created by qianfeng on 16/2/25.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NowWeatherModel : NSObject

//now
@property (nonatomic,strong) NSString *tmpNow;//tmp--6
//now --> wind
@property (nonatomic,strong) NSString *degWindN;//deg--200° 风向
@property (nonatomic,strong) NSString *dirWindN;//dir--西南风 风向
@property (nonatomic,strong) NSString *scWindN;//sc--4-5级 风力
@property (nonatomic,strong) NSString *spdWindN;//spd--22kmph 风俗
//生活指数
//now --> suggestion --> comf  舒适度指数
@property (nonatomic,strong) NSString *brfComf;//brf--较舒适
@property (nonatomic,strong) NSString *txtComf;//txt--白天虽然天气晴好，但早晚会感觉偏凉，午后舒适、宜人。
//now --> suggestion --> cw  洗车指数
@property (nonatomic,strong) NSString *brfCw;//brf--较适宜
@property (nonatomic,strong) NSString *txtCw;//txt--较适宜洗车，未来一天无雨，风力较小，擦洗一新的汽车至少能保持一天。
//now --> suggestion --> drsg  穿衣指数
@property (nonatomic,strong) NSString *brfDrsg;//brf--较冷
@property (nonatomic,strong) NSString *txtDrsg;//txt--建议着厚外套加毛衣等服装。年老体弱者宜着大衣、呢外套加羊毛衫。
//now --> suggestion --> flu  感冒指数
@property (nonatomic,strong) NSString *brfFlu;//brf--较易发
@property (nonatomic,strong) NSString *txtFlu;//txt--昼夜温差较大，较易发生感冒，请适当增减衣服。体质较弱的朋友请注意防护。
//now --> suggestion --> sport  运动指数
@property (nonatomic,strong) NSString *brfSport;//brf--较不宜
@property (nonatomic,strong) NSString *txtSport;//txt--天气较好，但考虑天气寒冷，推荐您进行室内运动，户外运动时请注意保暖并做好准备活动。
//now --> suggestion --> trav  旅游指数
@property (nonatomic,strong) NSString *brfTrav;//brf--适宜
@property (nonatomic,strong) NSString *txtTrav;//txt--天气较好，气温稍低，会感觉稍微有点凉，不过也是个好天气哦。适宜旅游，可不要错过机会呦！
//now --> suggestion --> uv  紫外线指数
@property (nonatomic,strong) NSString *brfUv;//brf--中等
@property (nonatomic,strong) NSString *txtUv;//txt--属中等强度紫外线辐射天气，外出时建议涂擦SPF高于15、PA+的防晒护肤品，戴帽子、太阳镜。

- (instancetype)initWithDictionay:(NSDictionary *)dic;

@end
