//
//  SNUserInfoVC.m
//  FaceCook
//
//  Created by Murphy on 17/3/16.
//  Copyright (c) 2017年 Scinan. All rights reserved.
//

#import "SNUserInfoVC.h"
#import "SNAPI.h"
#import "UIButton+WebCache.h"
#import "SNButton.h"

@interface SNUserInfoVC () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIButton *avatarBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;

@property (nonatomic, assign) BOOL isbingWechat;

@end

@implementation SNUserInfoVC

- (UIButton *)avatarBtn {
    if (!_avatarBtn) {
        
        UIButton *avatarBtn = [[UIButton alloc] init];
        avatarBtn.frame = CGRectMake(SCREEN_WIDTH-105, 12, 72, 72);
        [avatarBtn sd_setImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_touxiang"]];
        avatarBtn.layer.masksToBounds = YES;
        avatarBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        avatarBtn.layer.borderWidth = 1;
        avatarBtn.layer.cornerRadius = avatarBtn.frame.size.width * 0.5;
        _avatarBtn = avatarBtn;
    }
    return _avatarBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = SNStandardString(@"个人信息");
    self.view.backgroundColor = BACKGROUNDCOLOR;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    SNButton *logoutBtn = [[SNButton alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 50)];
    [logoutBtn setTitle:SNStandardString(@"menu_item_logout_text") forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:logoutBtn];
    
    self.tableView.tableFooterView = footView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.avatarBtn.layer.masksToBounds = YES;
    self.avatarBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.avatarBtn.layer.borderWidth = 1;
    
    [self loadThirdparty];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.avatarBtn.layer.cornerRadius = self.avatarBtn.frame.size.width * 0.5;
}

- (void)loadThirdparty {
    __weak typeof(self) weakSelf = self;
    [SNAPI thirdpartyGetBindListSuccess:^(NSArray *bindList) {
        
        for (id object in bindList) {
            if ([object intValue] == SNThirdpartyTypeWechat) {
                weakSelf.isbingWechat = YES;
                break;
            }
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 点击

- (IBAction)clickHeader:(UIButton *)sender {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:SNStandardString(@"icon_takephoto_text"), SNStandardString(@"icon_gallrey_text"), nil];
    [sheet showInView:self.view];
}

- (IBAction)logout:(UIButton *)btn {
    
//    [SNAppManager logout];
//    [self.navigationController popViewControllerAnimated:YES];
//    [SNAppManager showLoginView];
}

#pragma mark - 提交

//- (IBAction)saveTap:(id)sender {
//    
//    if (_nameField.text.length==0) {
//        [MBProgressHUD showError:SNStandardString(@"enter_nickname")];
//        [self.nameField becomeFirstResponder];
//        return;
//    } else  if (_nameField.text.length>=17) {
//        [MBProgressHUD showError:SNStandardString(@"nickname_length_error")];
//        [self.nameField becomeFirstResponder];
//        return;
//    }
//    [self.view endEditing:YES];
//    
//    __weak typeof(self) weakSelf = self;
//    [MBProgressHUD showMessage:@""];
//    if (self.image) {
//        [SNAPI userAvatar:self.image nickName:self.nameField.text success:^{
//            [weakSelf finish];
//        } failure:^(NSError *error) {
//            
//        }];
//        
//    }else{
//        [SNAPI userModifyBaseWithUserAddress:nil userPhone:nil userNickname:_nameField.text userSex:nil success:^{
//            [weakSelf finish];
//            
//        } failure:^(NSError *error) {
//            
//        }];
//    }
//}
//
//- (void)back {
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//- (void)finish {
//    [MBProgressHUD hideHUD];
//    [MBProgressHUD showSuccess:SNStandardString(@"update_success")];
//    if (self.changeInfo) {
//        self.changeInfo();
//    }
//    [self performSelector:@selector(back) withObject:nil afterDelay:0.5f];
//}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            pickerController.allowsEditing = YES;
            pickerController.delegate = self;
            [self presentViewController:pickerController animated:YES completion:nil];
        }
    } else if (buttonIndex == 1) {
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerController.allowsEditing = YES;
            pickerController.delegate = self;
            [self presentViewController:pickerController animated:YES completion:nil];
        }
    }
};

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"SNUserInfoVC";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        
        UIView *line = [[UIView alloc] init];
        line.frame = CGRectMake(0, 49.5, SCREEN_WIDTH, 0.5);
        line.backgroundColor = RGB(190, 190, 190);
        line.tag = 90;
        [cell addSubview:line];
        
        cell.textLabel.textColor = KTextColor;
    }
    
    UIView *line = (UIView *)[cell viewWithTag:90];
    
    if (indexPath.section == 0) {
        
        cell.textLabel.text = @"头像";
        [cell addSubview:self.avatarBtn];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        line.hidden = YES;
        
    } else {
        line.hidden = NO;
        
        NSArray *titleArr = @[SNStandardString(@"修改密码"), @"手机号", @"微信绑定"];
        cell.textLabel.text = titleArr[indexPath.row];
//        switch (indexPath.row) {
//            case 0:
//                cell.detailTextLabel.text = self.user.user_nickname;
//                cell.detailTextLabel.textColor = KTextColor;
//                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//                break;
//            case 1:
//                cell.detailTextLabel.text = self.user.user_mobile;
//                cell.detailTextLabel.textColor = RGB(167, 167, 167);
//                cell.accessoryType = UITableViewCellAccessoryNone;
//                break;
//            case 2:
//                cell.detailTextLabel.text = self.isbingWechat ? NSLocalizedString(@"解绑", nil) : NSLocalizedString(@"未绑定", nil);
//                cell.detailTextLabel.textColor = KTextColor;
//                cell.accessoryType = UITableViewCellAccessoryNone;
//                break;
//            case 3:
//                cell.detailTextLabel.text = nil;
//                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//                break;
//            default:
//                break;
//        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    __weak typeof(self) weakSelf = self;
    switch (indexPath.row) {
        case 0:{
            break;
        }
        case 2:{
            if (self.isbingWechat) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:SNStandardString(@"确定要解除微信绑定吗？") message:nil delegate:self cancelButtonTitle:SNStandardString(@"cancel") otherButtonTitles:SNStandardString(@"ok"), nil];
                [alert show];
            } else {
                
            }
            break;
        }
        case 3:{
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SNMe" bundle:nil];
            UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"SNPasswordVC"];
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    [self.avatarBtn setImage:image forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    
//    [SNAPI userAvatar:image nickName:nil success:^{
//        [MBProgressHUD showSuccess:SNStandardString(@"update_success")];
//        if (weakSelf.changeInfo) {
//            weakSelf.changeInfo();
//        }
//    } failure:^(NSError *error) {
//        
//    }];
//    if (self.changeInfo) {
//        self.changeInfo();
//    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        __weak typeof(self) weakSelf = self;
        [SNAPI thirdpartyDeleteWithThirdpartyType:SNThirdpartyTypeWechat success:^{
            weakSelf.isbingWechat = NO;
            [weakSelf.tableView reloadData];
        } failure:^(NSError *error) {
            
        }];
    }
}

@end
