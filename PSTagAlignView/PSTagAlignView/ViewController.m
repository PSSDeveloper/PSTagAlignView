//
//  ViewController.m
//  PSTagAlignView
//
//  Created by 彭帅 on 2018/2/9.
//  Copyright © 2018年 pengshuai. All rights reserved.
//

#define KMAXHeight [UIScreen mainScreen].bounds.size.height
#define KMAXWidth  [UIScreen mainScreen].bounds.size.width

#import "ViewController.h"
#import "PSTagAlignView.h"


@interface ViewController ()
@property (nonatomic,strong) PSTagAlignView *tagAlignView;
@property (nonatomic,strong) NSLayoutConstraint *widthConstarint;
@property (nonatomic,strong) NSLayoutConstraint *heightConstarint;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *dataArray = @[@"金城郡", @"安定郡", @"北地郡",@"陈国", @"武威郡", @"张掖郡", @"梁国", @"酒泉郡", @"敦煌郡", @"张掖属国",@"中山国", @"沛国", @"居延属国",@"陇西郡",@"汉阳郡", @"鲁国",@"武都郡"];
    /** 按照此格式传入配置参数 */
    NSDictionary *configDic = @{@"textFont": [UIFont systemFontOfSize:14],
                                @"textColor": [UIColor orangeColor],
                                @"borderColor": [UIColor orangeColor],
                                @"borderRadius": [NSNumber numberWithFloat:10.f]
                                };
    PSTagAlignView *tagAlignView = [PSTagAlignView tagAlignViewWithContents:dataArray itemMarign:5.0 configDict:configDic];
    
    [self.view addSubview:tagAlignView];
    
    self.tagAlignView =tagAlignView;

    NSLayoutConstraint *widthConstarint = [NSLayoutConstraint constraintWithItem:tagAlignView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:210];
    self.widthConstarint = widthConstarint;
    
    NSLayoutConstraint *heightConstarint = [NSLayoutConstraint constraintWithItem:tagAlignView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0];
    self.heightConstarint = heightConstarint;
    
    NSLayoutConstraint *centerXConstarint = [NSLayoutConstraint constraintWithItem:tagAlignView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:tagAlignView.superview attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];

    NSLayoutConstraint *centerYConstarint = [NSLayoutConstraint constraintWithItem:tagAlignView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:tagAlignView.superview attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    
    [NSLayoutConstraint activateConstraints:@[widthConstarint, heightConstarint, centerXConstarint, centerYConstarint]];

    __weak typeof(self) weakSelf = self;
    tagAlignView.completionBlock = ^(CGFloat height) {
        weakSelf.heightConstarint.constant = height;
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
- (IBAction)increaseWidth:(UIButton *)sender {
    CGFloat originalWidth = self.widthConstarint.constant;
    self.widthConstarint.constant = MIN(KMAXWidth, originalWidth + 50);
    __weak typeof(self) weakSelf = self;
    self.tagAlignView.completionBlock = ^(CGFloat height) {
        weakSelf.heightConstarint.constant = height;
    };
    [self.tagAlignView reloadData];

}
- (IBAction)descreaseWidth:(UIButton *)sender {
    CGFloat originalWidth = self.widthConstarint.constant;
    self.widthConstarint.constant = MAX(0, originalWidth - 50);
    __weak typeof(self) weakSelf = self;
    self.tagAlignView.completionBlock = ^(CGFloat height) {
        weakSelf.heightConstarint.constant = height;
    };
    [self.tagAlignView reloadData];
}


@end
