//
//  DCCountDownHeadView.h
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCCountDownHeadView : UICollectionReusableView
/* 时间 */
@property (strong , nonatomic)UIButton *timeBtn;
@property (nonatomic, copy) dispatch_block_t timeBtnBlock;
@end
