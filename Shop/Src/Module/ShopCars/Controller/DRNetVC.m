//
//  DRNetVC.m
//  Shop
//
//  Created by BWJ on 2019/5/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRNetVC.h"

@interface DRNetVC ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation DRNetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLab.text =self.titleStr;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self hideNavigationBar];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (IBAction)closeBtnClick:(id)sender {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)minBtnClick:(id)sender {
     [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.selectedIndex =4;
    [self.navigationController popToRootViewControllerAnimated:YES];
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
