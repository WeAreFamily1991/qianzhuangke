//
//  MLSearchViewController.m
//  Medicine
//
//  Created by Visoport on 2/1/17.
//  Copyright © 2017年 Visoport. All rights reserved.
//

#import "MLSearchViewController.h"
#import "MLSearchResultsTableViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "YJSegmentedControl.h"
#import "CategoryDetailVC.h"
#import "DRSellerListVC.h"
#define PYSEARCH_SEARCH_HISTORY_CACHE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"MLSearchhistories.plist"] // 历史搜索存储路径
#define PYSEARCH_SEARCH_BRANDHISTORY_CACHE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"MLSearchBRANDhistories.plist"] // 历史搜索存储路径

#define PYSEARCH_SEARCH_SELLERHISTORY_CACHE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"MLSearchSELLERhistories.plist"] // 历史搜索存储路径


@interface MLSearchViewController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource,YJSegmentedControlDelegate>


@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tagsView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic,strong)UILabel *rectangleTagLabel;
@property (nonatomic ,strong)UILabel *titleHeaderLabel;
@property (nonatomic,assign)NSInteger selectIndex;
/** 历史搜索 */
@property (nonatomic, strong) NSMutableArray *searchHistories;
/** 历史搜索缓存保存路径, 默认为PYSEARCH_SEARCH_HISTORY_CACHE_PATH(PYSearchConst.h文件中的宏定义) */
@property (nonatomic, copy) NSString *searchHistoriesCachePath;
/** 历史搜索记录缓存数量，默认为20 */
@property (nonatomic, assign) NSUInteger searchHistoriesCount;

/** 历史搜索 */
@property (nonatomic, strong) NSMutableArray *searchbrandHistories;
/** 历史搜索缓存保存路径, 默认为PYSEARCH_SEARCH_HISTORY_CACHE_PATH(PYSearchConst.h文件中的宏定义) */
@property (nonatomic, copy) NSString *searchbrandHistoriesCachePath;
/** 历史搜索记录缓存数量，默认为20 */
@property (nonatomic, assign) NSUInteger searchbrandHistoriesCount;

/** 历史搜索 */
@property (nonatomic, strong) NSMutableArray *searchsellerHistories;
/** 历史搜索缓存保存路径, 默认为PYSEARCH_SEARCH_HISTORY_CACHE_PATH(PYSearchConst.h文件中的宏定义) */
@property (nonatomic, copy) NSString *searchsellerHistoriesCachePath;
/** 历史搜索记录缓存数量，默认为20 */
@property (nonatomic, assign) NSUInteger searchsellerHistoriesCount;
/** 搜索建议（推荐）控制器 */
@property (nonatomic, weak) MLSearchResultsTableViewController *searchSuggestionVC;


@end

@implementation MLSearchViewController

- (MLSearchResultsTableViewController *)searchSuggestionVC
{
    if (!_searchSuggestionVC) {
        MLSearchResultsTableViewController *searchSuggestionVC = [[MLSearchResultsTableViewController alloc] initWithStyle:UITableViewStylePlain];
        __weak typeof(self) _weakSelf = self;
        searchSuggestionVC.didSelectText = ^(NSString *didSelectText) {
            
            if ([didSelectText isEqualToString:@""]) {
                [self.searchBar resignFirstResponder];
            }
            else
            {
                // 设置搜索信息
                _weakSelf.searchBar.text = didSelectText;
                
                // 缓存数据并且刷新界面
//                [_weakSelf saveSearchCacheAndRefreshView];
                
            }
            
            
        };
        searchSuggestionVC.view.frame = CGRectMake(0, 0, self.view.mj_w, self.view.mj_h);
        searchSuggestionVC.view.backgroundColor = BACKGROUNDCOLOR;

        [self.view addSubview:searchSuggestionVC.view];
        [self addChildViewController:searchSuggestionVC];
        _searchSuggestionVC = searchSuggestionVC;
    }
    return _searchSuggestionVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectIndex=0;
    // Do any additional setup after loading the view.
    self.view.backgroundColor =BACKGROUNDCOLOR;
    self.navigationItem.leftBarButtonItem.customView.hidden =YES;
    [self.navigationItem setHidesBackButton:YES];
    self.searchHistoriesCount = 20;
    self.searchbrandHistoriesCount =20;
    self.searchsellerHistoriesCount =20;
    NSArray * btnDataSource = @[@"搜商品", @"搜店铺"];
    
    //  第4部  调用创建
    YJSegmentedControl * segment = [YJSegmentedControl segmentedControlFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44) titleDataSource:btnDataSource backgroundColor:[UIColor whiteColor] titleColor:BLACKCOLOR titleFont:DR_FONT(14) selectColor:REDCOLOR buttonDownColor:REDCOLOR Delegate:self];
    // 第5步 添加到试图上
    [self.view addSubview:segment];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-44) style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//    self.tableView.backgroundView =back
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    // 创建搜索框
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW-64-20-40, WScale(40))];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(-10, WScale(3), titleView.frame.size.width, WScale(34))
                              ];
    searchBar.placeholder = @"搜索内容";
    searchBar.delegate = self;
    searchBar.searchBarStyle =UISearchBarStyleMinimal;
    searchBar.returnKeyType=UIReturnKeySearch;
