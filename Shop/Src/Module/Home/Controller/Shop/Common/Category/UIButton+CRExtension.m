//
//  UIButton+CRExtension.m
//  CRShopDetailDemo
//
//  Created by roger wu on 02/06/2017.
//  Copyright © 2017 cocoaroger. All rights reserved.
//

#import "UIButton+CRExtension.h"

static const CGFloat kHighlightedAlpha = 0.6f;

@implementation UIButton (CRExtension)

- (void)cr_setTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateNormal];
    
    UIColor *highlightedColor = [color colorWithAlphaComponent:kHighlightedAlpha];
    [self setTitleColor:highlightedColor forState:UIControlStateHighlighted];
    [self setTitleColor:highlightedColor forState:UIControlStateDisabled];
}

- (void)cr_setImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateNormal];
    
    UIImage *highlightedImage = [self imageWithAlpha:kHighlightedAlpha image:image];
    [self setImage:highlightedImage forState:UIControlStateHighlighted];
    [self setImage:highlightedImage forState:UIControlStateDisabled];
}

- (void)cr_setBackgroundImage:(UIImage *)image {
    [self setBackgroundImage:image forState:UIControlStateNormal];
    
    UIImage *highlightedImage = [self imageWithAlpha:kHighlightedAlpha image:image];
    [self setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    [self setBackgroundImage:highlightedImage forState:UIControlStateDisabled];
}

#pragma mark - Private Method
- (UIImage *)imageWithAlpha:(CGFloat)alpha image:(UIImage *)image {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
