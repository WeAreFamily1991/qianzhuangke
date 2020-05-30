//
//  SelectPhotoView.h
//  Shop
//
//  Created by BWJ on 2019/4/16.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectPhotoView : UIView
@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIView *nomelView;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (retain,nonatomic)dispatch_block_t commitBtnBlock;

@end

NS_ASSUME_NONNULL_END
