//
//  MiSearchBar.m
//  miSearch
//
//  Created by miicaa_ios on 16/8/3.
//  Copyright (c) 2016年 xuxuezheng. All rights reserved.
//

#import "MiSearchBar.h"

@interface MiSearchBar()<UITextFieldDelegate>{
    
    
}

@property (strong, nonatomic) UILabel *searchLabel;

@end

@implementation MiSearchBar

-(id)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder{
    
    self = [super initWithFrame:frame];
    self.tintColor = WHITECOLOR;
    self.searchBarStyle = UISearchBarStyleMinimal;
    
    NSMutableString *blankString = [[NSMutableString alloc] init];
    
    int numberOfBlankCharacter = frame.size.width * 0.2;
    
    for (int i = 0; i < numberOfBlankCharacter; i++) {   //根据searchBar的长度计算应该插入多少个空格占位
        
        [blankString appendString:@" "];
    }
    
    self.placeholder = blankString;
    self.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1.0];
    
    self.searchTextField = [self valueForKey:@"searchField"];
    self.searchTextField.delegate = self;
    self.searchLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 255, 30)];
    self.searchLabel.textColor = [UIColor colorWithWhite:0.418 alpha:0.650];
    self.searchLabel.font = [UIFont systemFontOfSize:14];
    self.searchLabel.text = placeholder;
    [self.searchTextField addSubview:self.searchLabel];
    
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self.searchLabel setHidden:YES];

}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.text.length == 0) {
        
        [self.searchLabel setHidden:NO];
    }
}

@end
