//
//  PersonalCenterViewController.m
//  PersonalCenter
//
//  Created by Arch on 2017/6/16.
//  Copyright © 2017年 mint_bin. All rights reserved.
//

#import "DRShopHomeVC.h"
#import "SegmentView.h"
#import "DRCatoryShopVC.h"
#import "DRBurstShopVC.h"
#import "DRShopQuanVC.h"
#import "CenterTouchTableView.h"
#import "CRDetailModel.h"
#import "DRPinpaiVC.h"
#import "DRShopCatoryVC.h"
#import "CXSearchViewController.h"
@interface DRShopHomeVC () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate,UISearchBarDelegate>
@property (nonatomic, strong) CenterTouchTableView *mainTableView;
@property (nonatomic, strong) SegmentView *segmentView;
@property (nonatomic, strong) UIView *naviView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIView *headerContentView;
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UIButton *titleBtn;
@property (nonatomic, strong) UIButton *detailBtn;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UIButton *phoneBtn;
@property (nonatomic, strong) UIButton *collectBtn;
@property (nonatomic,retain)CRDetailModel *shopInfoModel;
@property (nonatomic,retain)NSString * favoriteIdStr;
/** mainTableView是否可以滚动 */
@property (nonatomic, assign) BOOL canScroll;
/** segmentHeaderView到达顶部, mainTableView不能移动 */
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabView;
/** segmentHeaderView离开顶部,childViewController的滚动视图不能移动 */
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabViewPre;
/** 是否正在pop */
@property (nonatomic, assign) BOOL isBacking;

@end

@implementation DRShopHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"个人中心";
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //如果使用自定义的按钮去替换系统默认返回按钮，会出现滑动返回手势失效的情况
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [self setupSubViews];
    //注册允许外层tableView滚动通知-解决和分页视图的上下滑动冲突问题
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"leaveTop" object:nil];
    //分页的scrollView左右滑动的时候禁止mainTableView滑动，停止滑动的时候允许mainTableView滑动
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:IsEnablePersonalCenterVCMainTableViewScroll object:nil];
   
}
- (void)refreshAction {
    [MBProgressHUD showMessage:@""];
    NSDictionary *dic =@{@"sellerId":self.sellerId?:@"",@"districtId":[DEFAULTS objectForKey:@"code"]?:@""};
    DRWeakSelf;
    [SNAPI getWithURL:@"seller/getSellerInfo" parameters:[dic mutableCopy] success:^(SNResult *result) {
      
       weakSelf.shopInfoModel=[CRDetailModel mj_objectWithKeyValues:result.data];
        [weakSelf.iconImg sd_setImageWithURL:[NSURL URLWithString:weakSelf.shopInfoModel.storeImg]];
        [weakSelf.titleBtn setTitle:weakSelf.shopInfoModel.sellerName forState:UIControlStateNormal];
        weakSelf.contentLab.text =[NSString stringWithFormat:@"开票方：%@",weakSelf.shopInfoModel.kpName];
        if (weakSelf.shopInfoModel.favoriteId.length==0) {
            weakSelf.collectBtn.selected =NO;
        }
        else
        {
            weakSelf.collectBtn.selected =YES;
            weakSelf.favoriteIdStr =weakSelf.shopInfoModel.favoriteId;
        }        
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.naviView.hidden = NO;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    [self ConfigBlackStatusColor];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self ConfigLightStatusColor];
    
//    self.isBacking = NO;
//    [[NSNotificationCenter defaultCenter] postNotificationName:PersonalCenterVCBackingStatus object:nil userInfo:@{@"isBacking" : @(self.isBacking)}];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self ConfigBlackStatusColor];
     [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.isBacking = YES;
//    [[NSNotificationCenter defaultCenter] postNotificationName:PersonalCenterVCBackingStatus object:nil userInfo:@{@"isBacking" : @(self.isBacking)}];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.naviView.hidden = YES;
}

//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

//#pragma mark - Private Methods
- (void)setupSubViews {
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.naviView];
    [self.headerImageView addSubview:self.headerContentView];
    [self.headerContentView addSubview:self.iconImg];
    [self.headerContentView addSubview:self.titleBtn];
    [self.headerContentView addSubview:self.contentLab];
    [self.headerContentView addSubview:self.phoneBtn];
    [self.headerContentView addSubview:self.collectBtn];
    [self.mainTableView addSubview:self.headerImageView];
    
    [self.headerContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.left.mas_equalTo(self.headerImageView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(DRTopHeight+WScale(65));
    }];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headerContentView).offset(WScale(10));
        make.size.mas_equalTo(CGSizeMake(WScale(42), WScale(42)));
        make.bottom.mas_equalTo(self.headerContentView).offset(-WScale(11.5));
    }];
    
    [self.titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImg.mas_right).offset(WScale(10));
        make.top.mas_equalTo(self.iconImg);
        make.height.mas_equalTo(WScale(20));
    }];
    [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleBtn.mas_right).offset(WScale(5));
        make.centerY.mas_equalTo(self.titleBtn);
    }];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(self.iconImg.mas_right).offset(WScale(10));
         make.bottom.mas_equalTo(self.iconImg);
         make.height.mas_equalTo(WScale(12));
    }];
    
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.headerContentView).offset(-WScale(45));
        make.bottom.mas_equalTo(self.headerContentView).offset(-WScale(20));
        make.width.height.mas_equalTo(WScale(25));
    }];
    
   [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.headerContentView.mas_right).offset(-WScale(10));
        make.bottom.mas_equalTo(self.headerContentView).offset(-WScale(20));
        make.width.height.mas_equalTo(WScale(25));
    }];
     [self refreshAction];
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)gotoMessagePage {
   CXSearchViewController *searchViewController = [[CXSearchViewController alloc] init];
    searchViewController.SearTextBlock = ^(NSString * _Nonnull textBlock) {
        DRShopCatoryVC *goodSetVc =[[DRShopCatoryVC alloc] init];
        goodSetVc.sellidStr =self.sellerId;
        goodSetVc.isAirCloudYes =self.isAirCloud;
        goodSetVc.keyWordStr =textBlock;
        NSLog(@"zyStoreId=%@",[DRUserInfoModel sharedManager].zyStoreId);
        goodSetVc.searchTypeStr =@"search";
        [self.navigationController pushViewController:goodSetVc animated:YES];
    };
    [self.navigationController pushViewController:searchViewController animated:YES];
}