//    searchBar.backgroundColor = BACKGROUNDCOLOR;
//    searchBar.tintColor =BACKGROUNDCOLOR;
    searchBar.layer.cornerRadius = 17;
    searchBar.layer.masksToBounds = YES;
//    [searchBar.layer setBorderWidth:8];
//    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
    [titleView addSubview:searchBar];
    self.searchBar = searchBar;
    self.navigationItem.titleView = titleView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelDidClick)];
    self.navigationController.navigationBar.tintColor = REDCOLOR;
    [self.navigationController.navigationItem setHidesBackButton:YES];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
//    self.navigationItem.leftBarButtonItem =[UIBarButtonItem ItemWithImage:nil WithSelected:nil Target:self action:@selector(leftBarButtonClick)];
    self.headerView = [[UIView alloc] init];
    self.headerView.backgroundColor =WHITECOLOR;
    self.headerView.mj_x = 0;
    self.headerView.mj_y = 0;
    self.headerView.mj_w = ScreenW;
    _titleHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ScreenW-20, WScale(50))];
    _titleHeaderLabel.text = @"热门搜索";
    _titleHeaderLabel.font = DR_FONT(14);
    _titleHeaderLabel.textColor = BLACKCOLOR;
    [_titleHeaderLabel sizeToFit];
    [self.headerView addSubview:_titleHeaderLabel];
    
  
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, WScale(45))];
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 1)];
    lineView.backgroundColor =BACKGROUNDCOLOR;
    [footView addSubview:lineView];
    
    UIButton *footBtn =[UIButton buttonWithLeftImage:@"分组 3" title:@"清空搜索记录" font:DR_FONT(12) titleColor:RGBHex(0X828282) backGroundColor:CLEARCOLOR target:self action:nil showView:footView];
    footBtn.frame =footView.frame;
    [footBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emptySearchHistoryDidClick)]];
    [footView addSubview:footBtn];
