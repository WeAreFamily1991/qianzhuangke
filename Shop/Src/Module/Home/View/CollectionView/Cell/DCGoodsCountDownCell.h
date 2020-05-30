//
//  DCGoodsCountDownCell.h
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DCGoodsCountDownCell : UICollectionViewCell
@property (copy,nonatomic) void (^btnItemBlock) (NSInteger btnTag);
@property (nonatomic,retain)NSMutableArray *itemMuArr;
@end
