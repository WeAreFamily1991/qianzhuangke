//
//  DRFooterCell.m
//  Shop
//
//  Created by BWJ on 2019/6/12.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRFooterCell.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "DRSameModel.h"
@implementation DRFooterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"DRFooterCell";
    DRFooterCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DRFooterCell" owner:nil options:nil] firstObject];
    }
//    cell.lookIMGbTN.userInteractionEnabled = YES;
    [cell.lookIMGbTN addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:cell action:@selector(photoTap:)]];
    return cell;
}
-(void)setSameModel:(DRSameModel *)sameModel
{
    _sameModel =sameModel;
    NSString *timestr;
    if (sameModel.deliveryDay>1) {
        timestr =[NSString stringWithFormat:@"预计发货时间：%ld天",(long)sameModel.deliveryDay];
    }else{
        timestr =@"预计发货时间：当天发货";
    }
    NSArray *titleArr =@[[NSString stringWithFormat:@"最小销售单位：%@",sameModel.saleUnitName],[NSString stringWithFormat:@"单规格起订量：%.3f%@",sameModel.minQuantity,sameModel.saleUnitName],timestr];
    self.danweiLab.text = titleArr[0];
    self.qidingliangLab.text = titleArr[1];
    self.timeLAb.text = titleArr[2];
    if (sameModel.drawing.length==0) {
        self.lookIMGbTN.hidden =YES;
        self.lookLab.hidden =YES;
        self.imgLab.hidden =YES;
        self.lineView.hidden =YES;
    }
    else
    {
        self.lookIMGbTN.hidden =NO;
        self.lookLab.hidden =NO;
        self.imgLab.hidden =NO;
        self.lineView.hidden =NO;
    }
}

- (void)photoTap:(UITapGestureRecognizer *)recognizer
{
//    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
//
//    //2.告诉图片浏览器显示所有的图片
//    NSMutableArray *photos = [NSMutableArray array];
//
//        //传递数据给浏览器
//        MJPhoto *photo = [[MJPhoto alloc] init];
//        photo.url = [NSURL URLWithString:_sameModel.drawing];
//        photo.srcImageView = self.subviews; //设置来源哪一个UIImageView
//        [photos addObject:photo];
////    }
//    brower.photos = @[photo];
////
////    //3.设置默认显示的图片索引
////    brower.currentPhotoIndex = recognizer.view.tag;
//
//    //4.显示浏览器
//    [brower show];
     !_lookIMGBtnBlock?:_lookIMGBtnBlock();
}
- (IBAction)lookBtnClick:(id)sender {
    !_lookIMGBtnBlock?:_lookIMGBtnBlock();
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
