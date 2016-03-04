//
//  NoteVC.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/23.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import "NoteVC.h"


//功能按钮
#import "DCPathButton.h"
//新建记事本
#import "addNoteViewController.h"
//记事本编辑页
#import "noteDetailViewController.h"

@interface NoteVC ()<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,DCPathButtonDelegate>

@end


@implementation NoteVC
{
    //搜索数据源
    NSMutableArray *_filteredNoteArray;
    //定义搜索界面
    UISearchController*_searchController;
    UITableView *_myTableView;
    
    //编辑状态
    BOOL _isEditing;
    //导航栏按钮
    NSMutableArray *_itemArray;
}


//页面将要出现时
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设为非编辑状态
    _isEditing = NO;
    
    //显示搜索栏
    _searchController.searchBar.hidden = NO;
    
    //读取沙盒中的数据
    NSArray *noteArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    _noteArray = [NSMutableArray arrayWithArray:noteArray];
    NSArray *dateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    _dateArray = [NSMutableArray arrayWithArray:dateArray];
    //刷新列表
    [_myTableView reloadData];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [_myTableView setEditing:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isEditing = NO;
    
    //导航栏设置
    [self setNavigationBar];
    
    //创建TableView
    [self createTableView];
    
    //设置搜索栏
    [self setSearchBar];
    
    //设置按钮
    [self configureDCPathButton];
    
}
//导航栏设置
- (void)setNavigationBar{
    //推出左侧视图的按钮和图片
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"thth"] style:UIBarButtonItemStylePlain target:self action:@selector(leftVC)];
    
    //创建导航栏右侧按钮
    //新建按钮
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"新建" style:UIBarButtonItemStylePlain target:self action:@selector(addNote)];
    //编辑按钮
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editNote)];
    
    _itemArray = [NSMutableArray arrayWithArray:@[addButton, editButton]];
    
    self.navigationItem.rightBarButtonItems = _itemArray;
    
    //设置导航栏标题
    self.navigationItem.title = @"记事本";
}

- (void)leftVC{
    //获取window的根视图
    YRSideViewController *root = (id)[[UIApplication sharedApplication] keyWindow].rootViewController;
    [root showLeftViewController:YES];
}
//编辑事件
- (void)editNote{
    //编辑状态
    if (_isEditing) {
        _isEditing = NO;
//        [self createDeleteItem];
    }else{
        //非编辑状态
        _isEditing = YES;
    }
    [_myTableView setEditing:_isEditing animated:YES];
}



//调用父类编辑方法  并重写
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [_myTableView setEditing:editing animated:animated];
}
//设置编辑模式为删除 可编辑后 需提交
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
//删除方法的实现  从数据源、TableView删除相应的数据，更新沙盒
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //1 从数组中删除
    [_noteArray removeObjectAtIndex:indexPath.row];

    //2 从TableView中删除
    [_myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    //3 更新沙盒
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_noteArray forKey:@"note"];

}
#pragma mark === 创建TableView ===
- (void)createTableView{
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-40) style:UITableViewStylePlain];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置代理
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
}

#pragma mark === 设置搜索栏 ===
- (void)setSearchBar{

    //初始化搜索数据源
    _filteredNoteArray = [NSMutableArray array];
    //本页面展示搜索结果  nil
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    //不隐藏NavigationBar在搜索时
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.dimsBackgroundDuringPresentation = NO;
    
    //指定代理
    _searchController.searchResultsUpdater = self;
    //设置SearchBar的frame
    _searchController.searchBar.frame = CGRectMake(0, 40, WIDTH, 44);
    //将searchBar赋值给HeaderView
    [_myTableView setTableHeaderView:_searchController.searchBar];
}

