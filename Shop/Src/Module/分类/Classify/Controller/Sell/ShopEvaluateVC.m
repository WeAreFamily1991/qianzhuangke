//
//  ShopEvaluateVC.m
//  Shop
//
//  Created by BWJ on 2019/3/11.
//  Copyright © 2019 SanTie. All rights reserved.
//
#import "HJHoverTable.h"
#import "ShopEvaluateVC.h"
#import "ReserveEvluateCell.h"
#import "EvaluateModel.h"
//#import "NewShopListModel.h"
#import "SDPhotoBrowser.h"
@interface ShopEvaluateVC ()<UITableViewDelegate,UITableViewDataSource,ReserveEvluateCellDelegate,SDPhotoBrowserDelegate,HJHoverTableDelegate>
{
    NSInteger _evluateLastIndex;//上次点击的索引值
    NSInteger _evaluateType;//评价类型，推荐，一般，不满意
    NSInteger       _currPage;//页数索引
    NSInteger _count;//总共多少条数据
    NSMutableArray *_dataArray;//数据源数组
    NSInteger _selectedIndex;//被选中图片所在的cell索引
    
    ///上拉加载相关-----
    UIActivityIndicatorView *_loadView;//菊花
    BOOL _isLoading;//是否正在加载
    BOOL  _gestureEnd;//手势是否已经结束
    BOOL _isMoreThan;
    UILabel *_noDateLab;//无数据提示
    
}
@property (nonatomic , strong) HJHoverTable *hoverTable;
@property (nonatomic , strong) UIView *evluateItemView;

@end
static const CGFloat ORIGIN_TOP = 40.f;

@implementation ShopEvaluateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _evluateLastIndex = 10010;
    _currPage = 1;
    _dataArray = [NSMutableArray array];
//    _groupId = groupId;
    [self.view addSubview:self.evluateItemView];
    [self createView];
    [self requestGetNewShopCommList];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gestureStateBegan:) name:@"GestureRecognizerStateBegan" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gestureStateEnd:) name:@"GestureRecognizerStateEnded" object:nil];
    // Do any additional setup after loading the view from its nib.
}
- (UIView *)evluateItemView
{
    if (!_evluateItemView) {
        _evluateItemView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _evluateItemView.backgroundColor = [UIColor whiteColor];
        NSArray *array = @[@"全部",@"推荐(0)",@"一般(0)",@"不满意(0)"];
        NSArray *prcents = @[@0.2,@0.25,@0.25,@0.30];
        CGFloat content_w = SCREEN_WIDTH - 45 - 30;
        CGFloat max_X = 10;
        for (int i = 0; i<array.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitle:array[i] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor lightGrayColor];
            btn.titleLabel.font =DR_FONT(12);
            btn.layer.cornerRadius = 12.5;
            btn.layer.masksToBounds = YES;
            btn.tag = 10010 + i ;
            [btn addTarget:self action:@selector(evluateItemClick:) forControlEvents:UIControlEventTouchUpInside];
            CGFloat btnW = [prcents[i] floatValue];
            btn.frame = CGRectMake(max_X, 10, content_w*btnW, 25);
            max_X = btn.maxX+15;
            if (i == 0) {
                [self evluateItemClick:btn];
            }
            [_evluateItemView addSubview:btn];
        }
        UILabel *line = [UITool lineLabWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
        line.backgroundColor = RGBHex(0XE2E2E2);
        [_evluateItemView addSubview:line];
    }
    return _evluateItemView;
}

//推荐，一般，有图
- (void)evluateItemClick:(UIButton *)btn
{
    UIButton *lastBT = (UIButton *)[_evluateItemView viewWithTag:_evluateLastIndex];
    lastBT.backgroundColor = [UIColor lightGrayColor];
    btn.backgroundColor = REDCOLOR;
    if (_evluateLastIndex != btn.tag) {
        //切换菜单的时候，删除所有手势，禁止滑动
        [[NSNotificationCenter defaultCenter] postNotificationName:@"removeAllBehaviors" object:self];
        _evaluateType = btn.tag - 10010;
        [_dataArray removeAllObjects];
        _currPage = 1;
        [_hoverTable reloadData];
        _loadView.frame = CGRectMake(self.view.center.x - 40, 0 , 80, 50);
        [self requestGetNewShopCommList];
    }
    _evluateLastIndex  = btn.tag;
}

