//
//  ViewController.m
//  PSTagAlignView
//
//  Created by 彭帅 on 2018/2/9.
//  Copyright © 2018年 pengshuai. All rights reserved.
//

#import "ViewController.h"
#import "PSTagAlignView.h"
#import "PSTagItemLabel.h"

@interface ViewController ()
@property (nonatomic,strong) PSTagAlignView *tagAlignView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PSTagAlignView *tagAlignView = [PSTagAlignView tagAlignViewWithContents:@[@"金城郡", @"安定郡", @"北地郡",@"陈国", @"武威郡", @"张掖郡", @"梁国", @"酒泉郡", @"敦煌郡", @"张掖属国",@"中山国", @"沛国", @"居延属国",@"陇西郡",@"汉阳郡", @"鲁国",@"武都郡"] itemMarign:5.0 itemCornerRadius:5.0 itemFont:[UIFont systemFontOfSize:14] itemTextColor:[UIColor orangeColor] itemBorderColor:[UIColor orangeColor]];
    [self.view addSubview:tagAlignView];
    self.tagAlignView =tagAlignView;

    NSLayoutConstraint *widthConstarint = [NSLayoutConstraint constraintWithItem:tagAlignView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:350];

    NSLayoutConstraint *centerXConstarint = [NSLayoutConstraint constraintWithItem:tagAlignView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:tagAlignView.superview attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];

    NSLayoutConstraint *centerYConstarint = [NSLayoutConstraint constraintWithItem:tagAlignView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:tagAlignView.superview attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    [NSLayoutConstraint activateConstraints:@[widthConstarint, centerXConstarint, centerYConstarint]];

    __weak typeof(self) weakSelf = self;
    tagAlignView.completionBlock = ^(CGFloat height) {
        NSLayoutConstraint *heightConstarint = [NSLayoutConstraint constraintWithItem:weakSelf.tagAlignView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
        [heightConstarint setActive:YES];
    };
    [tagAlignView reloadData];
}
- (IBAction)switchChange:(UISwitch *)sender {
    if (sender.isOn) {
        //右对齐
        self.tagAlignView.alignStyle = PSTagAlignStyleRight;
        [self.tagAlignView reloadData];
    }else{
        //左对齐
        self.tagAlignView.alignStyle = PSTagAlignStyleLeft;
        [self.tagAlignView reloadData];
    }
}


@end