//    
    self.tableView.tableFooterView = footView;
    [self tagsViewWithTag];
 
}
-(void)leftBarButtonClick
{
    
}
#pragma mark -- 遵守代理 实现代理方法
- (void)segumentSelectionChange:(NSInteger)selection{
    if (selection == 0) {
        NSLog(@"商品");
    }else{
        NSLog(@"店铺");
    }
    self.selectIndex =selection;
     [self sethederSource];
    [self.tableView reloadData];
}
-(void)setHotSearchDic:(NSDictionary *)hotSearchDic
{
   
    _hotSearchDic =hotSearchDic;
    [self sethederSource];
}
-(void)sethederSource
{
    if (_tagsView) {
        [_tagsView removeFromSuperview];
    }
    NSArray *bigArr =@[_hotSearchDic[@"item"]?:@"",_hotSearchDic[@"seller"]?:@""];
    NSMutableArray *titleArr=[NSMutableArray array];
    for (NSDictionary *dic in bigArr[self.selectIndex]) {
        [titleArr addObject:dic];
    }
    self.tagsArray=titleArr;
    [self tagsViewWithTag];
}
- (void)tagsViewWithTag
{
    self.tagsView = [[UIView alloc] init];
    self.tagsView.mj_x = 10;
    self.tagsView.mj_y = _titleHeaderLabel.mj_y+30;
    self.tagsView.mj_w = ScreenW-20;
    [self.headerView addSubview:self.tagsView];
    //    self.tagsView.backgroundColor = REDCOLOR;
    //    self.headerView.backgroundColor = REDCOLOR;
    //    titleLabel.backgroundColor = [UIColor blueColor];
//    if (self.tagsArray.count!=0) {
        self.tableView.tableHeaderView = self.headerView;
//    }else
//    {
//         self.tableView.tableHeaderView = [UIView new];
//    }
   
    CGFloat allLabelWidth = 0;
    CGFloat allLabelHeight = 0;
    int rowHeight = 0;
    for (int i = 0; i < self.tagsArray.count; i++) {
        if (i != self.tagsArray.count-1) {
            CGFloat width = [self getWidthWithTitle:self.tagsArray[i+1] font:[UIFont systemFontOfSize:14]];
            if (allLabelWidth + width+10 > self.tagsView.frame.size.width) {
                rowHeight++;
                allLabelWidth = 0;
                allLabelHeight = rowHeight*40;
            }
        }
        else
        {
            CGFloat width = [self getWidthWithTitle:self.tagsArray[self.tagsArray.count-1] font:[UIFont systemFontOfSize:14]];
            if (allLabelWidth + width+10 > self.tagsView.frame.size.width) {
                rowHeight++;
                allLabelWidth = 0;
                allLabelHeight = rowHeight*40;
            }
        }

         _rectangleTagLabel= [[UILabel alloc] init];
        // 设置属性
        _rectangleTagLabel.userInteractionEnabled = YES;
        _rectangleTagLabel.font = [UIFont systemFontOfSize:14];
        _rectangleTagLabel.textColor = [UIColor grayColor];
        _rectangleTagLabel.backgroundColor = BACKGROUNDCOLOR;
        _rectangleTagLabel.text = self.tagsArray[i];
        _rectangleTagLabel.textAlignment = NSTextAlignmentCenter;
        [_rectangleTagLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        
        CGFloat labelWidth = [self getWidthWithTitle:self.tagsArray[i] font:[UIFont systemFontOfSize:14]];
        _rectangleTagLabel.layer.cornerRadius = 3;
        [_rectangleTagLabel.layer setMasksToBounds:YES];
        
        _rectangleTagLabel.frame = CGRectMake(allLabelWidth, allLabelHeight, labelWidth, 25);
        [self.tagsView addSubview:_rectangleTagLabel];
        
        allLabelWidth = allLabelWidth+10+labelWidth;
    }
    self.tagsView.mj_h = rowHeight*40+40;
//    if (self.tagsArray.count!=0) {
        self.headerView.mj_h = self.tagsView.mj_y+self.tagsView.mj_h+10;
//    }else
//    {
//        self.headerView.mj_h = 0;
//    }
}

/** 选中标签 */
- (void)tagDidCLick:(UITapGestureRecognizer *)gr
{
    UILabel *label = (UILabel *)gr.view;
    self.searchBar.text = label.text;
    if (self.selectIndex==0) {
        // 缓存数据并且刷新界面
        [self saveSearchCacheAndRefreshView];
    }else
    {
        // 缓存数据并且刷新界面
        [self savesellerSearchCacheAndRefreshView];
    }
   
   [self pushResultVCWithText:label.text];
}



- (void)cancelDidClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

/** 视图完全显示 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 弹出键盘
    [self.searchBar becomeFirstResponder];
}

/** 视图即将消失 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 回收键盘
    [self.searchBar resignFirstResponder];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.selectIndex==0) {
        self.tableView.tableFooterView.hidden = self.searchHistories.count == 0;
        return self.searchHistories.count;
        
    }
    else{
        self.tableView.tableFooterView.hidden = self.searchsellerHistories.count == 0;
        return self.searchsellerHistories.count;        
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    // 添加关闭按钮
    UIButton *closetButton = [[UIButton alloc] init];
    // 设置图片容器大小、图片原图居中
    closetButton.mj_size = CGSizeMake(cell.mj_h, cell.mj_h);
//    [closetButton setTitle:@"x" forState:UIControlStateNormal];
    [closetButton setImage:[UIImage imageNamed:@"ico／close2"] forState:UIControlStateNormal];
    [closetButton addTarget:self action:@selector(closeDidClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryView = closetButton;
    [closetButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.imageView.image =[UIImage imageNamed:@"search_ico_lishi"];
    if (self.selectIndex==0) {
        cell.textLabel.text = self.searchHistories[indexPath.row];
    }
    else{
        cell.textLabel.text = self.searchsellerHistories[indexPath.row];
    }
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.selectIndex==0) {
        if (self.searchHistories.count != 0) {
            return @"历史搜索";
        }
    }
   else{
        if (self.searchsellerHistories.count != 0) {
            return @"历史搜索";
        }
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WScale(50))];
    view.backgroundColor = [UIColor whiteColor];
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, WScale(0))];
    lineView.backgroundColor =BLACKCOLOR;
    [view addSubview:lineView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WScale(10), WScale(0), ScreenW-WScale(20), WScale(50))];
    titleLabel.text = @"历史搜索";
    titleLabel.font = [UIFont systemFontOfSize:14];
    [titleLabel sizeToFit];
    [view addSubview:titleLabel];
    
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出选中的cell
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectIndex==0) {

        [self pushResultVCWithText:self.searchHistories[indexPath.row]];
        
    }
   else{
      
         [self pushResultVCWithText:self.searchsellerHistories[indexPath.row]];
    }
    
}

- (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width+10;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 滚动时，回收键盘
    [self.searchBar resignFirstResponder];
}

- (NSMutableArray *)searchHistories
{
    
    if (!_searchHistories) {
        self.searchHistoriesCachePath = PYSEARCH_SEARCH_HISTORY_CACHE_PATH;
        _searchHistories = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:self.searchHistoriesCachePath]];
        
    }
    return _searchHistories;
}

- (NSMutableArray *)searchbrandHistories
{
    
    if (!_searchbrandHistories) {
        self.searchbrandHistoriesCachePath = PYSEARCH_SEARCH_BRANDHISTORY_CACHE_PATH;
        _searchbrandHistories = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:self.searchbrandHistoriesCachePath]];
        
    }
    return _searchbrandHistories;
}


- (NSMutableArray *)searchsellerHistories
{
    
    if (!_searchsellerHistories) {
        self.searchsellerHistoriesCachePath = PYSEARCH_SEARCH_SELLERHISTORY_CACHE_PATH;
        _searchsellerHistories = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:self.searchsellerHistoriesCachePath]];
        
    }
    return _searchsellerHistories;
}
- (void)setSearchHistoriesCachePath:(NSString *)searchHistoriesCachePath
{
    _searchHistoriesCachePath = [searchHistoriesCachePath copy];
    // 刷新
    self.searchHistories = nil;

    [self.tableView reloadData];
}

- (void)setSearchbrandHistoriesCachePath:(NSString *)searchbrandHistoriesCachePath
{
    _searchbrandHistoriesCachePath = [searchbrandHistoriesCachePath copy];
    // 刷新
    self.searchbrandHistories = nil;
    
    [self.tableView reloadData];
}
- (void)setSearchsellerHistoriesCachePath:(NSString *)searchsellerHistoriesCachePath
{
    _searchsellerHistoriesCachePath = [searchsellerHistoriesCachePath copy];
    // 刷新
    self.searchsellerHistories = nil;
    
    [self.tableView reloadData];
}

/** 进入搜索状态调用此方法 */
- (void)saveSearchCacheAndRefreshView
{
    UISearchBar *searchBar = self.searchBar;
    // 回收键盘
    [searchBar resignFirstResponder];
    // 先移除再刷新
    [self.searchHistories removeObject:searchBar.text];
    [self.searchHistories insertObject:searchBar.text atIndex:0];
    
    // 移除多余的缓存
    if (self.searchHistories.count > self.searchHistoriesCount) {
        // 移除最后一条缓存
        [self.searchHistories removeLastObject];
    }
    // 保存搜索信息
    [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];
    
    [self.tableView reloadData];
}


/** 进入搜索状态调用此方法 */
- (void)savebrandSearchCacheAndRefreshView
{
    UISearchBar *searchBar = self.searchBar;
    // 回收键盘
    [searchBar resignFirstResponder];
    // 先移除再刷新
    [self.searchbrandHistories removeObject:searchBar.text];
    [self.searchbrandHistories insertObject:searchBar.text atIndex:0];
    
    // 移除多余的缓存
    if (self.searchbrandHistories.count > self.searchbrandHistoriesCount) {
        // 移除最后一条缓存
        [self.searchbrandHistories removeLastObject];
    }
    // 保存搜索信息
    [NSKeyedArchiver archiveRootObject:self.searchbrandHistories toFile:self.searchbrandHistoriesCachePath];
    
    [self.tableView reloadData];
}

/** 进入搜索状态调用此方法 */
- (void)savesellerSearchCacheAndRefreshView
{
    UISearchBar *searchBar = self.searchBar;
    // 回收键盘
    [searchBar resignFirstResponder];
    // 先移除再刷新
    [self.searchsellerHistories removeObject:searchBar.text];
    [self.searchsellerHistories insertObject:searchBar.text atIndex:0];
    // 移除多余的缓存
    if (self.searchsellerHistories.count > self.searchsellerHistoriesCount) {
        // 移除最后一条缓存
        [self.searchsellerHistories removeLastObject];
    }
    // 保存搜索信息
    [NSKeyedArchiver archiveRootObject:self.searchsellerHistories toFile:self.searchsellerHistoriesCachePath];
    [self.tableView reloadData];
}
- (void)closeDidClick:(UIButton *)sender
{
    // 获取当前cell
    UITableViewCell *cell = (UITableViewCell *)sender.superview;
    if (self.selectIndex==0) {
        // 移除搜索信息
        [self.searchHistories removeObject:cell.textLabel.text];
        // 保存搜索信息
        [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:PYSEARCH_SEARCH_HISTORY_CACHE_PATH];
        if (self.searchHistories.count == 0) {
            self.tableView.tableFooterView.hidden = YES;
        }
    }else
    {
        // 移除搜索信息
        [self.searchsellerHistories removeObject:cell.textLabel.text];
        // 保存搜索信息
        [NSKeyedArchiver archiveRootObject:self.searchsellerHistories toFile:PYSEARCH_SEARCH_HISTORY_CACHE_PATH];
        if (self.searchsellerHistories.count == 0) {
            self.tableView.tableFooterView.hidden = YES;
        }
    }
   
    // 刷新
    [self.tableView reloadData];
}
/** 点击清空历史按钮 */
- (void)emptySearchHistoryDidClick
{
    self.tableView.tableFooterView.hidden = YES;
    if (self.selectIndex==0) {
        // 移除所有历史搜索
        [self.searchHistories removeAllObjects];
        // 移除数据缓存
        [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];
    }else
    {
        // 移除所有历史搜索
        [self.searchsellerHistories removeAllObjects];
        // 移除数据缓存
        [NSKeyedArchiver archiveRootObject:self.searchsellerHistories toFile:self.searchsellerHistoriesCachePath];
    }

    [self.tableView reloadData];
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (self.selectIndex==0) {
        // 缓存数据并且刷新界面
        [self saveSearchCacheAndRefreshView];
    }else
    {
        // 缓存数据并且刷新界面
        [self savesellerSearchCacheAndRefreshView];
    }
    [self pushResultVCWithText:searchBar.text];

    
}
-(void)pushResultVCWithText:(NSString *)searchText
{
    if (self.selectIndex==0) {
        CategoryDetailVC *goodSetVc =[[CategoryDetailVC alloc] init];
        goodSetVc.classListStr =@"";
        goodSetVc.czID =@"";
        goodSetVc.queryTypeStr =@"search";
        goodSetVc.keyWordStr =searchText;
        [GoodsShareModel sharedManager].queryType =goodSetVc.queryTypeStr;
        [self.navigationController pushViewController:goodSetVc animated:YES];
    }
    else
    {
        DRSellerListVC *selllistVC=[[DRSellerListVC alloc]init];
        selllistVC.keywordStr =searchText;
        [self.navigationController pushViewController:selllistVC animated:YES];
    }
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

@end
