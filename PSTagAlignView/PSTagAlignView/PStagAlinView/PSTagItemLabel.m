//
//  PSTagItemLabel.m
//  PSTagAlignView
//
//  Created by 彭帅 on 2018/2/11.
//  Copyright © 2018年 pengshuai. All rights reserved.
//

#import "PSTagItemLabel.h"

@interface PSTagItemLabel ()
@property (nonatomic,strong) UILabel *itemLabel;


@end

@implementation PSTagItemLabel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.layer.borderColor = [UIColor orangeColor].CGColor;
        self.layer.borderWidth = 1.f;
        self.layer.cornerRadius = 10.f;
        [self addSubview:self.itemLabel];
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
    return item.bounds.size.width + 2*5;
}

- (UILabel *)itemLabel{
    if(!_itemLabel){
        _itemLabel = [[UILabel alloc] init];
        _itemLabel.textAlignment =NSTextAlignmentCenter;
        _itemLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _itemLabel.textColor = [UIColor orangeColor];
        _itemLabel.font = [UIFont systemFontOfSize:14];
    }
    return _itemLabel;
}



@end
