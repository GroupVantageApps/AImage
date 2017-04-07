//
//  StringUtils.m
//  shiseido_finder
//
//  Created by DCOM on 2014/02/27.
//  Copyright (c) 2014年 株式会社 デーコム. All rights reserved.
//

#import "StringUtils.h"

@implementation StringUtils

+ (NSString *)replaceNewLine:(NSString *)str {
	if([self isNull:str]) {
		return @"";
	}
	return [str stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
}

+ (NSString *)nullToEmpty:(NSString *)str {
	if([self isNull:str]) {
		return @"";
	}
    return str ;
}

+ (BOOL )isNull:(NSString *)str {
    return (str == nil || [str isEqual:[NSNull null]]);
}
@end
