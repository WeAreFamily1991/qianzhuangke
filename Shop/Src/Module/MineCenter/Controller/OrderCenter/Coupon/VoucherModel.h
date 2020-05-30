//
//  VoucherModel.h
//  Shop
//
//  Created by BWJ on 2019/3/29.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VoucherModel : NSObject
@property (nonatomic , copy) NSString              * sareaids;
@property (nonatomic , copy) NSString              * auditRemark;
@property (nonatomic , assign) NSInteger              isOverlayHd;
@property (nonatomic , copy) NSString              * isAutopull;
@property (nonatomic , copy) NSString              * voucher_id;
@property (nonatomic , assign) NSInteger              distrType;
@property (nonatomic , assign) NSInteger              topicType;//0平台，1卖家
@property (nonatomic , assign) NSInteger              endtime;
@property (nonatomic , assign) NSInteger              onlyNewBuyer;
@property (nonatomic , copy) NSString              * auditName;
@property (nonatomic , assign) NSInteger              isOverlayCx;
@property (nonatomic , copy) NSString              * descriptionStr;
@property (nonatomic , copy) NSString              * voucherTopicId;
@property (nonatomic , assign) NSInteger              addTime;
@property (nonatomic , copy) NSString              * buyerId;
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , copy) NSString              * buyerStatus;
@property (nonatomic , assign) NSInteger              issueNum;
@property (nonatomic , assign) BOOL              inUse;
@property (nonatomic , assign) BOOL              isWillExpire;
@property (nonatomic , assign) NSInteger              prdtType;
@property (nonatomic , copy) NSString              * sellerIds;
@property (nonatomic , copy) NSString              * addUser;
@property (nonatomic , assign) BOOL              valid;
@property (nonatomic , copy) NSString              * addName;
@property (nonatomic , copy) NSString              * topicid;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , assign) NSInteger              validTimeEnd;
@property (nonatomic , copy) NSString              * auditUser;
@property (nonatomic , copy) NSString              * voidType;
@property (nonatomic , assign) NSInteger              isMainpage;
@property (nonatomic , copy) NSString              * sellerType;
@property (nonatomic , assign) NSInteger              starttime;
@property (nonatomic , assign) NSInteger              validTimeSta;
@property (nonatomic , assign) double              voucherCond;
@property (nonatomic , copy) NSString              * voucherType;
@property (nonatomic , copy) NSString              * voidDays;
@property (nonatomic , assign) NSInteger              isshow;
@property (nonatomic , assign) double              voucherSum;
@property (nonatomic , assign) NSInteger              auditTime;
@property (nonatomic , assign) NSInteger              oneBuyerMax;
@property (nonatomic , copy) NSString              * sellerName;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * stypes;
@property (nonatomic , assign) NSInteger              receiveTime;
@property (nonatomic , assign) NSInteger              userStartTime;
@property (nonatomic , assign) NSInteger              userEndTime;

@end

NS_ASSUME_NONNULL_END
