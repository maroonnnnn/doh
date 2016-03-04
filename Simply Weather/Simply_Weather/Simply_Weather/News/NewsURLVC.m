//
//  NewsURLVC.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/26.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import "NewsURLVC.h"

@interface NewsURLVC ()<UIWebViewDelegate, UIGestureRecognizerDelegate>

@end

@implementation NewsURLVC

{
    UIWebView *_webView;
}
#define SIZE [UIScreen mainScreen].bounds.size

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 50, SIZE.width, SIZE.height-50)];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    
    [_webView loadRequest:request];
    
    //指定代理类
    _webView.delegate = self;
    
    [self.view addSubview:_webView];
    
}
@end