#pragma mark === TableView 协议 ===
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_searchController.active) {
        //正使用搜索功能
        return [_filteredNoteArray count];
    }
    else return [_noteArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"NOTECELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    //设置cell折角
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *note = nil;
    
    //根据是否是搜索栏使用中 选择数据源
    if (_searchController.active) {
        note = [_filteredNoteArray objectAtIndex:indexPath.row];
    }else{
        note = [_noteArray objectAtIndex:indexPath.row];
    }
    
    //设置cell中显示的文本信息
    NSString *date = [_dateArray objectAtIndex:indexPath.row];
    NSUInteger charnum = [note length];
    if (charnum < 22) {
        cell.textLabel.text = note;
    }else{
        cell.textLabel.text = [[note substringToIndex:18] stringByAppendingString:@"..."];
    }
    //设置副标题字体大小 (日期)
    cell.detailTextLabel.text = date;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    return cell;
}
//当cell被选中时
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_searchController.active) {
        _searchController.searchBar.hidden = YES;
        [_searchController.searchBar resignFirstResponder];
    }
    
    //打开文本
    noteDetailViewController *modify = [[noteDetailViewController alloc] init];
    [self.navigationController pushViewController:modify animated:YES];
    NSInteger row = indexPath.row;
    modify.index = row;
}

#pragma mark === UISearchResultsUpdating ===
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    //移除所有数据
    [_filteredNoteArray removeAllObjects];
    
    //搜索语句
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains[cd] %@", searchController.searchBar.text];
    
    //搜索
    NSArray *arr = [_noteArray filteredArrayUsingPredicate:predicate];
    
    //将得到的数据放入搜索数据源中
    [_filteredNoteArray addObjectsFromArray:arr];
    
    [_myTableView reloadData];
}

#pragma mark === 新建记事本 ===
- (void)addNote{
    //新建记事本对象
    addNoteViewController *addVC = [[addNoteViewController alloc] init];
    //跳转到记事本
    [self.navigationController pushViewController:addVC animated:YES];
}


- (void)configureDCPathButton{
    DCPathButton *button = [[DCPathButton alloc] initWithCenterImage:[UIImage imageNamed:@"editt"] highlightedImage:[UIImage imageNamed:@"editt"]];
    button.delegate = self;
    
    DCPathItemButton *itemButton_1 = [[DCPathItemButton alloc] initWithImage:[UIImage imageNamed:@"cloudcloud"] highlightedImage:[UIImage imageNamed:@"cloudcloud"] backgroundImage:nil backgroundHighlightedImage:nil];
    DCPathItemButton *itemButton_2 = [[DCPathItemButton alloc] initWithImage:[UIImage imageNamed:@"newss@1x"] highlightedImage:[UIImage imageNamed:@"newss@1x"] backgroundImage:nil backgroundHighlightedImage:nil];
    DCPathItemButton *itemButton_3 = [[DCPathItemButton alloc] initWithImage:[UIImage imageNamed:@"settingsButton"] highlightedImage:[UIImage imageNamed:@"settingsButton"] backgroundImage:nil backgroundHighlightedImage:nil];
    
    [button addPathItems:@[itemButton_1,itemButton_2,itemButton_3]];
    button.bloomRadius = 120;
    button.allowSounds = YES;
    button.allowCenterButtonRotation = YES;
    button.bottomViewColor = [UIColor lightGrayColor];
    
    //子按钮出来的方向
    button.bloomDirection = kDCPathButtonBloomDirectionTopRight;
    
    button.dcButtonCenter = CGPointMake(10 + button.frame.size.width/2, HEIGHT - button.frame.size.height/2 - 10);
    button.bottomViewColor = [UIColor clearColor];
    
    [self.view addSubview:button];
}
- (void)pathButton:(DCPathButton *)dcPathButton clickItemButtonAtIndex:(NSUInteger)itemButtonIndex{
    if (itemButtonIndex == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    
    for (int i = 0; i < [self.navigationController.viewControllers count]; i++) {
        if(itemButtonIndex == 1){
            if ([self.navigationController.viewControllers[i] isMemberOfClass:[NewsTodayVCs class]]) {
                [self.navigationController popToViewController:self.navigationController.viewControllers[i] animated:YES];
                return;
            }
        }else if (itemButtonIndex == 2){
            if ([self.navigationController.viewControllers[i] isMemberOfClass:[SetVC class]]) {
                [self.navigationController popToViewController:self.navigationController.viewControllers[i] animated:YES];
                return;
            }
        }
    }
    
    if (itemButtonIndex == 1){
        NewsTodayVCs *vc = [[NewsTodayVCs alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(itemButtonIndex == 2){
        SetVC *vc = [SetVC shared];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
