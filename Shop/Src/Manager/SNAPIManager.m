//
//  SNAPIManager.m
//  sdk-demo
//
//  Created by User on 16/3/19.
//  Copyright © 2016年 Scinan. All rights reserved.
//

#import "SNAPIManager.h"
#import "SNToken.h"
//#import "SNIOTTool.h"
#import "SNURL.h"
#import <CoreLocation/CoreLocation.h>
#import "SNVersionCheck.h"

#import "SNAccount.h"
#import "SNAPI.h"

@interface SNAPIManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong)CLLocationManager *locationManager;

@end

@implementation SNAPIManager

#pragma mark - 单例

+ (id)allocWithZone:(struct _NSZone *)zone {
    
    static SNAPIManager *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
        
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        NSString *languageString = nil;
        if ([currentLanguage hasPrefix:@"zh-Hans"] || [currentLanguage hasPrefix:@"zh-Hant"]) {
            languageString = @"zh-CN";
        } else {
            languageString = @"en-US";
        }
        
        instance.location =@"";
        instance.language = languageString;
        instance.format = @"json";
        instance.isShowLog  = NO;
        instance.companyID = @"";
        instance.debugKey = @"";
        instance.debugSecret = @"";
        instance.releaseKey = @"";
        instance.releaseSecret = @"";
        instance.isNode = NO;
    });
    
    return instance;
}

+ (SNAPIManager *)shareAPIManager{
    return [[self alloc] init];
}

#pragma mark - 

- (NSString *)baseURL {
    return _isConnectFormalServer ? RELEASEAPI_ROOT: DEBUGAPI_ROOT;
}

- (NSString *)appKey {
    return _isConnectFormalServer ? _releaseKey : _debugKey;
}

- (NSString *)appSecret {
    return _isConnectFormalServer ? _releaseSecret : _debugSecret;
}

- (NSString *)mqttPushURL {
    return _isConnectFormalServer ? @"push.scinan.com" : @"testpush.scinan.com";
}

- (void)setIsConnectFormalServer:(BOOL)isConnectFormalServer {
    _isConnectFormalServer = isConnectFormalServer;
    
//    if (isConnectFormalServer) {
//        _baseURL = @"https://api.scinan.com/v2.0";
//        _appKey = _releaseKey;
//        _appSecret = _releaseSecret;
//        _mqttPushURL = @"push.scinan.com";
//    } else {
//        _baseURL = @"https://testapi.scinan.com/v2.0";
//        _appKey = _debugKey;
//        _appSecret = _debugSecret;
//        _mqttPushURL = @"testpush.scinan.com";
//    }
    
    if (isConnectFormalServer) {
        [SNVersionCheck checkAppVersionAndShowAlertViewResult:^(BOOL haveNewVersion) {
            
        }];
    }
}

- (void)setIsUseLocation:(BOOL)isUseLocation {
    _isUseLocation = isUseLocation;
    
    if (isUseLocation) {
        CLLocationManager *locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 0.5;
        [locationManager requestWhenInUseAuthorization];//这句话ios8以上版本使用。
        [locationManager startUpdatingLocation];
        self.locationManager =locationManager;
    }
}

- (NSDate *)expiresTime {
    if (!_expiresTime) {
        _expiresTime = [SNToken loadToken].expiresTime;
    }
    return _expiresTime;
}

- (NSString *)token {
    if (!_token) {
        _token = [SNToken loadToken].access_token;
    }
    return _token;
}

#pragma mark -

- (BOOL)checkToken {
    
    BOOL result = YES;
    NSTimeInterval interval = [self.expiresTime timeIntervalSinceDate:[NSDate date]];
    
    if (interval < 600) {
        
        [SNAPI userRefreshTokenSuccess:^{
            
        } failure:^(NSError *error) {
            
        }];
    }
    
    return result;
}

#pragma mark -- 定位信息代理回调

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *current = [locations lastObject];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:current completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
  
            self.location =[NSString stringWithFormat:@"%f,%f",placemark.location.coordinate.latitude,placemark.location.coordinate.longitude];
        } else if (error == nil && [array count] == 0){
            
        }else if (error != nil){
            
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}

#pragma mark - 判断是否为同一天

- (BOOL)isToday:(NSDate *)date{
    if (!date) {
        return NO;
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:unit fromDate:date];
    
    return (nowCmps.year == selfCmps.year) && (nowCmps.month == selfCmps.month) && (nowCmps.day == selfCmps.day);
}

@end
