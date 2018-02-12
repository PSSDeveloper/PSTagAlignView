//
//  PSTagAlignView.h
//  PSTagAlignView
//
//  Created by 彭帅 on 2018/2/9.
//  Copyright © 2018年 pengshuai. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, PSTagAlignStyle) {
    PSTagAlignStyleLeft,
    PSTagAlignStyleRight
};
typedef void(^completionHeight)(CGFloat height);


@interface PSTagAlignView : UIView

+ (instancetype)tagAlignViewWithContents:(NSArray *)array
                              itemMarign:(CGFloat)marign
                        itemCornerRadius:(CGFloat)radius
                                itemFont:(UIFont *)itemFont
                           itemTextColor:(UIColor *)itemColor
                         itemBorderColor:(UIColor *)borderColor;
/** 对齐方式 */
@property (nonatomic,assign) PSTagAlignStyle alignStyle;

/** 回调传出总高度 */
@property (nonatomic,copy) completionHeight completionBlock;

/** 填充数据 */
- (void)reloadData;

@end
