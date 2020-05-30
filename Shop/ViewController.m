//
//  ViewController.m
//  Shop
//
//  Created by BWJ on 2018/12/28.
//  Copyright © 2018 SanTie. All rights reserved.
//

#import "ViewController.h"

#import "NetworkManager.h"

static NSString * const doc = @"Precomplie Prefix Header 下面一项Prefix Header 双击打开，把刚刚建好的pch文件拖到打开的对话框中，回车。";
static NSString * const temp = @"包装参数：1.400千支/盒 8.400千支/箱";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    UIView *subview = [[UIView alloc] init];
//    subview.backgroundColor = ColorWithHexString(@"ff0036");
//    
//    [self.view addSubview:subview];
//    [subview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.size.mas_equalTo(CGSizeMake(WidthScale(300), WidthScale(300)));
//    }];
//    
//    UILabel *label = [[UILabel alloc] init];
//    label.numberOfLines = 0;
//    label.textColor = ColorWithHexString(@"#a7a6ab");
//    label.font = DR_FONT(30);
//    label.textAlignment = NSTextAlignmentLeft;
//    [self.view addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(subview);
//        make.top.equalTo(subview.mas_bottom).mas_offset(30);
//        make.height.mas_equalTo(20);
//    }];
//    
////    label.text = doc;
////    CGFloat h = [Utility heightForString:doc width:200 font:Font(30)];
////    NSLog(@"h = %f", h);
//
//    label.text = temp;
//    CGFloat w = [Utility widthForString:temp height:20 font:DR_FONT(30)];
//    NSLog(@"w = %f", w);
//    
//    if (IsiPhoneXOrLater) {
//        STLog(@"这个是 iPhoneX 及以上的机型");
//        STLog(@"测试一下这个打印方法 %@", @"hello");
//    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self test1];
}

- (void)test1 {
    [[NetworkManager manager] getGuestTokenSuccess:^(id response) {
        STLog(@"%@", response);
    } fail:^(NSError *error) {
        STLog(@"%@", error);
    }];
}




@end
