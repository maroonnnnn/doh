//
//  MoreNewsItem.m
//  Simply_Weather
//
//  Created by qianfeng on 16/3/3.
//  Copyright (c) 2016年 maroonnnnn. All rights reserved.
//

#import "MoreNewsItem.h"

//自定义的UIView
#import "BYDetailsList.h"
#import "BYDeleteBar.h"

@interface MoreNewsItem ()


@end

@implementation MoreNewsItem
{
    NSMutableArray *_listArray;
    UIView *_labelView;
}

+ (MoreNewsItem *)shared{
    static MoreNewsItem *item = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (item == nil) {
            item = [[MoreNewsItem alloc] init];
        }
    });
    return item;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //读取沙盒中的listTop数据
    [_listArray addObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"listTop"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_listArray addObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"listTop"]];
    
    [self makeContent];
}


- (void)makeContent{
    //频道切换
    UIView *changeView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 30)];
    [self.view addSubview:changeView];
    
    UILabel *changeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 80, 20)];
    changeLabel.text = @"频道切换";
    changeLabel.textAlignment = NSTextAlignmentCenter;
    changeLabel.textColor = [UIColor blackColor];
    [changeView addSubview:changeLabel];
    
    UIButton *managerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    managerButton.frame = CGRectMake(WIDTH-50, 5, 50, 20);
    [managerButton setTitle:@"管理" forState:UIControlStateNormal];
    [managerButton setTitleColor:COLOR forState:UIControlStateNormal];
    [managerButton addTarget:self action:@selector(manager:) forControlEvents:UIControlEventTouchUpInside];
    [changeView addSubview:managerButton];
    
    //频道下划线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 94, WIDTH, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    
    //放置频道Label的View
    _labelView = [[UIView alloc] initWithFrame:CGRectMake(0, 94, WIDTH, 200)];
    [self.view addSubview:_labelView];
    
    //宽
    int width = (WIDTH - 50) / 4;
    int height = 35;
    
    for (int i = 0; i <= _listArray.count; i++) {
        int x = i % 4;
        int y = i / 4;
        
        if (i == _listArray.count) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(x * (10 + width) + 10, y *(10 + height) + 10, width, height);
            [button addTarget:self action:@selector(addNewsItem) forControlEvents:UIControlEventTouchUpInside];
            button.layer.borderWidth = 1;
            button.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [_labelView addSubview:button];
            UILabel *buttonLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height - 5)];
            buttonLabel.text = @"+";
            buttonLabel.textAlignment = NSTextAlignmentCenter;
            buttonLabel.textColor = [UIColor blackColor];
            buttonLabel.font = [UIFont boldSystemFontOfSize:25];
            buttonLabel.backgroundColor = [UIColor clearColor];
            [button addSubview:buttonLabel];
            break;
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x * (10 + width) + 10, y * (10 + height) + 10, width, height)];
        label.text = _listArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        if (i == 0) {
            label.textColor = [UIColor redColor];
            label.tag = 1111;
        }
        label.layer.borderWidth = 1;
        label.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [_labelView addSubview:label];
    }
}

//管理按钮点击事件
- (void)manager:(UIButton *)button{
    NSLog(@"编辑");
    //按钮改变 头条不可编辑
    UILabel *label = (id)[_labelView viewWithTag:1111];
    if ([button.titleLabel.text isEqualToString:@"管理"]) {
        [button setTitle:@"完成" forState:UIControlStateNormal];
        label.textColor = [UIColor lightGrayColor];
        
        //其他频道可编辑
        //宽
        int width = (WIDTH - 50) / 4;
        int height = 35;
        for (int i = 0; i < _listArray.count; i++) {
            int x = i % 4;
            int y = i / 4;
            if (i == 0) {
                break;
            }
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
            button.frame = CGRectMake(x * (10 + width) - 5, y * (10 + height) - 5, 15, 15);
            button.tag = 100 + i;
            [button addTarget:self action:@selector(deleteItem:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
    }else{
        [button setTitle:@"管理" forState:UIControlStateNormal];
        label.textColor = [UIColor redColor];
        
        for (int i = 1; i < _listArray.count; i++) {
            UIButton *button = (id)[self.view viewWithTag:100 + i];
            [self.view delete:button];
        }
    }
}
//删除图标点击事件
- (void)deleteItem:(UIButton *)sender{
    UIButton *button = sender;
    NSInteger index = button.tag;
//    NSString *item
    //删除对应的Item
    [_listArray removeObjectAtIndex:index];
    //更新沙盒
    [[NSUserDefaults standardUserDefaults] setObject:_listArray forKey:@"listTop"];
}
- (void)addNewsItem{
    NSLog(@"增加");
    
}
     
     
     
     

@end
