//
//  GHCountField.m
//  GHCountTextField
//
//  Created by GHome on 2018/1/25.
//  Copyright © 2018年 GHome. All rights reserved.
//

#define kShowMessage(msg) [[[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil] show];
#import "GHCountField.h"
@interface GHButton()


@end
@implementation GHButton
- (void)setHighlighted:(BOOL)highlighted {
    
}

@end
@interface GHCountField()
@property (nonatomic , strong) GHButton *leftButton;
@property (nonatomic , strong) GHButton *rightButton;

@end
@implementation GHCountField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
   
        self.layer.borderColor =BACKGROUNDCOLOR.CGColor;
        self.layer.borderWidth =1;
        UIImage *leftImage = [UIImage imageNamed:@"product_detail_sub_normal"];
        UIImageView *leftImageView = [[UIImageView alloc]init];
        leftImageView.frame = CGRectMake(5, 0, leftImage.size.width, leftImage.size.height);
        leftImageView.image = leftImage;
        GHButton *leftButton = [GHButton buttonWithType:UIButtonTypeCustom];
        [leftButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        leftButton.frame = CGRectMake(5, 0, leftImage.size.width, leftImage.size.height);
        [leftButton setImage:[UIImage imageNamed:@"product_detail_sub_normal"] forState:UIControlStateNormal];
        [leftButton setImage:[UIImage imageNamed:@"product_detail_sub_no"] forState:UIControlStateDisabled];
        leftButton.tag = GHCountFieldButtonType_sub;
        self.leftButton = leftButton;
        self.leftView = leftButton;
        
        UIImage *rightImage = [UIImage imageNamed:@"product_detail_add_normal"];
        GHButton *rightButton = [GHButton buttonWithType:UIButtonTypeCustom];
        [rightButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        rightButton.frame = CGRectMake(5, 0, rightImage.size.width, rightImage.size.height);
        [rightButton setImage:[UIImage imageNamed:@"product_detail_add_normal"] forState:UIControlStateNormal];
        [rightButton setImage:[UIImage imageNamed:@"product_detail_add_no"] forState:UIControlStateDisabled];
        rightButton.tag = GHCountFieldButtonType_add;
        UIImageView *rightImageView = [[UIImageView alloc]init];
        rightImageView.frame = CGRectMake(5, 0, rightImage.size.width, rightImage.size.height);
        rightImageView.image = rightImage;
        self.rightButton = rightButton;

        self.leftViewMode = UITextFieldViewModeAlways;
        self.rightViewMode = UITextFieldViewModeAlways;
        self.rightView = rightButton;
        self.textAlignment = NSTextAlignmentCenter;
        self.keyboardType = UIKeyboardTypeNumberPad;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:self];
        self.minCount = 0;
    }
    return self;
}

- (void)textChange: (NSNotification *)noti {
    
    NSInteger count = self.text.integerValue;

    if (count >= self.maxCount) {
        self.rightButton.enabled = NO;
        self.leftButton.enabled = YES;
        self.text = [NSString stringWithFormat:@"%ld",(long)self.maxCount];
    }else if (count == self.minCount) {
        self.leftButton.enabled = NO;
        self.rightButton.enabled = YES;

    } else if (count < self.maxCount && count > self.minCount) {
        self.leftButton.enabled = YES;
        self.rightButton.enabled = YES;
    }
    
    if (self.countFielddDelegate && [self.countFielddDelegate respondsToSelector:@selector(countField:count:)]) {
        [self.countFielddDelegate countField:self count:self.text.integerValue];
    }
    
    if (self.countBlock) {
        self.countBlock(self.text.integerValue);
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self];
}
- (void)setCount:(NSInteger)count {
    _count = count;
    self.text = [NSString stringWithFormat:@"%ld",(long)count];
}
- (void)clickButton: (UIButton *)button {
    button.selected = !button.selected;
    NSInteger count = self.text.integerValue;

    if (button.tag == GHCountFieldButtonType_add) {
        if (count < self.maxCount) {
            count++;
            button.enabled = YES;
            
            if (count ==self.maxCount) {
                button.enabled = NO;
            }
            self.leftButton.enabled = YES;

        }
    } else if (button.tag == GHCountFieldButtonType_sub) {
        if (count > self.minCount) {
            count--;
            if (count == self.minCount) {
                button.enabled = NO;

            }
            self.rightButton.enabled = YES;

        } else {
            button.enabled = YES;
        }
    }
    self.text = [NSString stringWithFormat:@"%ld",(long)count];

    if (self.countFielddDelegate && [self.countFielddDelegate respondsToSelector:@selector(countField:count:)]) {
        [self.countFielddDelegate countField:self count:self.text.integerValue];
    }
    
    if (self.countBlock) {
        self.countBlock(self.text.integerValue);
    }
}
- (instancetype)init {
    if (self == [super init]) {
        
    }
    return self;
}


@end