#pragma mark -  Notification
- (void)acceptMsg:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    
    if ([notification.name isEqualToString:@"leaveTop"]) {
        NSString *canScroll = userInfo[@"canScroll"];
        if ([canScroll isEqualToString:@"1"]) {
            self.canScroll = YES;
        }
    } else if ([notification.name isEqualToString:IsEnablePersonalCenterVCMainTableViewScroll]) {
        NSString *canScroll = userInfo[@"canScroll"];
        if ([canScroll isEqualToString:@"1"]) {
            self.mainTableView.scrollEnabled = YES;
        }else if([canScroll isEqualToString:@"0"]) {
            self.mainTableView.scrollEnabled = NO;
        }
    }
}

#pragma mark - UiScrollViewDelegate
/**
 * 处理联动
 * 因为要实现下拉头部放大的问题，tableView设置了contentInset，所以试图刚加载的时候会调用一遍这个方法，所以要做一些特殊处理，
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.mainTableView) {
        //当前y轴偏移量
        CGFloat yOffset  = scrollView.contentOffset.y;
        //临界点偏移量(吸顶临界点)
        CGFloat tabyOffset = [self.mainTableView rectForSection:0].origin.y - DRTopHeight;
        
        //第一部分: 更改导航栏的背景图的透明度
        CGFloat alpha = 0;
        if (-yOffset <= DRTopHeight) {
            alpha = 1;
        } else if ((-yOffset > DRTopHeight) && -yOffset < DRTopHeight+65) {
            alpha = (DRTopHeight+65 + yOffset) / (65);
        }else {
            alpha = 0;
        }
        self.naviView.backgroundColor = REDCOLOR;
        
        //第二部分：
        //利用contentOffset处理内外层scrollView的滑动冲突问题
        if (yOffset >= tabyOffset) {
            scrollView.contentOffset = CGPointMake(0, tabyOffset);
            _isTopIsCanNotMoveTabView = YES;
        }else{
            _isTopIsCanNotMoveTabView = NO;
        }
        
        _isTopIsCanNotMoveTabViewPre = !_isTopIsCanNotMoveTabView;
        
        if (!_isTopIsCanNotMoveTabViewPre) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"goTop" object:nil userInfo:@{@"canScroll":@"1"}];
            _canScroll = NO;
        } else{
            if (!_canScroll) {
                _mainTableView.contentOffset = CGPointMake(0, tabyOffset);
            }
        }
        
        //第三部分：
        /**
         * 处理头部自定义背景视图 (如: 下拉放大)
         * 图片会被拉伸多出状态栏的高度
         */
        if(yOffset <= -DRTopHeight+65) {
            if (_isEnlarge) {
                CGRect f = self.headerImageView.frame;
                //改变HeadImageView的frame
                //上下放大
                f.origin.y = yOffset;
                f.size.height = -yOffset;
                //左右放大
                f.origin.x = (yOffset * SCREEN_WIDTH / DRTopHeight+65 + SCREEN_WIDTH) / 2;
                f.size.width = -yOffset * SCREEN_WIDTH / DRTopHeight+65;
                //改变头部视图的frame
                self.headerImageView.frame = f;
            }else{
                scrollView.bounces = NO;
            }
        }else {
            scrollView.bounces = YES;
        }
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREEN_HEIGHT - DRTopHeight;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.contentView addSubview:self.setPageViewControllers];
    return cell;
}
#pragma mark - Lazy
- (UIView *)naviView {
    if (!_naviView) {
        _naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, DRTopHeight)];
        _naviView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        //添加返回按钮
        UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backButton setImage:[UIImage imageNamed:@"santie_ico_back"] forState:(UIControlStateNormal)];
        backButton.frame = CGRectMake(5, 8 + DRStatusBarHeight, 28, 25);
        backButton.adjustsImageWhenHighlighted = YES;
        [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_naviView addSubview:backButton];
        
        // 创建搜索框
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(WScale(35),DRStatusBarHeight+WScale(5), WScale(280), WScale(30))];
        titleView.backgroundColor =WHITECOLOR;
        titleView.layer.cornerRadius =4;
        titleView.layer.masksToBounds =4;
        
        UIButton *searchBtn =[UIButton buttonWithLeftImage:@"search_ico_search" title:@"搜索店铺商品" font:DR_FONT(14) titleColor:RGBHex(0XC0C0C0) backGroundColor:CLEARCOLOR target:self action:@selector(searchBtnClick) showView:titleView];
        searchBtn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
        searchBtn.frame =CGRectMake(WScale(10), WScale(0), titleView.dc_width-WScale(20), WScale(30));
        
        [_naviView addSubview:titleView];
        //添加消息按钮
        UIButton *messageButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        [messageButton setImage:[UIImage imageNamed:@"message"] forState:(UIControlStateNormal)];
        [messageButton setTitle:@"搜索" forState:UIControlStateNormal];
        messageButton.titleLabel.font =DR_FONT(14);
        [messageButton setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        messageButton.frame = CGRectMake(SCREEN_WIDTH - WScale(60), 8 + DRStatusBarHeight, WScale(60), 25);
        messageButton.adjustsImageWhenHighlighted = YES;
        [messageButton addTarget:self action:@selector(gotoMessagePage) forControlEvents:(UIControlEventTouchUpInside)];
        [_naviView addSubview:messageButton];
    }
    return _naviView;
}
-(void)searchBtnClick
{
    CXSearchViewController *searchViewController = [[CXSearchViewController alloc] init];
    searchViewController.SearTextBlock = ^(NSString * _Nonnull textBlock) {
        DRShopCatoryVC *goodSetVc =[[DRShopCatoryVC alloc] init];
        goodSetVc.sellidStr =self.sellerId;
        goodSetVc.isAirCloudYes =self.isAirCloud;
        goodSetVc.keyWordStr =textBlock;
        NSLog(@"zyStoreId=%@",[DRUserInfoModel sharedManager].zyStoreId);
        goodSetVc.searchTypeStr =@"search";
        [self.navigationController pushViewController:goodSetVc animated:YES];
    };
    [self.navigationController pushViewController:searchViewController animated:YES];
}
- (UITableView *)mainTableView {
    if (!_mainTableView) {
        //⚠️这里的属性初始化一定要放在mainTableView.contentInset的设置滚动之前, 不然首次进来视图就会偏移到临界位置，contentInset会调用scrollViewDidScroll这个方法。
        //初始化变量
        self.canScroll = YES;
        self.isTopIsCanNotMoveTabView = NO;
        
        self.mainTableView = [[CenterTouchTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
//        _mainTableView.showsVerticalScrollIndicator = NO;
        //注意：这里不能使用动态高度_headimageHeight, 不然tableView会往下移，在iphone X下，头部不放大的时候，上方依然会有白色空白
        _mainTableView.contentInset = UIEdgeInsetsMake(DRTopHeight+65, 0, 0, 0);//内容视图开始正常显示的坐标为(0, DRTopHeight+65)
    }
    return _mainTableView;
}

- (UIView *)headerContentView {
    if (!_headerContentView) {
        _headerContentView = [[UIView alloc]init];
        _headerContentView.backgroundColor = REDCOLOR;
    }
    return _headerContentView;
}

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] init];
        _iconImg.image = [UIImage imageNamed:@"center_avatar.jpeg"];
        _iconImg.userInteractionEnabled = YES;
        _iconImg.layer.cornerRadius =2;
        _iconImg.layer.masksToBounds =2;

    }
    return _iconImg;
}
-(UIButton *)titleBtn
{
    if (!_titleBtn) {
        _titleBtn =[UIButton buttonWithLeftImage:@"" title:@"三铁云仓" font:DR_FONT(20) titleColor:WHITECOLOR backGroundColor:CLEARCOLOR target:self action:@selector(titleBtnClick) showView:_headerContentView];
        [_titleBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
    }
    return _titleBtn;
}
-(UIButton *)detailBtn
{
    if (!_detailBtn) {
        _detailBtn =[UIButton buttonWithLeftImage:@"店铺-查看店铺详情" title:nil font:DR_FONT(20) titleColor:WHITECOLOR backGroundColor:CLEARCOLOR target:self action:@selector(titleBtnClick) showView:_headerContentView];
      
    }
    return _detailBtn;
}
- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab =[UILabel labelWithText:@"开票方：------" font:DR_FONT(12)
        textColor:WHITECOLOR backGroundColor:CLEARCOLOR textAlignment:0 superView:_headerContentView];
    }
    return _contentLab;
}

