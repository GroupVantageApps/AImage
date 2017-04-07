//
//  NSMutableAttributedString+Additions.m
//  shiseido_finder
//
//  Created by t-fujii on 2014/06/12.
//  Copyright (c) 2014年 株式会社 デーコム. All rights reserved.
//

#import "NSMutableAttributedString+Additions.h"

#define HEIGHT 10000

@implementation NSMutableAttributedString (Additions)

/**
 * @brief フォントを設定する
 * @param [in] font フォント
 *
 * @author takafujii
 * @date 2014/06/12
 */
- (void)setFont:(UIFont *)font
{
    [self addAttribute:NSFontAttributeName
                 value:font
                 range:NSMakeRange(0, self.length)];
}

/**
 * @brief 文字色を設定する
 * @param [in] color 文字色
 *
 * @author takafujii
 * @date 2014/06/12
 */
- (void)setTextColor:(UIColor *)color
{
    [self addAttribute:NSForegroundColorAttributeName
                 value:color
                 range:NSMakeRange(0, self.length)];
}

/**
 * @brief 文字のトラッキングを指定する
 * @param [in] trackingPt トラッキング値（pt）
 *
 * @author takafujii
 * @date 2014/06/12
 */
- (void)setTracking:(float)trackingPt
{
    [self addAttribute:NSKernAttributeName
                 value:[NSNumber numberWithFloat:trackingPt]
                 range:NSMakeRange(0, self.length)];
}

/**
 * @brief 文字の表示位置を指定する
 * @param [in] alignment 表示位置
 *
 * @author takafujii
 * @date 2014/06/12
 */
- (void)setTextAlignment:(NSTextAlignment)alignment;
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:alignment];
    
    [self addAttribute:NSParagraphStyleAttributeName
                 value:paragraphStyle
                 range:NSMakeRange(0, self.length)];
}

- (void)setLineHeight:(CGFloat)height
{
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    paragrahStyle.minimumLineHeight = height;
    paragrahStyle.maximumLineHeight = height;
 
    [self addAttribute:NSParagraphStyleAttributeName
                 value:paragrahStyle
                 range:NSMakeRange(0, self.length)];
}

- (CGSize)needDisplaySize:(CGFloat)width
{
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, HEIGHT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                     context:nil];
    rect.size.height += 5.0f;
    return rect.size;
}

@end
