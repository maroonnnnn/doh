//
//  addNoteViewController.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/24.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import "addNoteViewController.h"

@interface addNoteViewController ()<UIAlertViewDelegate>
@property UITextView *mytextView;

@end



@implementation addNoteViewController

//将要出现的时候隐藏tabbar
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}
//将要消失的时候显示tabbar
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
//    [self.mytextView resignFirstResponder];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置文本显示大小
    self.mytextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 0, WIDTH, HEIGHT-74)];
    [self.view addSubview:self.mytextView];
    
    //弹出键盘
    [self.mytextView becomeFirstResponder];
    
    //导航栏右侧保存按钮
    UIBarButtonItem *savebtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveclicked)];
    self.navigationItem.rightBarButtonItem = savebtn;
}

//保存按钮点击事件
- (void)saveclicked{
    NSMutableArray *initNoteArray = [[NSMutableArray alloc]init];
    
    //如果沙盒为空 新建
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"note"]==nil) {
        [[NSUserDefaults standardUserDefaults] setObject:initNoteArray forKey:@"note"];
    }
    //如果沙盒中已存在 覆盖原有数据
    NSArray *tempNoteArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    NSMutableArray *mutableNoteArray = [tempNoteArray mutableCopy];
    NSString *textstring = [self.mytextView text];
    [mutableNoteArray insertObject:textstring atIndex:0 ];
    
    //添加到TableView的数据源中
    NoteVC *note = [[NoteVC alloc]init];
    note.noteArray = mutableNoteArray;
    [[NSUserDefaults standardUserDefaults] setObject:mutableNoteArray forKey:@"note"];
    
    //日期
    NSMutableArray *initDateArray = [[NSMutableArray alloc]init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"date"]==nil) {
        [[NSUserDefaults standardUserDefaults] setObject:initDateArray forKey:@"date"];
    }
    NSArray *tempDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    NSMutableArray *mutableDateArray = [tempDateArray mutableCopy];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init ];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSDate *now = [NSDate date];
    NSString *datestring = [dateFormatter stringFromDate:now];
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

@end
