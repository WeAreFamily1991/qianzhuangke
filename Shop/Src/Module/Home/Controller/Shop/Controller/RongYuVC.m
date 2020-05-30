//
//  RongYuVC.m
//  Shop
//
//  Created by BWJ on 2019/4/26.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "RongYuVC.h"
#import "RongyuLayOut.h"
#import "CollectionViewCell.h"
#import "CRDetailModel.h"
@interface RongYuVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation RongYuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                         collectionViewLayout:[RongyuLayOut new]];
    _collectionView.backgroundColor = BACKGROUNDCOLOR;
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [self.view addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
        
    }];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.detailModel.honorImgs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    HonorImgs *imgModel =[HonorImgs mj_objectWithKeyValues:self.detailModel.honorImgs[indexPath.row]];
    [cell.backImage sd_setImageWithURL:[NSURL URLWithString:imgModel.imgUrl]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    CRProductModel *model = _dataSource[indexPath.item];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
