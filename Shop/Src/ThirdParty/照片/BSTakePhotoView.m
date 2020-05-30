//
//  BSTakePhotoView.m
//  BabyStore
//
//  Created by 解辉 on 2018/4/3.
//  Copyright © 2018年 那道. All rights reserved.
//

#import "BSTakePhotoView.h"

@implementation BSTakePhotoView

+ (BSTakePhotoView *)getBSTakePhotoView
{
    BSTakePhotoView *phoneView = [[[NSBundle mainBundle]loadNibNamed:@"BSTakePhotoView" owner:self options:nil] firstObject];
    return phoneView;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.bgImageView.userInteractionEnabled = YES;
    _deleteButton.imageEdgeInsets = UIEdgeInsetsMake(-5, 5, 5, -5);
}
- (IBAction)deleteButtonClick:(id)sender {
    if (_block)
    {
        _block(0);
    }
}
@end
