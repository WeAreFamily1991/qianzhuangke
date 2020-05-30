//
//  ShoppingCartViewController.m
//  Shop
//
//  Created by BWJ on 2018/12/29.
//  Copyright © 2018 SanTie. All rights reserved.
//


#import "DRSettlementVC.h"
#import "DCReceivingAddressViewController.h"
#import "DRNetVC.h"
#import "DRShopHomeVC.h"
@interface DRSettlementVC ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (strong,nonatomic) WKWebView *webView;
@property (nonatomic,strong)WKUserContentController *userContentController;
@property (nonatomic,strong) UIProgressView *progressView;
@property (nonatomic,copy) NSString *productName;

@property (nonatomic,copy) NSString *picture;
@end

@implementation DRSettlementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"结算";
    [self initWKWebView];
    [self initProgressView];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self clearCache];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"submitOrder"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"openAddress"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"toStoreInfo"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"toLayim"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"toLogin"];
}
/** 清理缓存的方法，这个方法会清除缓存类型为HTML类型的文件*/
- (void)clearCache {
    /* 取得Library文件夹的位置*/
    NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES)[0];
    /* 取得bundle id，用作文件拼接用*/
    NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleIdentifier"];
    /*
     * 拼接缓存地址，具体目录为App/Library/Caches/你的APPBundleID/fsCachedData
     */
    NSString *webKitFolderInCachesfs = [NSString stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
    
    NSError *error;
    /* 取得目录下所有的文件，取得文件数组*/
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //    NSArray *fileList = [[NSArray alloc] init];
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:webKitFolderInCachesfs error:&error];
    /* 遍历文件组成的数组*/
    for(NSString * fileName in fileList){
        /* 定位每个文件的位置*/
        NSString * path = [[NSBundle bundleWithPath:webKitFolderInCachesfs] pathForResource:fileName ofType:@""];
        /* 将文件转换为NSData类型的数据*/
        NSData * fileData = [NSData dataWithContentsOfFile:path];
        /* 如果FileData的长度大于2，说明FileData不为空*/
        if(fileData.length >2){
            /* 创建两个用于显示文件类型的变量*/
            int char1 =0;
            int char2 =0;
            
            [fileData getBytes:&char1 range:NSMakeRange(0,1)];
            [fileData getBytes:&char2 range:NSMakeRange(1,1)];
            /* 拼接两个变量*/
            NSString *numStr = [NSString stringWithFormat:@"%i%i",char1,char2];
            /* 如果该文件前四个字符是6033，说明是Html文件，删除掉本地的缓存*/
            if([numStr isEqualToString:@"6033"]){
                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",webKitFolderInCachesfs,fileName]error:&error];
                continue;
            }
        }
    }
}

#pragma mark - Private Methods

- (void)initWKWebView
{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    
    //注册供js调用的方法
    _userContentController = [[WKUserContentController alloc] init];
    [_userContentController addScriptMessageHandler:self name:@"submitOrder"];
    [_userContentController addScriptMessageHandler:self name:@"openAddress"];
    [_userContentController addScriptMessageHandler:self name:@"toLayim"];
    [_userContentController addScriptMessageHandler:self name:@"toStoreInfo"];
     [_userContentController addScriptMessageHandler:self name:@"toLogin"];
    
    configuration.userContentController = _userContentController;
    
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    //preferences.minimumFontSize = 40.0;
    configuration.preferences = preferences;
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-DRTopHeight-2) configuration:configuration];
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
//    NSString *baseStr =@"http://192.168.31.121:8012/AppView/index";
//    NSString *urlStr = [NSString stringWithFormat:@"%@?token=%@",baseStr,[User currentUser].token];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
    [self.webView loadRequest:request];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
}

- (void)initProgressView
{
    
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
    progressView.tintColor = REDCOLOR;
    progressView.trackTintColor = [UIColor whiteColor];
    [self.view addSubview:progressView];
    self.progressView = progressView;
}
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            [self.progressView setProgress:1.0 animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.hidden = YES;
                [self.progressView setProgress:0 animated:NO];
            });
            
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}

#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //领取抽奖商品
    if ([message.name isEqualToString:@"submitOrder"]) {

        DRNetVC *netVC=[[DRNetVC alloc]init];
        if ([message.body[@"payType"] isEqualToString:@"1"]) {
//
            netVC.titleStr =@"恭喜你！您的订单已提交成功！请等待审核！其中在线支付的订单，请审核通过后进行支付，届时会有短信通知！";
        }
        else{
            netVC.titleStr =@"恭喜你！您的订单已提交成功！请等待审核！";
        }
        [self.navigationController pushViewController:netVC animated:YES];
        
    }
    if ([message.name isEqualToString:@"openAddress"]) {
        DCReceivingAddressViewController *addressVC =[[DCReceivingAddressViewController alloc]init];
        addressVC.selectStr =@"1";
        addressVC.changeURLBLOCK = ^(NSString *addressid, NSString *receiverStr, NSString *mobileStr, NSString *addressStr) {
        NSString *allStr =[NSString stringWithFormat:@"%@&id=%@",self.urlStr,addressid];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:allStr]];
        [self.webView loadRequest:request];
        };
        [self.navigationController pushViewController:addressVC animated:YES];
    }
    
    if ([message.name isEqualToString:@"toStoreInfo"]) {
        DRShopHomeVC *detailVC = [DRShopHomeVC new];
        
        detailVC.sellerId=message.body[@"sellerId"];
        [self.navigationController pushViewController:detailVC animated:YES];

    }
    if ([message.name isEqualToString:@"toLayim"]) {
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://4006185027"]];
    }
    if ([message.name isEqualToString:@"toLogin"]) {
        [DRAppManager showLoginView];
    }
    
}
- (void)backBtnTapAction {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
