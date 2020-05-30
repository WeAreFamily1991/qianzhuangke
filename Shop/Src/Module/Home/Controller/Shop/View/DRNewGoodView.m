//
//  CRAllProductView.m
//  CRShopDetailDemo
//
//  Created by roger wu on 19/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "DRNewGoodView.h"
#import "CRSortBar.h"
#import "DRNewShopLayout.h"
#import "DRShopGoodCell.h"
#import "CRConst.h"
#import "CRDetailModel.h"
#import "CRProductModel.h"
#import "DRNullGoodModel.h"
#import "CRRefreshFooter.h"

#import "DCRecommendItem.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <Masonry/Masonry.h>
//#import <YYCategories/YYCategories.h>
#import <YYModel/YYModel.h>

static NSString *const DRShopGoodCellID = @"DRShopGoodCell";
@interface DRNewGoodView()<
UICollectionViewDataSource,
UICollectionViewDelegate,
CRSortBarDelegate>
/* 推荐商品属性 */
@property (strong , nonatomic)NSArray<DCRecommendItem *> *youLikeItem;
@end

@implementation DRNewGoodView {
    CRSortBar *_sortBar;
    UICollectionView *_collectionView;
    NSMutableArray<CRProductModel *> *_dataSource;
    NSURLSessionTask *_headerTask;
    NSURLSessionTask *_footerTask;
    NSInteger _currentPage;
    CRSortType _sortType;
    MBProgressHUD *_hud;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
#pragma mark - 加载数据
- (void)setNullGoodModel:(DRNullGoodModel *)nullGoodModel
{
    _nullGoodModel =nullGoodModel;
    //    _youLikeItem = [DCRecommendItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
    
    [self newRecommend];
    
}
-(void)newRecommend
{
    NSDictionary *dic =@{@"type":@"1",@"sellerId":self.sellerId,@"pageNum":@"1",@"pageSize":@"10000"};
    [SNAPI getWithURL:@"seller/newRecommend" parameters:[dic mutableCopy] success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            
            _youLikeItem =[DCRecommendItem mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
            [_collectionView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)dealloc {
    [_headerTask cancel];
    [_footerTask cancel];
}

- (void)setup {
//     _youLikeItem = [DCRecommendItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
    _dataSource = [NSMutableArray array];
    _sortType = CRSortTypeComposite;
    
    //    _sortBar = [CRSortBar new];
    //    _sortBar.delegate = self;
    //    [self addSubview:_sortBar];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                         collectionViewLayout:[DRNewShopLayout new]];
    _collectionView.backgroundColor = kBackgroundColor;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[DRShopGoodCell class] forCellWithReuseIdentifier:DRShopGoodCellID];
    [self addSubview:_collectionView];
    [self setupWithScrollView:_collectionView];
    
    //    [_sortBar mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.left.right.equalTo(self);
    //        make.height.mas_equalTo(kSortBarHeight);
    //    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
        
    }];
    
    @weakify(self);
    _collectionView.mj_footer = [CRRefreshFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self footerRefresh];
    }];
}

- (void)setModel:(CRDetailModel *)model {
    _model = model;
    [self headerRefresh];
}

- (NSMutableArray<CRProductModel *> *)getData {
    NSMutableArray<CRProductModel *> *temp = [NSMutableArray array];
    NSData *data = [NSData dataNamed:@"product_list"];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data
                                                     options:kNilOptions
                                                       error:NULL];
    for (NSDictionary *json in array) {
        CRProductModel *model = [CRProductModel yy_modelWithJSON:json];
        [temp addObject:model];
    }
    return [temp mutableCopy];
}

- (void)headerRefresh {
    _dataSource = [self getData];
    [_collectionView reloadData];
}

- (void)footerRefresh {
    [_dataSource addObjectsFromArray:[self getData]];
    [_collectionView.mj_footer endRefreshingWithNoMoreData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _youLikeItem.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DRShopGoodCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DRShopGoodCellID forIndexPath:indexPath];
    cell.youLikeItem = _youLikeItem[indexPath.row];
    //        cell.centerShopBtnBlock  = ^{
    //            NSLog(@"点击了第%zd商品的找进入店铺",indexPath.row);
    //        };
    //        cell.sureBuyBtnBlock  = ^{
    //            NSLog(@"立即购买=%zd",indexPath.row);
    //        };
    //        cell.lookSameBlock = ^{
    //            NSLog(@"点击了第%zd商品的比价格",indexPath.row);
    //        };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //    CRProductModel *model = _dataSource[indexPath.item];
}

#pragma mark - ShopDetailSortBarViewDelegate
- (void)sortBar:(CRSortBar *)sortBar sortType:(CRSortType)sortType {
    _sortType = sortType;
    [_collectionView scrollToTopAnimated:NO];
    [self headerRefresh];
}

@end
