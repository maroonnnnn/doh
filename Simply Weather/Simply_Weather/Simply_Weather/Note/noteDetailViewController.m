//
//  noteDetailViewController.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/24.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import "noteDetailViewController.h"

@interface noteDetailViewController ()<UIAlertViewDelegate>
@property UITextView *mytextView;
@end


#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation noteDetailViewController

//将要出现时隐藏tabbar
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}
//将要消失时显示tabbar
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.mytextView resignFirstResponder];
    self.tabBarController.tabBar.hidden = NO;
}
//触摸收起键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.mytextView resignFirstResponder];
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.mytextView resignFirstResponder];
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置文本显示大小
    self.mytextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 0, WIDTH, HEIGHT)];
    
    
    //读取沙盒中的数据
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    NSString *oldtext = [array objectAtIndex:self.index];
    self.mytextView.text = oldtext;
    
    //创建导航栏右侧保存按钮
    UIBarButtonItem *savebtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveclicked)];

    self.navigationItem.rightBarButtonItem = savebtn;
    [self.view addSubview:self.mytextView];
}


//保存按钮点击事件
- (void)saveclicked{
    //读取沙盒
    NSArray *tempArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    NSMutableArray *mutableArray = [tempArray mutableCopy];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init ];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSDate *now = [NSDate date];
    NSString *datestring = [dateFormatter stringFromDate:now];
    NSString *textstring = [self.mytextView text];
    
    //更新数据
    [mutableArray removeObjectAtIndex:self.index];
    [mutableArray insertObject:textstring atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:mutableArray forKey:@"note"];
    NoteVC *note = [[NoteVC alloc]init];
    note.noteArray = mutableArray;
    
    NSArray *tempDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    NSMutableArray *mutableDateArray = [tempDateArray mutableCopy];
    [mutableDateArray removeObjectAtIndex:self.index];
    [mutableDateArray insertObject:datestring atIndex:0 ];
    note.dateArray = mutableDateArray;
    [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"date"];
    
    //收起键盘
    [self.mytextView resignFirstResponder];
    //弹出提示框
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"保存成功" delegate:self cancelButtonTitle:@"返回记事本" otherButtonTitles:@"留在本页", nil];
    [alertView show];
}
//返回记事本页面
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
            return;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
