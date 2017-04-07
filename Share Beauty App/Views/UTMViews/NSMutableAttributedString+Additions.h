//
//  NSMutableAttributedString+Additions.h
//  shiseido_finder
//
//  Created by t-fujii on 2014/06/12.
//  Copyright (c) 2014年 株式会社 デーコム. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (Additions)

- (void)setFont:(UIFont *)font;

- (void)setTextColor:(UIColor *)color;

- (void)setTracking:(float)trackingPt;

- (void)setTextAlignment:(NSTextAlignment)alignment;

- (void)setLineHeight:(CGFloat)height;

- (CGSize)needDisplaySize:(CGFloat)width;

@end
