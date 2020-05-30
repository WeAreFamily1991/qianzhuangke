//
//  CollectionViewCell.h
//  CollectionVIewText
//
//  Created by 栗子 on 2018/11/5.
//  Copyright © 2018年 http://www.cnblogs.com/Lrx-lizi/    https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DRCollectionModel;
@interface DRCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *selImageIc;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (nonatomic, copy) NSString *reasonStr;
@property (nonatomic) DRCollectionModel *collectionModel;


@end

NS_ASSUME_NONNULL_END
