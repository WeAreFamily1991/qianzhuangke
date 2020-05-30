//
//  CollectionViewCell.m
//  CollectionVIewText
//
//  Created by 栗子 on 2018/11/5.
//  Copyright © 2018年 http://www.cnblogs.com/Lrx-lizi/    https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

#import "DRCollectionViewCell.h"
#import "DRCollectionModel.h"
@implementation DRCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
  
    
}
-(void)setCollectionModel:(DRCollectionModel *)collectionModel
{
    _collectionModel =collectionModel;
    self.content.text =collectionModel.name;
}



@end
