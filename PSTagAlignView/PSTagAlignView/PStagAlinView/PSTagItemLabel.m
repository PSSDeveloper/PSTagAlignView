//
//  PSTagItemLabel.m
//  PSTagAlignView
//
//  Created by 彭帅 on 2018/2/11.
//  Copyright © 2018年 pengshuai. All rights reserved.
//

#import "PSTagItemLabel.h"

/** 文字显示的上下边距 */
static const CGFloat PSTagItemPading = 5.f;

@interface PSTagItemLabel ()

@property (nonatomic,strong) UILabel *itemLabel;


@end

@implementation PSTagItemLabel


- (instancetype)initWithFrame:(CGRect)frame WithtextColor:(UIColor *)textColor
                     textFont:(UIFont *)textFont borderColor:(UIColor *)borderColor
                 borderRadius:(CGFloat)radious{
    if (self = [super initWithFrame:frame]) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.layer.borderWidth = 1.f;
        
        self.layer.borderColor = borderColor.CGColor;
        self.layer.cornerRadius = radious;
        [self addSubview:self.itemLabel];
        self.itemLabel.textColor = textColor;
        self.itemLabel.font = textFont;

        NSLayoutConstraint *leftConstarint = [NSLayoutConstraint constraintWithItem:self.itemLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:5.f];
        NSLayoutConstraint *rightConstarint = [NSLayoutConstraint constraintWithItem:self.itemLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-5.f];
        NSLayoutConstraint *topConstarint = [NSLayoutConstraint constraintWithItem:self.itemLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.f];
        NSLayoutConstraint *bottomConstarint = [NSLayoutConstraint constraintWithItem:self.itemLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-5.f];
        [NSLayoutConstraint activateConstraints:@[leftConstarint, rightConstarint, topConstarint, bottomConstarint]];
    }
    return self;
}


-(void)setContentString:(NSString *)contentString{
    _contentString = contentString;
    self.itemLabel.text = contentString;
    [self layoutIfNeeded];
}

- (CGFloat)widthOfStr:(NSString *)str{
    UILabel *item = self.itemLabel;
    item.text = self.contentString;
    [item sizeToFit];
    return item.bounds.size.width + 2*PSTagItemPading;
}

- (UILabel *)itemLabel{
    if(!_itemLabel){
        _itemLabel = [[UILabel alloc] init];
        _itemLabel.textAlignment =NSTextAlignmentCenter;
        _itemLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _itemLabel.layer.masksToBounds = YES;
        _itemLabel.backgroundColor = _itemLabel.superview.superview.backgroundColor;
    }
    return _itemLabel;
}



@end
