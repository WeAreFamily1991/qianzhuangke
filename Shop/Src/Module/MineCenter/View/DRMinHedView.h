//
//  DRMinHedView.h
//  Shop
//
//  Created by rockding on 2019/11/15.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRMinHedView : UIView
@property(nonatomic,retain)UIButton *iconBtn;
@property(nonatomic,retain)UILabel *titleLab;
@property(nonatomic,retain)UILabel *phoneLab;
@property(nonatomic,retain)UILabel *sCountLab;
@property(nonatomic,retain)UILabel *sNameLab;
@property(nonatomic,retain)UILabel *cCountLab;
@property(nonatomic,retain)UILabel *CNameLab;
@property(nonatomic,retain)UILabel *qCountLab;
@property(nonatomic,retain)UILabel *qNameLab;
@property(nonatomic,retain)UILabel *dCountLab;
@property(nonatomic,retain)UILabel *dNameLab;
@property (nonatomic, copy) void (^selectedTagBlock)(NSInteger btnTag);
@property(nonatomic,copy)dispatch_block_t iconBtnBlock;

@property (nonatomic, copy)dispatch_block_t setBtnBlock;
@end

NS_ASSUME_NONNULL_END
