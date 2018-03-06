//
//  PSTagAlignView.m
//  PSTagAlignView
//
//  Created by 彭帅 on 2018/2/9.
//  Copyright © 2018年 pengshuai. All rights reserved.
//

#import "PSTagAlignView.h"
#import "PSTagItemLabel.h"



@interface PSTagAlignView ()
/** 字体大小 */
@property (nonatomic,strong) UIFont *characterFont;
/** 两个item间距 */
@property (nonatomic,assign) CGFloat marign;
/** item圆角大小 */
@property (nonatomic,assign) CGFloat radius;
/** 显示数据 */
@property (nonatomic,strong) NSArray *contentArray;
/** 边框颜色 */
@property (nonatomic,strong) UIColor *borderColor;
/** 字体颜色 */
@property (nonatomic,strong) UIColor *itemTextColor;

@property (nonatomic,strong) PSTagItemLabel *flagLabel;


@end

@implementation PSTagAlignView

+ (instancetype)tagAlignViewWithContents:(NSArray *)array
                       itemMarign:(CGFloat)marign
                              configDict:(NSDictionary *)configDic{
    if (configDic == nil) {
        NSLog(@"请传入相关配置参数");
        return nil;
    }else{
        PSTagAlignView *tagAlignView = [[self alloc] initWithFrame:CGRectZero];
        UIFont *characterFont = [configDic valueForKey:@"textFont"];
        UIColor *textColor = [configDic valueForKey:@"textColor"];
        UIColor *borderColor = [configDic valueForKey:@"borderColor"];
        NSNumber *borderRadius = [configDic valueForKey:@"borderRadius"];
        tagAlignView.characterFont = (characterFont == nil ? [UIFont systemFontOfSize:14] : characterFont);
        tagAlignView.radius = (borderRadius == nil ? 0.f : [borderRadius floatValue]);
        tagAlignView.itemTextColor = textColor == nil ? [UIColor orangeColor] :textColor;
        tagAlignView.borderColor = borderColor == nil ? [UIColor orangeColor] : borderColor;
        tagAlignView.marign = marign;
        tagAlignView.contentArray = array;
        return tagAlignView;
    }
}

- (void)reloadData{
    if (self.subviews.count > 0) {
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
    }
    [self fillContents];
}

- (void)fillContents{
    [self layoutIfNeeded];//由于后续需要使用该view的实际宽度
    if (self.contentArray.count > 0) {
        /** 填充数据 */
        CGFloat maxWidth = self.bounds.size.width;
        PSTagItemLabel *tempItem = nil;
        for (NSString *str in self.contentArray) {
            PSTagItemLabel *itemLabel = [[PSTagItemLabel alloc] initWithFrame:CGRectZero WithtextColor:self.itemTextColor textFont:self.characterFont borderColor:self.borderColor borderRadius:self.radius];
            itemLabel.contentString = str;
            CGFloat itemWidth = [itemLabel widthOfStr:str] + self.marign;
            NSAssert(itemWidth <= maxWidth, @"Error:The content string beyond the maxwidth");
            if (itemWidth <= maxWidth) {
                [self addSubview:itemLabel];
                if (self.alignStyle == PSTagAlignStyleLeft) {
                    [self alignFromLeftWithItemLabel:itemLabel tempItem:tempItem itemWidth:itemWidth];
                } else {
                    [self alignFromRightWithItemLabel:itemLabel tempItem:tempItem itemWidth:itemWidth];
                }
                [self layoutIfNeeded];
                tempItem = itemLabel;
            }else{
                return;
            }
        }
        if (self.completionBlock) {
            self.completionBlock(CGRectGetMaxY(tempItem.frame) + self.marign);
        }
    }
}

- (void)alignFromRightWithItemLabel: (PSTagItemLabel *)itemLabel tempItem:(PSTagItemLabel *)tempItem itemWidth:(CGFloat)itemWidth{
    if (tempItem == nil) {
        NSLayoutConstraint *itemTop = [NSLayoutConstraint constraintWithItem:itemLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.marign];
        NSLayoutConstraint *itemRight = [NSLayoutConstraint constraintWithItem:itemLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-1*self.marign];
        [NSLayoutConstraint activateConstraints:@[itemRight, itemTop]];
    } else {
        CGFloat resultWidth = CGRectGetMinX(tempItem.frame);
        if (resultWidth > itemWidth) {
            //可以放的下
            NSLayoutConstraint *itemTop = [NSLayoutConstraint constraintWithItem:itemLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:tempItem attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
            NSLayoutConstraint *itemRight = [NSLayoutConstraint constraintWithItem:itemLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:tempItem attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-1*self.marign];
            [NSLayoutConstraint activateConstraints:@[itemTop, itemRight]];
        }else{
            NSLayoutConstraint *itemRight = [NSLayoutConstraint constraintWithItem:itemLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-1 * self.marign];
            NSLayoutConstraint *itemTop = [NSLayoutConstraint constraintWithItem:itemLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:tempItem attribute:NSLayoutAttributeBottom multiplier:1.0 constant:self.marign];
            [NSLayoutConstraint activateConstraints:@[itemRight, itemTop]];
        }
    }
}

- (void)alignFromLeftWithItemLabel:(PSTagItemLabel *)itemLabel tempItem:(PSTagItemLabel *)tempItem itemWidth:(CGFloat)itemWidth{
    //进行布局,此处tempFrame为针对self的frame
    CGFloat resultWidth = CGRectGetMaxX(self.frame) - CGRectGetMaxX([self convertRect:tempItem.frame toView:self.superview]);
    if (tempItem == nil) {
        //进行布局
        NSLayoutConstraint *itemLeft = [NSLayoutConstraint constraintWithItem:itemLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.marign];
        NSLayoutConstraint *itemTop = [NSLayoutConstraint constraintWithItem:itemLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.marign];
        [NSLayoutConstraint activateConstraints:@[itemLeft, itemTop]];
    }else{
        if (resultWidth > itemWidth) {
            NSLayoutConstraint *itemLeft = [NSLayoutConstraint constraintWithItem:itemLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:tempItem attribute:NSLayoutAttributeRight multiplier:1.0 constant:self.marign] ;
            NSLayoutConstraint *itemBottom = [NSLayoutConstraint constraintWithItem:itemLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:tempItem attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
            [NSLayoutConstraint activateConstraints:@[itemLeft, itemBottom]];
        }else{
            //换行
            NSLayoutConstraint *itemLeft = [NSLayoutConstraint constraintWithItem:itemLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.marign];
            NSLayoutConstraint *itemTop = [NSLayoutConstraint constraintWithItem:itemLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:tempItem attribute:NSLayoutAttributeBottom multiplier:1.0 constant:self.marign];
            [NSLayoutConstraint activateConstraints:@[itemLeft, itemTop]];
        }
    }
}
-(void)setCompletionBlock:(completionHeight)completionBlock{
    _completionBlock = completionBlock;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:CGRectZero]) {
        self.backgroundColor = [UIColor blackColor];
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}
@end
