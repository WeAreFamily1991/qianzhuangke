//
//  DRComView.h
//  Shop
//
//  Created by BWJ on 2019/6/14.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRComView : UIView
@property (weak, nonatomic) IBOutlet UIButton *thretitleBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeContentBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeIconbTN;
@property (weak, nonatomic) IBOutlet UIButton *secondTitleBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondContentBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondIconBtn;
@property (weak, nonatomic) IBOutlet UIButton *firstTitleBtn;
@property (weak, nonatomic) IBOutlet UIButton *firstContentBtn;
@property (weak, nonatomic) IBOutlet UIButton *firstIconBtn;
@property (weak, nonatomic) IBOutlet UIButton *clseBtn;
@property(nonatomic,retain)dispatch_block_t closeBtnBlock;
@end

NS_ASSUME_NONNULL_END