//- (id)initWithFrame:(CGRect)frame  withGroupID:(NSString *)groupId
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.backgroundColor = [UIColor whiteColor];
//
//
//        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gestureStateBegan:) name:@"GestureRecognizerStateBegan" object:nil];
//        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gestureStateEnd:) name:@"GestureRecognizerStateEnded" object:nil];
//    }
//    return self;
//}

//#pragma mark ---通知方法
//- (void)gestureStateBegan:(NSNotification *)not{
//
//    BOOL isMore = _tableView.contentOffset.y >= (_tableView.contentSize.height - _tableView.height);
//    if (isMore) {
//        _gestureEnd = NO;
//    }
//}

//- (void)gestureStateEnd:(NSNotification *)not{
//    //    手势已经结束
//    BOOL isMore = _tableView.contentOffset.y > (_tableView.contentSize.height - _tableView.height);
//    if (isMore) {
//        //如果滑动的偏移量超出最大的内容范围
//        CGFloat between = _tableView.contentOffset.y - (_tableView.contentSize.height - _tableView.height);
//        if (between >= 70) {
//            _gestureEnd = YES;
//        }
//    }
//}

- (void)createView
{
    
    self.hoverTable = [[HJHoverTable alloc] init];
    self.hoverTable.hoverTableDelegate = self;
    self.hoverTable.tableDelegate = self;
    self.hoverTable.tableDataSource = self;
    [self.view addSubview:self.hoverTable];
    
    [self.hoverTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ORIGIN_TOP);
        make.left.bottom.right.mas_equalTo(0);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //延时进行页面刷新 等待父视图布局完成
        [self.hoverTable reloadData];
    });
    
//    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40,SCREEN_WIDTH, SCREEN_HEIGHT-40-DRTopHeight-40) style:UITableViewStylePlain];
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
//    self.tableView.scrollEnabled = NO;
//    self.tableView.backgroundColor = RGBHex(0xF4F4F4);
//    self.tableView.tableFooterView = [UIView new];
//    self.tableView.separatorColor = RGBHex(0XE2E2E2);
//    self.tableView.showsVerticalScrollIndicator = NO;
//    [self.view addSubview:self.tableView];
//
//    _loadView = [[UIActivityIndicatorView alloc]init];
//    [_loadView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
//    _noDateLab = [UITool createLabelWithTextColor:[UIColor lightGrayColor] textSize:12 alignment:NSTextAlignmentCenter];
//    _noDateLab.text = @"—  已经到底啦  —";
//
//    [self.tableView addSubview:_loadView];
//    [self.tableView addSubview:_noDateLab];
}
#pragma mark - HJHoverTableDelegate
- (UIView *)headerOfHoverTable
{
    //自定义header样式

    return self.evluateItemView;
}

- (CGFloat)headerHOfHoverTable
{
    return ORIGIN_TOP;
}

//自定义table样式
- (HJGestureTable *)gestureTable
{
    HJGestureTable *table = [[HJGestureTable alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    table.backgroundColor = [UIColor grayColor];
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    return table;
}

- (HJTopLimit)limitOfMarginTop
{
    return HJTopLimitMake(ORIGIN_TOP,0);
}
#pragma mark - FSBaseTableViewDataSource & FSBaseTableViewDelegate  委托方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EvaluateModel *model = _dataArray[indexPath.row];
    
    [model calculateReserveCellHeight];
    
    return model.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //评价
    static NSString *reuseID = @"evluateCell";
    ReserveEvluateCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = (ReserveEvluateCell *)[[ReserveEvluateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.cellType = 1;
        cell.delegate = self;
    }
    EvaluateModel *model = _dataArray[indexPath.row];
    [model calculateReserveCellHeight];
    cell.model = model;
    cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, model.cellHeight);
    return cell;
}


//tableview 加载完成可以调用的方法--因为tableview的cell高度不定，所以在加载完成以后重新计算高度
-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == ((NSIndexPath*)[[tableView indexPathsForVisibleRows]lastObject]).row){
        //end of loading
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_dataArray.count == _count && _count > 0) {
                _noDateLab.hidden = NO;
                _noDateLab.frame = CGRectMake( 0 , _hoverTable.contentSize.height , self.view.width, 50);
            }else{
                _noDateLab.hidden = YES;
            }
        });
    }
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//
//    if (_tableView != scrollView) {
//        return;
//    }
//
//    if (_gestureEnd) {
//        return;
//    }
//    BOOL isMore = _tableView.contentOffset.y > (_tableView.contentSize.height - _tableView.height);
//    if (isMore) {
//
//        if (_count == 0 ) {
//            [_loadView stopAnimating];
//            _noDateLab.hidden = YES;
//        }
//
//        if (_dataArray.count == _count && _count > 0) {
//            [_loadView stopAnimating];
//            _noDateLab.hidden = NO;
//
//        }
//
//        if (_dataArray.count < _count && _count > 0) {
//            _noDateLab.hidden = YES;
//            [_loadView startAnimating];
//            _loadView.frame = CGRectMake(self.tableView.center.x - 40, _tableView.contentSize.height , 80, 50);
//        }
//
//        //如果滑动的偏移量超出最大的内容范围
//        CGFloat between = _tableView.contentOffset.y - (_tableView.contentSize.height - _tableView.height);
//        if (between >= 100000) {
//            if (_isMoreThan) {
//                return;
//            }
//            _isMoreThan = YES;
//            //超出这个范围就开始做上拉加载动作。
//            if (!_isLoading) {
//                _isLoading = YES;
//                _currPage++;
//                if (_dataArray.count >= _count) {
//                    _currPage--;
//                    [_loadView stopAnimating];
//                    _isLoading = NO;
//                }else{
//                    [self requestGetNewShopCommList];
//                }
//            }
//        }else{
//            _isMoreThan = NO;
//        }
//    }
//}

