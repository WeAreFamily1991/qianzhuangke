//
//  DRBurstShopVC.m
//  Shop
//
//  Created by BWJ on 2019/4/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRBurstShopVC.h"
#import "DRNullShopModel.h"
#import "DRNullGoodLikesCell.h"
#import "DRShopListVC.h"
#import "DRNullGoodModel.h"
#import "CRProductLayout.h"
static NSString *const DRNullGoodLikesCellCellID = @"DRNullGoodLikesCell";
@interface DRBurstShopVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
@property (strong , nonatomic)NSArray<DRNullShopModel *> *nullShopArr;
@end

@implementation DRBurstShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                         collectionViewLayout:[CRProductLayout new]];
    _collectionView.backgroundColor = BACKGROUNDCOLOR;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[DRNullGoodLikesCell class] forCellWithReuseIdentifier:DRNullGoodLikesCellCellID];
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.top.right.bottom.equalTo(self.view);
      }];
    [self sellerInfoList];
    // Do any additional setup after loading the view from its nib.
}
-(void)sellerInfoList
{
    NSDictionary *dic =@{@"districtId":[DEFAULTS objectForKey:@"code"]?:@"",@"sellerId":self.sellerId?:@"",@"yc":self.ycStr?:@"",@"czId":@"",@"categoryId":@"",@"pageNum":@"1",@"pageSize":@"1000"};
    DRWeakSelf;
    [SNAPI getWithURL:@"burst/sellerInfoList" parameters:[dic mutableCopy] success:^(SNResult *result) {
        self.nullShopArr =[DRNullShopModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
        [weakSelf.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.nullShopArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DRNullGoodLikesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DRNullGoodLikesCellCellID forIndexPath:indexPath];
    cell.nullShopModel =self.nullShopArr[indexPath.row];
    cell.lookSameBlock = ^{
        NSLog(@"点击了第%zd商品的比价格",indexPath.row);
//        self.itemModel =[ItemList mj_objectWithKeyValues:self.listMOdel.itemList[indexPath.row]];
//        DRShopListVC * shopListVC =[[DRShopListVC alloc]init];
//        shopListVC.nullGoodModel =(DRNullGoodModel*)self.itemModel;
//        [GoodsShareModel sharedManager].queryType =@"nowBuy";
//        shopListVC.queryTypeStr =@"nowBuy";
//        [self.navigationController pushViewController:shopListVC animated:YES];
    };
    cell.sureBuyBtnBlock = ^{
        
        DRShopListVC * shopListVC =[[DRShopListVC alloc]init];
        shopListVC.nullGoodModel =(DRNullGoodModel*)self.nullShopArr[indexPath.row];;
        [GoodsShareModel sharedManager].queryType =@"nowBuy";
        shopListVC.queryTypeStr =@"nowBuy";
        [self.navigationController pushViewController:shopListVC animated:YES];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    if (self.delegate) {
    //        [self.delegate nullShopModelClickedHome:self.nullShopArr[indexPath.row]];
    //    }
    //
    //    CRProductModel *model = _dataSource[indexPath.item];
    DRShopListVC *goodSetVc =[[DRShopListVC alloc] init];
    goodSetVc.nullGoodModel =(DRNullGoodModel*)self.nullShopArr[indexPath.row];
    [self.navigationController pushViewController:goodSetVc animated:YES];
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return CGSizeMake((ScreenW -30)/2, WScale(300));
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
