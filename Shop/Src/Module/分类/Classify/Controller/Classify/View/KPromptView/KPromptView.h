//
//  KPromptView.h
//  云阙普惠
//
//  Created by a on 2019/3/28.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KPromptView;
@protocol KPromptViewDelegate<NSObject>

-(void)kPromptView:(KPromptView *)promptView cellStr:(NSString *)cellStr;


@end
@interface KPromptView : UIView


@property(nonatomic,copy)NSString * title;
@property(nonatomic,strong)NSArray * cellArr;
@property(nonatomic,strong)NSIndexPath * indexPath;
@property(nonatomic,weak)id<KPromptViewDelegate>delegate;
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title cellArray:(NSArray *)cellArr indexPath:(NSIndexPath*)indexPath;



@end

