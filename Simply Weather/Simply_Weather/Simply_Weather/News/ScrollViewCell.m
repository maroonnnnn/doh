//
//  ScrollViewCell.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/26.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import "ScrollViewCell.h"
//网页跳转
#import "NewsURLVC.h"

//管理类
#import "NavigationVC.h"

#import "UIImageView+AFNetworking.h"

@interface ScrollViewCell ()<UIScrollViewDelegate>
{
    UIPageControl *_pageControl;
    UIScrollView *_scrollView;
    
}

#define SIZE [UIScreen mainScreen].bounds.size

@end

@implementation ScrollViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createScrollView];
    }
    return self;
}

- (ScrollViewCell *)newsTableView:(UITableView *)tableView picArr:(NSArray *)picArr title:(NSArray *)titleArr linkArr:(NSArray *)linkArr{
    ScrollViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SCROLLCELL"];
    if (!cell) {
        cell = [[ScrollViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SCROLLCELL"];
    }

    cell.picArr = picArr;
    cell.titleArr = titleArr;
    cell.linkArr = linkArr;
    
    [cell func];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)func{
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    [_scrollView addGestureRecognizer:tap];
    
    [_pageControl addTarget:self action:@selector(pageChange) forControlEvents:UIControlEventValueChanged];
    
    //添加子视图
    for (int i = 0; i < _pageControl.numberOfPages; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * SIZE.width, 0, SIZE.width, 200)];
        [imageView setImageWithURL:[NSURL URLWithString:_picArr[i]]];
        [_scrollView addSubview:imageView];
        [self.contentView sendSubviewToBack:_scrollView];
    }
    
    //添加定时器 自动滚动
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(time) userInfo:_pageControl repeats:YES];
}

- (void)createScrollView{
    //创建UIView
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 170, SIZE.width, 30)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.6;
    [self.contentView addSubview:view];
    
    //创建PageControl
    //实例化pageControl
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.frame = CGRectMake(SIZE.width-80, 0, 80, 30);
    _pageControl.numberOfPages = 4;
    _pageControl.currentPage = 0;
    [view addSubview:_pageControl];
    
    //创建UILabel   titleLabel
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH - 90, 30)];
    label.font = [UIFont systemFontOfSize:15];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.adjustsFontSizeToFitWidth = YES;
    label.tag = 1;
    [view addSubview:label];
    
    //创建ScrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, 200)];
    _scrollView.contentSize = CGSizeMake(SIZE.width * _pageControl.numberOfPages, 200);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self.contentView addSubview:_scrollView];
}

//ScrollView点击事件
- (void)click{
    
    //通知NewsVC有ScrollView点击事件
    //  获取通知中心
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    //  创建通知
    NSNotification *cellClick= [[NSNotification alloc] initWithName:@"cellClick" object:_linkArr[_pageControl.currentPage] userInfo:nil];
    //  发送通知
    [nc postNotification:cellClick];
}

//定时器
-(void)time{
    //图片
    if (_pageControl.currentPage == _pageControl.numberOfPages - 1) {
        _pageControl.currentPage = 0;
    }
    else _pageControl.currentPage++;
    
    
    //标题 图片
    _scrollView.contentOffset = CGPointMake(SIZE.width * _pageControl.currentPage , 0);
    
    UILabel *label = (id)[self.contentView viewWithTag:1];
    label.text = [NSString stringWithFormat:@"%@",_titleArr[_pageControl.currentPage]];
}

-(void)pageChange{
    NSUInteger index = _pageControl.currentPage;
    _scrollView.contentOffset = CGPointMake(index * SIZE.width, 0);
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
