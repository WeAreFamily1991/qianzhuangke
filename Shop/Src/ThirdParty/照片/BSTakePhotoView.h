//
//  BSTakePhotoView.h
//  BabyStore
//
//  Created by 解辉 on 2018/4/3.
//  Copyright © 2018年 那道. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^Block)(NSInteger tag);
@interface BSTakePhotoView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (nonatomic,copy)Block block;
+ (BSTakePhotoView *)getBSTakePhotoView;

@end
