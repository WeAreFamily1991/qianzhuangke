//
//  SNCrash.m
//  scinansdkframework
//
//  Created by Felix on 2017/6/15.
//  Copyright © 2017年 Scinan. All rights reserved.
//

#import "SNCrash.h"
#import "SNAPIManager.h"
#import <KSCrash/KSCrashInstallationStandard.h>
#import "AFNetworking.h"
#import "MJExtension.h"
#import "NSObject+SN.h"

@interface SNCrash ()

@property (strong, nonatomic) KSCrashInstallationStandard *installation;
@property (strong, nonatomic) NSTimer *timer;

@property (copy, nonatomic) NSString *projectID;
@property (strong, nonatomic) NSArray *atMobiles;

@end

@implementation SNCrash

#pragma mark - 单例

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static SNCrash *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    
    return instance;
}

+ (SNCrash *)shareCrash{
    return [[self alloc] init];
}

#pragma mark -

+ (void)setupBugHDProjectKey:(NSString *)key projectID:(NSString *)ID atMobiles:(NSArray *)atMobiles {
    if(!key.length) {
        NSLog(@"init BugHd error !");
        return ;
    }
    
    SNCrash *crash = [SNCrash shareCrash];
    [crash setupBugHDProjectKey:key projectID:ID atMobiles:atMobiles];
}

- (void)setupBugHDProjectKey:(NSString *)key projectID:(NSString *)ID atMobiles:(NSArray *)atMobiles {
    
    KSCrashInstallationStandard* installation = [KSCrashInstallationStandard sharedInstance];
    NSString *reportUrl=[NSString stringWithFormat:@"https://collector.bughd.com/kscrash?key=%@",key];
    installation.url = [NSURL URLWithString:reportUrl];
    [installation install];
    self.installation = installation;
    
    self.projectID = ID;
    self.atMobiles = atMobiles;
    
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(sendReports) userInfo:nil repeats:NO];
    }
}

- (void)sendReports {
    [self.timer invalidate];
    self.timer = nil;
    
    __weak typeof(self) weakSelf = self;
    [self.installation sendAllReportsWithCompletion:^(NSArray *filteredReports, BOOL completed, NSError *error) {
        
        if (filteredReports.count <= 0) {
            return;
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
            NSString *appName = [dicInfo objectForKey:@"CFBundleDisplayName"];
            NSString *commitID = [dicInfo objectForKey:@"CommitId"];
            NSString *sdkCommitID = [dicInfo objectForKey:@"SdkCommitId"];
            NSString *scinanKey = [NSString stringWithFormat:@"company_id:%@ ----- app_key:%@", [SNAPIManager shareAPIManager].companyID, [SNAPIManager shareAPIManager].appKey];
            
            for (NSDictionary *dict in filteredReports) {
                
                NSMutableDictionary *newDict = [NSMutableDictionary dictionary];
                newDict[@"system"] = dict[@"system"];
                newDict[@"diagnosis"] = dict[@"crash"][@"diagnosis"];
                if (weakSelf.projectID) {
                    newDict[@"bugHD_project"] = [NSString stringWithFormat:@"http://bughd.com/project/%@", weakSelf.projectID];
                }
                
                if (appName)        newDict[@"app_name"] = appName;
                if (commitID)       newDict[@"commit_id_project"] = commitID;
                if (sdkCommitID)    newDict[@"commit_id_sdk"] = sdkCommitID;
                newDict[@"key"] = scinanKey;
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
                NSDate *date = [formatter dateFromString:dict[@"report"][@"timestamp"]];
                
                NSDateFormatter *formatterUTC8 = [[NSDateFormatter alloc] init];
                formatterUTC8.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
                formatterUTC8.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                NSString *timeUTC8 = [formatterUTC8 stringFromDate:date];
                
                NSDateFormatter *formatterLocal = [[NSDateFormatter alloc] init];
                formatterLocal.timeZone = [NSTimeZone localTimeZone];
                formatterLocal.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                NSString *timeLocal = [formatterLocal stringFromDate:date];
                
                newDict[@"time"] = [NSString stringWithFormat:@"local:%@ ----- UTC+8:%@", timeLocal, timeUTC8];
                
                NSDictionary *textDict = [NSDictionary dictionaryWithObjects:@[newDict.descriptionUTF8] forKeys:@[@"content"]];
                NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjects:@[@"text", textDict] forKeys:@[@"msgtype", @"text"]];
                
                if (weakSelf.atMobiles) {
                    params[@"at"] = [NSDictionary dictionaryWithObjects:@[weakSelf.atMobiles] forKeys:@[@"atMobiles"]];
                }
                
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                manager.requestSerializer = [AFJSONRequestSerializer serializer];
                
                [manager POST:@"https://oapi.dingtalk.com/robot/send?access_token=f4f8a01a0e0f2b108f4ec8db3d6da1f063f0df57f90a8a34c402d6d2bf495db2" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
//                    NSLog(@"收到：\n%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
//                    NSLog(@"");
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                }];
            }
        });
    }];
}

@end
