//
//  PSTagItemLabel.h
//  PSTagAlignView
//
//  Created by 彭帅 on 2018/2/11.
//  Copyright © 2018年 pengshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSTagItemLabel : UIView

@property (nonatomic,copy) NSString *contentString;

- (CGFloat)widthOfStr:(NSString *)str;

- (instancetype)initWithFrame:(CGRect)frame WithtextColor:(UIColor *)textColor
                     textFont:(UIFont *)textFont borderColor:(UIColor *)borderColor
                 borderRadius:(CGFloat)radious;


@end
