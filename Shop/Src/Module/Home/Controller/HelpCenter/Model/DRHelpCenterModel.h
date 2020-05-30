//
//  DRHelpCenterModel.h
//  Shop
//
//  Created by rockding on 2019/12/30.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DRHelpList;
NS_ASSUME_NONNULL_BEGIN

@interface DRHelpCenterModel : DRBaseModel

@property (nonatomic , copy) NSString              * code;
@property (nonatomic , copy) NSString              * DRHelpCenterModelID;
@property (nonatomic , copy) NSArray<DRHelpList *>              * list;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * parentId;
@end

@interface DRHelpList :NSObject
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * list_id;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * url;

@end
NS_ASSUME_NONNULL_END