#pragma mark - [获取服务店铺评论列表]
//获取服务店铺评论列表
- (void)requestGetNewShopCommList
{
    NSDictionary *dataDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pizza.json" ofType:nil]];
    [self analysisData:dataDict];
}

- (void)analysisData:(NSDictionary *)dic
{
    if (_currPage == 1) {
        [_dataArray removeAllObjects];
    }
    
    UIButton *button2 = (UIButton *)[_evluateItemView viewWithTag:10011];
    UIButton *button3 = (UIButton *)[_evluateItemView viewWithTag:10012];
    UIButton *button4 = (UIButton *)[_evluateItemView viewWithTag:10013];
    [button2 setTitle:[NSString stringWithFormat:@"推荐(%@)",dic[@"recommendedCount"]] forState:UIControlStateNormal] ;
    [button3 setTitle:[NSString stringWithFormat:@"一般(%@)",dic[@"normalCount"]] forState:UIControlStateNormal] ;
    [button4 setTitle:[NSString stringWithFormat:@"不满意(%@)",dic[@"unsatisfyCount"]] forState:UIControlStateNormal] ;
    NSArray *productCommentList = dic[@"productCommentList"];
    //列表
    if (productCommentList.count > 0) {
        
        NSArray *infoArray = [EvaluateModel arrayOfModelsFromDictionaries:productCommentList error:nil];
        
        [_dataArray addObjectsFromArray:infoArray];
    }
    _count = [dic[@"count"] integerValue];
    [_hoverTable reloadData];//刷新表
    
    _isLoading = NO;
    if (_dataArray.count == 0) {
        _noDateLab.hidden = YES;
    }
}

//#pragma mark -- ReserveEvluateCellDelegate 评价列表代理方法
//- (void)didSelectedPhotoView:(ReserveEvluateCell *)cell withImgIndex:(NSInteger)index
//{
//    NSIndexPath *indexPath = [_hoverTable indexPathForCell:cell];
//    _selectedIndex = indexPath.row;
//    UIImageView *imageView = (UIImageView *)[cell viewWithTag:index];
//    //展示图片浏览器 （Cell 模式）
//    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
//    EvaluateModel *model = _dataArray[_selectedIndex];
//    NSArray *picList = model.picList;
//    browser.sourceImagesContainerView = cell.photoView;
//    browser.imageCount = picList.count;
//    browser.currentImageIndex = index - 1;
//    browser.delegate = self;
//    [browser show];
//}

#pragma mark - SDPhotoBrowserDelegate 图片浏览器
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index { //图片的高清图片地址
    EvaluateModel *model = _dataArray[_selectedIndex];
    NSArray *picList = model.picList;
    
    NSURL *url = [NSURL URLWithString:picList[index][@"picUrl"]];
    return url;
}

//- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index { //返回占位图片
//    EvaluateModel *model = _dataArray[_selectedIndex];
//    NSArray *picList = model.picList;
//
////    [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:picList[index][@"picUrl"]
//    return [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:picList[index][@"picUrl"]];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
