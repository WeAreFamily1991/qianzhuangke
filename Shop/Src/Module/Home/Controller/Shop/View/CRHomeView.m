//
//  CRHomeView.m
//  CRShopDetailDemo
//
//  Created by roger wu on 19/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CRHomeView.h"
#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>
#import "NewsModel.h"
#import "DCRecommendItem.h"
#import "DRFooterModel.h"
#import "DRShopListVC.h"
/* cell */
#import "DCGoodsCountDownCell.h" //倒计时商品
#import "DCNewWelfareCell.h"     //新人福利
#import "DCGoodsHandheldCell.h"  //掌上专享
#import "DCExceedApplianceCell.h"//不止
#import "DRShopGoodCell.h"   //猜你喜欢商品
#import "DCGoodsGridCell.h"      //10个选项
#import "DRNullGoodLikesCell.h"  //爆品牛商cell
/* head */
#import "DCSlideshowHeadView.h"  //轮播图
#import "DRShopHeadView.h"  //倒计时标语
#import "DCYouLikeHeadView.h"    //猜你喜欢等头部标语
/* foot */
#import "DRFooterView.h"
#import "DCTopLineFootView.h"    //热点
#import "DCOverFootView.h"       //结束
#import "DCScrollAdFootView.h"   //底滚动广告
#import "DRShopBannerFootView.h"
#import "HQCollectionViewFlowLayout.h"
@interface CRHomeView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 头部ImageView */
@property (strong , nonatomic)UIImageView *headImageView;
/* 图片数组 */
@property (copy , nonatomic)NSArray *imagesArray;

@property (nonatomic,strong)NewsModel *newmodel;
@property (nonatomic,strong)DRFooterModel *footerModel;
@property (nonatomic,retain)DRNullShopModel *nullShopModel;
@property (nonatomic,strong)NSMutableArray *bannerArr,*newsArr,*footerArr,*nullArr;

@end
/* cell */

static NSString *const DCGoodsHandheldCellID = @"DCGoodsHandheldCell";
static NSString *const DRShopGoodCellID = @"DRShopGoodCell";
static NSString *const DRNullGoodLikesCellCellID = @"DRNullGoodLikesCell";
/* head */
static NSString *const DCSlideshowHeadViewID = @"DCSlideshowHeadView";
static NSString *const DRShopHeadViewID = @"DRShopHeadView";
static NSString *const DCYouLikeHeadViewID = @"DCYouLikeHeadView";
/* foot */
static NSString *const DRFooterViewID = @"DRFooterView";
static NSString *const DCTopLineFootViewID = @"DCTopLineFootView";
static NSString *const DCOverFootViewID = @"DCOverFootView";
static NSString *const DCScrollAdFootViewID = @"DCScrollAdFootView";
static NSString *const DRShopBannerFootViewID = @"DRShopBannerFootView";

