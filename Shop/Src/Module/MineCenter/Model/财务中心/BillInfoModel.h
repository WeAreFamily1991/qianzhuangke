//
//  BillInfoModel.h
//  Shop
//
//  Created by BWJ on 2019/3/27.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface BillInfoModel : NSObject
@property (nonatomic , copy) NSString              * bankNo;
@property (nonatomic , copy) NSString              * regPhone;
@property (nonatomic , copy) NSString              * imgUrl;
@property (nonatomic , copy) NSString              * ticketCompany;
@property (nonatomic , copy) NSString              * bank;
@property (nonatomic , copy) NSString              * taxNumber;
@property (nonatomic , copy) NSString              * ticketType;
@property (nonatomic , copy) NSString              * regAddress;
@end

@interface InvoiceReceiverModel : NSObject

@property (nonatomic , copy) NSString              * invoiceReceiverMobile;
@property (nonatomic , copy) NSString              * invoiceReceiverAddress;
@property (nonatomic , copy) NSString              * invoiceReceiverLocationArea;
@property (nonatomic , copy) NSString              * invoiceReceiverLocation;
@property (nonatomic , copy) NSString              * invoiceReceiverName;

@end
NS_ASSUME_NONNULL_END
