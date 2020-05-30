//
//  HMSegmentedControl+CRExtention.m
//  CRShopDetailDemo
//
//  Created by roger wu on 19/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "HMSegmentedControl+CRExtention.h"
#import "CRConst.h"

@implementation HMSegmentedControl (CRExtention)

+ (instancetype)cr_segmentWithTitles:(NSArray *)titles WithImage:(NSArray *)sectionImages  withsectionSelectedImages:(NSArray *)sectionSelectedImages {
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionImages:sectionImages sectionSelectedImages:sectionSelectedImages titlesForSections:titles];
    segmentedControl.imagePosition = HMSegmentedControlImagePositionAboveText;
    segmentedControl.type = HMSegmentedControlTypeTextImages;
//    segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    segmentedControl.selectionIndicatorColor = kMainColor;
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl.selectionIndicatorHeight = 2.f;
//    segmentedControl.selectedSegmentIndex =2;
    segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName: REDCOLOR,
                                                     NSFontAttributeName: DR_FONT(15)};
    segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName: kBlackColor,
                                             NSFontAttributeName: DR_FONT(15)};
    
//    segmentedControl.borderType = HMSegmentedControlBorderTypeBottom;
//    segmentedControl.borderColor = kLightGrayColor;
//    segmentedControl.borderWidth = kSeperatorLineHeight;
    
    return segmentedControl;
}

@end
