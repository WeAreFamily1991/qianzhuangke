//
//  DRComeModel.h
//  Shop
//
//  Created by BWJ on 2019/5/21.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRComeModel : DRBaseModel
@property (nonatomic , copy) NSString              * comeID;
@property (nonatomic , copy) NSString              * starttime;
@property (nonatomic , copy) NSString              * endtime;
@property (nonatomic , copy) NSString              * sortid;
@property (nonatomic , copy) NSString              * addtime;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSString              * linkUrlM;
@property (nonatomic , copy) NSString              * linkUrl;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * advType;
@property (nonatomic , copy) NSString              * imgM;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * content;
@end

NS_ASSUME_NONNULL_END