static NSString *const DRTopViewID = @"HQTopStopView";
@implementation CRHomeView {
    WKWebView *_webView;
}
#pragma mark - lazyload
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        //左右间距
//        layout.minimumInteritemSpacing = 2;
//        //上下间距
//        layout.minimumLineSpacing = 2;
//        layout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 2);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor =BACKGROUNDCOLOR;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = self.bounds;
        _collectionView.showsVerticalScrollIndicator = NO;        //注册
       
        [_collectionView registerClass:[DCGoodsHandheldCell class] forCellWithReuseIdentifier:DCGoodsHandheldCellID];
        [_collectionView registerClass:[DRShopGoodCell class] forCellWithReuseIdentifier:DRShopGoodCellID];
        
        [_collectionView registerClass:[DRNullGoodLikesCell class] forCellWithReuseIdentifier:DRNullGoodLikesCellCellID];
        
        [_collectionView registerClass:[DRFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DRFooterViewID];
        [_collectionView registerClass:[DCTopLineFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCTopLineFootViewID];
        [_collectionView registerClass:[DCOverFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCOverFootViewID];
        [_collectionView registerClass:[DCScrollAdFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCScrollAdFootViewID];
        [_collectionView registerClass:[DCYouLikeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCYouLikeHeadViewID];
        [_collectionView registerClass:[DCSlideshowHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCSlideshowHeadViewID];
        [_collectionView registerClass:[DRShopHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DRShopHeadViewID];
        [_collectionView registerClass:[DRShopBannerFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DRShopBannerFootViewID];
        [self addSubview:_collectionView];
        [self setupWithScrollView:_collectionView];
    }
    return _collectionView;
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
    [self getSellerBanners];
    [self sellertop2saleItem];
    [self sellerInfoList];
    [self newRecommend];
}
-(void)getSellerBanners
{
    NSDictionary *dic =@{@"sellerId":self.sellerId};
    [SNAPI getWithURL:@"/mainPage/getSellerBanners" parameters:[dic mutableCopy] success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            
            self.bannerArr =[NSMutableArray array];
            NSArray *sourceArr =[NewsModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
            for (NewsModel *model in sourceArr) {
                [self.bannerArr addObject:model.img];
            }
        }
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(void)sellerInfoList
{
    NSDictionary *dic =@{@"districtId":[DEFAULTS objectForKey:@"code"]?:@"",@"sellerId":self.sellerId?:@""};
    [SNAPI getWithURL:@"burst/sellerInfoList" parameters:[dic mutableCopy] success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            
            self.nullArr =[NSMutableArray array];
           self.nullArr =[DRNullShopModel mj_objectArrayWithKeyValuesArray:result.data];
            
            [self.collectionView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)newRecommend
{
    NSDictionary *dic =@{@"type":@"1",@"sellerId":self.sellerId,@"pageNum":@"1",@"pageSize":@"10000"};
    [SNAPI getWithURL:@"seller/newRecommend" parameters:[dic mutableCopy] success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
           
            _youLikeItem =[DCRecommendItem mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
            [self.collectionView reloadData];
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

- (void)setup {
//    [self setUpGoodsData];
   
    self.backgroundColor =BACKGROUNDCOLOR;
//    _webView = [WKWebView new];
//    [self addSubview:_webView];
//    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
//    [self setupWithScrollView:_webView.scrollView];
    
}
-(void)sellertop2saleItem
{
    NSDictionary *dic =@{@"district":[DEFAULTS objectForKey:@"code"]?:@"",@"sellerId":self.sellerId?:@""};
    [SNAPI getWithURL:@"seller/top2saleItem" parameters:[dic mutableCopy] success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            
            self.footerArr =[NSMutableArray array];
            self.footerArr =[DRFooterModel mj_objectArrayWithKeyValuesArray:result.data];
           
            [self.collectionView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)setHomeURL:(NSString *)homeURL {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:homeURL]];
    [_webView loadRequest:request];
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 6;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ( section==4) { //广告福利  倒计时  掌上专享
//        if (self.nullArr.count>4) {
//            return [self.nullArr subarrayWithRange:NSMakeRange(0, 4)].count;
//        }
        return self.nullArr.count;
    }
    if (section==5) {
//        if (self.youLikeItem.count>4) {
//            return [self.youLikeItem subarrayWithRange:NSMakeRange(0, 4)].count;
//        }
        return self.youLikeItem.count;
    }
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;

     if (indexPath.section == 4) {//倒计时
        DRNullGoodLikesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DRNullGoodLikesCellCellID forIndexPath:indexPath];
         cell.nullShopModel =self.nullArr[indexPath.row];
        cell.lookSameBlock = ^{
            NSLog(@"点击了第%zd商品的比价格",indexPath.row);
        };
        gridcell = cell;

    }
    
    else if (indexPath.section ==5) {//推荐
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
        
        gridcell = cell;
        
    }
    else {//猜你喜欢
        DCGoodsHandheldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsHandheldCellID forIndexPath:indexPath];
        NSArray *images = GoodsHandheldImagesArray;
        cell.handheldImage = images[indexPath.row];
        gridcell = cell;
    }
    return gridcell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
//    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionFooter)
    {
        if (indexPath.section == 0) {
            if (self.bannerArr.count!=0) {                
                DCSlideshowHeadView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCSlideshowHeadViewID forIndexPath:indexPath];
                footerView.imageGroupArray = self.bannerArr.copy;
                footerView.ManageIndexBlock = ^(NSInteger ManageIndexBlock) {
                };
                return  footerView ;
            }
        }
        else if (indexPath.section == 1){
            DRShopHeadView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DRShopHeadViewID forIndexPath:indexPath];
            footerView.backgroundColor = BACKGROUNDCOLOR;
            footerView.titleLab.text =@"大家都在买";
            footerView.titleLab.hidden =YES;

            footerView.moreBtn.hidden =YES;
            return footerView;
            
        }
        else if (indexPath.section == 2) {
            if (self.footerArr.count!=0) {
                
                DRShopBannerFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DRShopBannerFootViewID forIndexPath:indexPath];
                footerView.dataArr =self.footerArr;
                footerView.ManageIndexBlock = ^(NSInteger ManageIndexBlock) {
                };
                return  footerView ;
            }
        }
          else if (indexPath.section==3)
        {
            DRShopHeadView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DRShopHeadViewID forIndexPath:indexPath];
            footerView.backgroundColor = BACKGROUNDCOLOR;
            footerView.titleLab.text =@"爆品专区";
             footerView.moreBtn.hidden =NO;
            footerView.moreBtnBlock = ^{
                if (_selectedBlock) {
                    _selectedBlock(indexPath.section);
                }
            };
            return footerView;
        }
        else if (indexPath.section == 4) {
            if (self.youLikeItem.count!=0) {
                DRShopHeadView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DRShopHeadViewID forIndexPath:indexPath];
                footerView.backgroundColor = BACKGROUNDCOLOR;
                footerView.titleLab.text =@"新品推荐";
                footerView.moreBtn.hidden =NO;
                footerView.moreBtnBlock = ^{
                     _selectedBlock(indexPath.section);
                };
                return footerView;
            }
        }
    }
    return nil;
}
//这里我为了直观的看出每组的CGSize设置用if 后续我会用简洁的三元表示
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 4) {//爆品
          
        return CGSizeMake((ScreenW - 2)/2,(ScreenW - 2)/2 + HScale(80)+HScale(20));
    }
    if (indexPath.section == 5) {//新品
      
        return CGSizeMake((ScreenW - 2)/2, (ScreenW - 2)/2 +ScreenW*0.1);
    }
    return CGSizeZero;
}
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    if (indexPath.section == 5) {
//        if (indexPath.row == 0) {
//            layoutAttributes.size = CGSizeMake(ScreenW, ScreenW * 0.38);
//        }else if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
//            layoutAttributes.size = CGSizeMake(ScreenW * 0.5, ScreenW * 0.24);
//        }else{
//            layoutAttributes.size = CGSizeMake(ScreenW * 0.25, ScreenW * 0.35);
//        }
//    }
//    return layoutAttributes;
//}
#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
//    if (section==2) {
//        return CGSizeZero;
//    }
//    if (section==8) {
////        if (self.bigCartporyArr.count%4==0) {
////            return CGSizeMake(ScreenW,((ScreenW-25)/8.4+10)*round(self.bigCartporyArr.count/4));
////        }
////        NSLog(@"====%f===%f",round(self.bigCartporyArr.count/4),ceil(self.bigCartporyArr.count/4));
////        return CGSizeMake(ScreenW,((ScreenW-25)/8.4+10)*(round(self.bigCartporyArr.count/4)+1));
//    }
    return CGSizeZero;
}
#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        if (self.bannerArr.count!=0) {
            
            return CGSizeMake(ScreenW, HScale(120)); //图片滚动的宽高
        }
        return CGSizeMake(0, 0); //图片滚动的宽高
    }
    if (section==2) {
        if (self.footerArr.count!=0) {
            
            return CGSizeMake(ScreenW, HScale(80));
        }
    }
    if (section == 3||section==4) {
        if (section==3) {
            if (self.nullArr.count==0) {
                return CGSizeMake(0, 0);
            }
        }
        if (section==4) {
            if (self.youLikeItem.count==0) {
                return CGSizeMake(0, 0);
            }
        }
        return CGSizeMake(ScreenW, HScale(40));  //Top头条的宽高
    }
   
    return CGSizeZero;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//10
        
        //        DCGoodsSetViewController *goodSetVc = [[DCGoodsSetViewController alloc] init];
        //        goodSetVc.goodPlisName = @"ClasiftyGoods.plist";
        //        [self.navigationController pushViewController:goodSetVc animated:YES];
        //        NSLog(@"点击了10个属性第%zd",indexPath.row);
    }
     else if (indexPath.section == 4){
         
//         [[NSNotificationCenter defaultCenter] postNotificationName:@"CRHomeView" object:self.nullArr[indexPath.row] userInfo:nil];
//         if (self.delegate) {
//             [self.delegate nullShopModelClickedHome:self.nullArr[indexPath.row]];
//         }
         DRShopListVC *goodSetVc =[[DRShopListVC alloc] init];
         goodSetVc.nullGoodModel =(DRNullGoodModel*)self.nullArr[indexPath.row];
         [[self viewController].navigationController pushViewController:goodSetVc animated:YES];
     }
    else if (indexPath.section == 5){
        if (self.delegate) {
            [self.delegate youLikeModelClickedCGood:_youLikeItem[indexPath.row]];
        }
    }
}


@end
