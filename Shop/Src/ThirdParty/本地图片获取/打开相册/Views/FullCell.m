//
//  FullCell.m
//  PhotosAsset
//
//  Created by 77 on 2017/7/4.
//  Copyright © 2017年 77. All rights reserved.
//

#import "FullCell.h"
#import "WKWAsset.h"
#define kWindowH   [UIScreen mainScreen].bounds.size.height //应用程序的屏幕高度
#define kWindowW    [UIScreen mainScreen].bounds.size.width  //应用程序的屏幕宽度
#define HScale(v) v / 667. * kWindowH //高度比
#define WScale(w) w / 375. * kWindowW //宽度比
#pragma mark - UIImageView 继承类的方法
@implementation myImageView

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}

@end


@implementation FullCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self createImageViewOrScroll];
        self.FullImageView.backgroundColor = REDCOLOR;
    }
    return self;
    
}

- (void)createImageViewOrScroll {
    
    _myScroll = [[UIScrollView alloc] init];
    _myScroll.minimumZoomScale = 0.5;
    _myScroll.maximumZoomScale = 2.0;
    _myScroll.delegate         = self;
    _myScroll.frame            = self.bounds;
    _myScroll.backgroundColor  = BLACKCOLOR;
    _myScroll.showsVerticalScrollIndicator = NO;
    [self addSubview:self.myScroll];
    _FullImageView = [[myImageView alloc] init];
    [self.myScroll addSubview:_FullImageView];
    
//    _FullImageView.frame = self.bounds;
    
}

//获取图片信息（通过属性传过来的asset 获取）
- (void)makeUI:(PHAsset *)Asset {
    WKWAsset *wkwasset = [[WKWAsset alloc] init];
    UIImage *image =  [wkwasset smallImageSize:self.bounds.size asset:Asset];
    [self.FullImageView setImage:image];
    _imgsize = image.size;
    
}

- (void)layoutSubviews {
      [self updateImagesize:_imgsize];
}
//更新ImageView的frame
- (void)updateImagesize:(CGSize)imgsize {
    CGFloat w,h;
    if (imgsize.width > imgsize.height) {
        w = kWindowW;
        h = imgsize.height * kWindowW/imgsize.width;
        self.FullImageView.size = CGSizeMake(w, h);
        
    }else {
        h = kWindowH;
        w = imgsize.width *kWindowH/imgsize.height;
        self.FullImageView.size = CGSizeMake(w, h);
    }
    self.FullImageView.center = CGPointMake(kWindowW/2.0, kWindowH/2.0);
//    self.FullImageView.frame = CGRectMake(0, kWindowH/4.0, w, h);
}
#pragma mark - ScrollView 代理
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    NSLog(@"kk%f",self.FullImageView.size.height);
    self.FullImageView.center = CGPointMake(kWindowW/2.0, kWindowH/2.0);
    return self.FullImageView;
}


@end