-(UIButton *)phoneBtn
{
    if (!_phoneBtn) {
        _phoneBtn =[UIButton buttonWithImage:@"店铺-客服" target:self action:@selector(phoneBtnClick:) showView:_headerContentView];
    }
    return _phoneBtn;
}
-(UIButton *)collectBtn
{
    if (!_collectBtn) {
        _collectBtn =[UIButton buttonWithImage:@"店铺-已收藏" target:self action:@selector(collectBtnClick:) showView:_headerContentView];
        [_collectBtn setImage:[UIImage imageNamed:@"santie_ico_collect"] forState:UIControlStateSelected];
    }
    return _collectBtn;
}
- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"center_bg.jpg"]];
        _headerImageView.backgroundColor = [UIColor greenColor];
        _headerImageView.userInteractionEnabled = YES;
        _headerImageView.frame = CGRectMake(0, -(DRTopHeight+65), SCREEN_WIDTH, DRTopHeight+65);
    }
    return _headerImageView;
}

/*
 * 这里可以设置替换你喜欢的segmentView
 */
- (UIView *)setPageViewControllers {
    if (!_segmentView) {
        //设置子控制器
        DRCatoryShopVC *firstVC  = [[DRCatoryShopVC alloc] init];
        firstVC.sellerId =self.sellerId;
        firstVC.isAirCloudYes =self.isAirCloud;
        DRBurstShopVC *secondVC = [[DRBurstShopVC alloc] init];
        secondVC.sellerId =self.sellerId;
        secondVC.ycStr =self.ycStr;
        DRShopQuanVC *thirdVC  = [[DRShopQuanVC alloc] init];
        thirdVC.sellerId =self.sellerId;
        NSArray *controllers = @[firstVC, secondVC, thirdVC];
        NSArray *titleArray = @[@"商品分类", @"云仓爆品", @"领券中心"];
        SegmentView *segmentView = [[SegmentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - DRTopHeight) controllers:controllers titleArray:(NSArray *)titleArray parentController:self];
        //注意：不能通过初始化方法传递selectedIndex的初始值，因为内部使用的是Masonry布局的方式, 否则设置selectedIndex不起作用
        segmentView.selectedIndex = self.selectedIndex;
        _segmentView = segmentView;
    }
    return _segmentView;
}
-(void)titleBtnClick
{
    DRPinpaiVC *pinpaiVC =[[DRPinpaiVC alloc]init];
    pinpaiVC.detailModel=self.shopInfoModel;
    [self.navigationController pushViewController:pinpaiVC animated:YES];
}
-(void)phoneBtnClick:(UIButton *)sender
{
    
}
-(void)collectBtnClick:(UIButton *)sender
{
    DRWeakSelf;
    NSMutableDictionary *mudic =[NSMutableDictionary dictionary];
    NSString *urlStr;
    if (sender.selected) {
        urlStr =@"buyer/cancelSellerFavorite";
        mudic =[NSMutableDictionary dictionaryWithObject:weakSelf.favoriteIdStr forKey:@"id"];
        [SNIOTTool deleteWithURL:urlStr parameters:mudic success:^(SNResult *result) {
            NSLog(@"result=%@",result.data);
            weakSelf.favoriteIdStr =@"";
            sender.selected =NO;
            [MBProgressHUD showSuccess:@"取消成功"];
        } failure:^(NSError *error) {
            [MBProgressHUD showError:error.description];
        }];
    }
    else
    {
        urlStr =@"buyer/favoriteSeller";
        NSDictionary *dic =@{@"id":self.sellerId};
        [SNAPI postWithURL:urlStr parameters:dic.mutableCopy success:^(SNResult *result) {
            NSLog(@"result=%@",result.data);
            weakSelf.favoriteIdStr=result.data[@"favoriteId"];
            sender.selected =YES;
            [MBProgressHUD showSuccess:@"收藏成功"];
            //
        } failure:^(NSError *error) {
            
        }];
    }
}
@end
