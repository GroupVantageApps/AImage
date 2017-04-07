//
//  StringUtils.h
//  shiseido_finder
//
//  Created by DCOM on 2014/02/27.
//  Copyright (c) 2014年 株式会社 デーコム. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  文字列操作ユーティリティ
 */
@interface StringUtils : NSObject
/**
 *  改行文字を変換して返します。
 *
 *  @param str 対象文字列
 *
 *  @return 変換後文字列
 */
+ (NSString *)replaceNewLine:(NSString *)str;
/**
 *  対象文字列がnullの時、空文字に変換して返す。
 *
 *  @param str 対象文字列
 *
 *  @return 変換後文字列
 */
+ (NSString *)nullToEmpty:(NSString *)str;
/**
 *  対象文字列がnullかどうか判定する。
 *
 *  @param str 対象文字列
 *
 *  @return BOOL
 */
+ (BOOL )isNull:(NSString *)str;

@end
