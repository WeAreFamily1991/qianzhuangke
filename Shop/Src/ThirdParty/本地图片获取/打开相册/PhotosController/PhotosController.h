//
//  PhotosController.h
//  PhotosAsset
//
//  Created by 77 on 2017/7/4.
//  Copyright © 2017年 77. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotosControllerDelegate <NSObject>

@optional

//[[UIImage, 下标]]
- (void)getImagesArray:(NSArray*)imagesArray;

@required

@end

@interface PhotosController : STBaseViewController

@property (nonatomic, assign) id<PhotosControllerDelegate>  delegate;

@property (nonatomic, assign) NSInteger selectMaxNum;
@property (nonatomic, strong) NSArray  *selectImgArr;

@end
