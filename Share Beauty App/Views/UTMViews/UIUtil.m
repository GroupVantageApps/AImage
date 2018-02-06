//
//  UIUtil.m
//  shiseido_finder
//
//  Created by DCOM on 2014/02/07.
//  Copyright (c) 2014年 株式会社 デーコム. All rights reserved.
//

#import "UIUtil.h"
#import "StringUtils.h"
#import "NSMutableAttributedString+Additions.h"
#import "Share_Beauty_App-Swift.h"

const CGFloat kButtonAlphaStateEnabled = 1.0f;
const CGFloat kButtonAlphaStateDisabled = 0.4f;


@implementation UIUtil

+ (void)showLabelText:(UIView *)view text:(NSString *)text fontSize:(NSInteger)fontSize frame:(CGRect)frame newline:(BOOL)newLineFlg {
	UILabel *lbl = [[UILabel alloc]initWithFrame:frame];
	lbl.backgroundColor = [UIColor clearColor];
	lbl.text = text;
	//lbl.font = [UIFont fontWithName:@"Reader-Regular" size:[UIFont systemFontSize]];
    lbl.font = [UIFont systemFontOfSize:fontSize];
	if (newLineFlg) {
		[lbl setLineBreakMode:NSLineBreakByWordWrapping];// update 20141227 t-hirai>>NSLineBreakByCharWrapping>>NSLineBreakByWordWrapping
		[lbl setNumberOfLines:0];
		[lbl sizeToFit];
	}
	[view addSubview:lbl];
}



+ (void)setTransitionSlide:(UINavigationController *)navigationController {
	[self setTransitionSlide:navigationController from:kCATransitionFromRight];
}

+ (void)setTransitionSlide:(UINavigationController *)navigationController from:(NSString *)subtype {
	CATransition *transition = [CATransition animation];
	transition.duration = 0.05;//t-hirai 20150702
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionMoveIn;
	transition.subtype = subtype;
	[navigationController.view.layer addAnimation:transition forKey:nil];
}

+ (void)setTransitionFade:(UINavigationController *)navigationController {
	CATransition *transition = [CATransition animation];
	transition.duration = 0.05;//t-hirai 20150702
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionFade;
	[navigationController.view.layer addAnimation:transition forKey:nil];
}

+ (UIFont *)getShiseidoLight:(CGFloat)fontSize {
	return [UIFont fontWithName:@"Shiseido-Light" size:fontSize];
}

+ (UIFont *)getShiseidoBold:(CGFloat)fontSize {
	return [UIFont fontWithName:@"Shiseido-Bold" size:fontSize];
}

+ (UIFont *)getShiseidoExtraBold:(CGFloat)fontSize {
	return [UIFont fontWithName:@"Shiseido-ExtraBold" size:fontSize];
}

+ (UIFont *)getShiseidoExtraLight:(CGFloat)fontSize {
	return [UIFont fontWithName:@"Shiseido-ExtraLight" size:fontSize];
}

+ (UIFont *)getOptimaRegular:(CGFloat)fontSize {
	return [UIFont fontWithName:@"Optima-Regular" size:fontSize];
}
+ (UIFont *)getReaderBold:(CGFloat)fontSize {
	return [UIFont fontWithName:@"Reader-Bold" size:fontSize];
}
+ (UIFont *)getReaderRegular:(CGFloat)fontSize {
    return [UIFont fontWithName:@"Reader-Regular" size:fontSize];
}
+ (UIFont *)getReaderMedium:(CGFloat)fontSize {
    return [UIFont fontWithName:@"Reader-Medium" size:fontSize];
}

+ (UIFont *)getSystemBold:(CGFloat)fontSize {
    return [UIFont fontWithName:@"Reader-Bold" size:fontSize];
    //return [UIFont boldSystemFontOfSize:fontSize];
}

+ (void)slideAnimation:(UIView *)view frame:(CGRect)frame delegate:(id)delegate {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.1f];//201506 t-hirai 0.5f
	[UIView setAnimationDelegate:delegate];
	[view setFrame:frame];
	[UIView commitAnimations];
}

+ (CGFloat)getLabelHeight:(NSString *)labelText width:(CGFloat)width fontsize:(NSInteger)fontSize {
    CGSize size = [labelText
                   boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                   options:NSStringDrawingUsesLineFragmentOrigin
                   attributes:@{NSFontAttributeName:[self getShiseidoLight:fontSize]}
                   //attributes:@{NSFontAttributeName:[self getShiseidoLight:fontSize]}
                   context:nil].size;
	return size.height;
}

+ (CGFloat)getContentHeight:(UIView *)view {
	CGFloat maxHeight = 0;
	for (UIView *childView in view.subviews) {
		CGFloat height = childView.frame.origin.y + childView.frame.size.height;
		if (maxHeight < height) {
			maxHeight = height;
		}
	}
	return maxHeight;
}

+ (UIImage *)trimImage:(UIImage *)img rect:(CGRect)rect {
	float scale = [[UIScreen mainScreen] scale];
	CGRect scaled_rect = CGRectMake(rect.origin.x * scale,
	                                rect.origin.y * scale,
	                                rect.size.width * scale,
	                                rect.size.height * scale);
	CGImageRef clip = CGImageCreateWithImageInRect(img.CGImage, scaled_rect);
	UIImage *trimed_image = [UIImage imageWithCGImage:clip
	                                            scale:scale
	                                      orientation:UIImageOrientationUp];
	CGImageRelease(clip);

	return trimed_image;
}

+ (CGFloat)convertPointY:(CGFloat)y {
	float version = [[[UIDevice currentDevice] systemVersion] floatValue];
	if (version < 7) {
		return y - 20;
	}

	return y;
}

+ (UIImage *)getBackGroundImage:(NSString *)imageName rect:(CGRect)rect {
	UIGraphicsBeginImageContext(CGSizeMake(rect.size.width, rect.size.height));
	[[UIImage imageNamed:imageName] drawInRect:rect];
	UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return backgroundImage;
}


+ (UIFont *)getShiseidoLightx:(CGFloat)fontSize {
	return [UIFont fontWithName:@"Shiseido-Light" size:fontSize];
}

+ (UIColor *)grayColor
{
    return [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
}
//赤文字設定　20151006 t−hirai　colorWithRed:148/255.0 green:37/255.0 blue:42/255.0 alpha:1];
+ (UIColor *)redColor
{
    return [UIColor colorWithRed:207/255.0 green:20/255.0 blue:43/255.0 alpha:1];
}

+ (UIColor *)borderLineGrayColor
{
    return [UIColor colorWithRed:113/255.0 green:113/255.0 blue:113/255.0 alpha:1];
}

+ (UIColor *)lineStepRedColor
{
    return [UIColor colorWithRed:215/255.0 green:0/255.0 blue:47/255.0 alpha:1];
}

+ (UIColor *)lineStepBorderRedColor
{
    return [UIColor colorWithRed:217/255.0 green:80/255.0 blue:78/255.0 alpha:1];

}

+ (UIColor *)lineStepBorderGrayColor
{
    return [UIColor colorWithRed:89/255.0 green:86/255.0 blue:86/255.0 alpha:1];
}

+ (UIColor *)settingViewBgGrayColor
{
    return [UIColor colorWithRed:181.0f/255.0f green:181.0f/255.0f blue:181.0f/255.0f alpha:1.0f];
}

+ (NSAttributedString *)convertStringToAttributedString:(NSString *)text
                                               withFont:(UIFont *)font
                                              withColor:(UIColor *)color
                                           withTracking:(float)trackingPt
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]
                                                 initWithString:[StringUtils nullToEmpty:text]];
    NSRange range = NSMakeRange(0, attributedText.length);
    
    [attributedText addAttribute:NSFontAttributeName
                           value:font
                           range:range];
    
    [attributedText addAttribute:NSForegroundColorAttributeName
                           value:color
                           range:range];
    
    if(trackingPt > 0.0f){
        [attributedText addAttribute:NSKernAttributeName
                               value:[NSNumber numberWithFloat:trackingPt]
                               range:range];
    }

    return [attributedText copy];
}

+ (CGSize)attributeStringSize:(NSAttributedString *)string withWidth:(float)width
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 10000)
                                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                 context:nil];
    return rect.size;
}

+ (BOOL)isiOS7Later{
	float version = [[[UIDevice currentDevice] systemVersion] floatValue];
	if (version >= 7) {
		return YES;
	}
	return NO;
}


+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
     
    return image;
}


//UTM コンテンツ始め
+ (NSMutableArray *)getUtmArray
{
    // CSVファイルからセクションデータを取得する utmコンテンツ
    NSInteger languageId = LanguageConfigure.languageId;
    int fileId = 0;
    switch (languageId) {
        case 2:
            fileId = 5766;
            break;
        case 3:
            fileId = 5766;
            break;
        case 4:
            fileId = 5770 ;
            break;
        case 5:
            fileId = 5788;
            break;
        case 6:
            fileId = 5789;
            break;
        case 7:
            fileId = 5808;
            break;
        case 8:
            fileId = 5784;
            break;
        case 9:
            fileId = 5770;
            break;
        case 10:
            fileId = 5788;
            break;
        case 11:
            fileId = 5789;
            break;
        case 12:
            fileId = 5808;
            break;
        case 13:
            fileId = 5784;
            break;
        case 14:
            fileId = 5780;
            break;
        case 15:
            fileId = 5780;
            break;
        case 16:
            fileId = 5766;
            break;
        case 17:
            fileId = 5783;
            break;
        case 18:
            fileId = 5784;
            break;
        case 20:
            fileId = 5785;
            break;
        case 21:    //hk
            fileId = 5786;
            break;
        case 22:    //hk
            fileId = 5787;
            break;
        case 23:
            fileId = 5788;
            break;
        case 24:
            fileId = 5789;
            break;
        case 26:
            fileId = 5785;
            break;
        case 27:
            fileId = 5808;
            break;
        case 28:
            fileId = 5766;
            break;
        case 29:
            fileId = 5794;
            break;
        case 30:
            fileId = 5766;
            break;
        case 31:
            fileId = 5808;
            break;
        case 32:
            fileId = 5766;
            break;
        case 33:
            fileId = 5785;
            break;
        case 34:
            fileId = 5766;
            break;
        case 35:
            fileId = 5780;
            break;
        case 36:
            fileId = 5788;
            break;
        case 37:
            fileId = 5785;
            break;
        case 38:
            fileId = 5808;
            break;
        case 39:
            fileId = 5786;
            break;
        case 40:
            fileId = 5794;
            break;
        case 41:
            fileId = 5789;
            break;
        case 42:
            fileId = 5808;
            break;
        case 43:
            fileId = 5780;
            break;
        case 48:
            fileId = 5766;
            break;
        case 49:
            fileId = 5766;
            break;
        case 55:
            fileId = 5766;
            break;
        case 58:
            fileId = 6243;
            break;
        case 59:
            fileId = 5766;
            break;
        case 60:
            fileId = 5766;
            break;
        case 61:
            fileId = 5808;
            break;
        case 62:
            fileId = 5785;
            break;
        case 63:
            fileId = 5770;
            break;
        case 64:
            fileId = 5780;
            break;
        case 65:
            fileId = 5784;
            break;
        case 66:
            fileId = 5794;
            break;
        case 67:
            fileId = 5786;
            break;
        case 68:
            fileId = 5766;
            break;
        case 69:
            fileId = 5808;
            break;
        case 70:
            fileId = 5785;
            break;
        case 71:
            fileId = 5770;
            break;
        case 72:
            fileId = 5780;
            break;
        case 73:
            fileId = 5784;
            break;
        case 74:
            fileId = 5794;
            break;
        case 75:
            fileId = 5786;
            break;
        case 76:
            fileId = 5766;
            break;
        case 77:
            fileId = 5808;
            break;
        case 78:
            fileId = 5785;
            break;
        case 79:
            fileId = 5770;
            break;
        case 80:
            fileId = 5780;
            break;
        case 81:
            fileId = 5784;
            break;
        case 82:
            fileId = 5794;
            break;
        case 83:
            fileId = 5786;
            break;
        default:
            fileId = 5766;
            break;
    }
    NSMutableArray *array = [FileTable getCsvWithFileId:fileId];
    if (array == nil) {
        array = [FileTable getCsvWithFileId: 5766];
    }
    return array;
}
//UTM コンテンツ終わり

+ (NSArray *)get17SSArray {
    // CSVファイルからセクションデータを取得する 17SS

    NSInteger languageId = LanguageConfigure.languageId;
    int fileId = 0;
    switch (languageId) {
        case 2:
            fileId = 6324;
            break;
        case 3:
            fileId = 6324;
            break;
        case 4:
            fileId = 6325;
            break;
        case 5:
            fileId = 6327;
            break;
        case 6:
            fileId = 6328;
            break;
        case 7:
            fileId = 6330;
            break;
        case 8:
            fileId = 6333;
            break;
        case 9:
            fileId = 6325;
            break;
        case 10:
            fileId = 6327;
            break;
        case 11:
            fileId = 6328;
            break;
        case 12:
            fileId = 6330;
            break;
        case 13:
            fileId = 6333;
            break;
        case 14:
            fileId = 6324;
            break;
        case 15:
            fileId = 6324;
            break;
        case 16:
            fileId = 6324;
            break;
        case 17:
            fileId = 6332;
            break;
        case 18:
            fileId = 6333;
            break;
        case 20:
            fileId = 5326;
            break;
        case 21:            //hk
            fileId = 5914;
            break;
        case 22:            //hk
            fileId = 5915;
            break;
        case 23:
            fileId = 6327;
            break;
        case 24:
            fileId = 6328;
            break;
        case 26:
            fileId = 5326;
            break;
        case 27:
            fileId = 6330;
            break;
        case 28:
            fileId = 6324;
            break;
        case 29:
            fileId = 6329;
            break;
        case 30:
            fileId = 6324;
            break;
        case 31:
            fileId = 6330;
            break;
        case 32:
            fileId = 6324;
            break;
        case 33:
            fileId = 5326;
            break;
        case 34:
            fileId = 6324;
            break;
        case 35:
            fileId = 6324;
            break;
        case 36:
            fileId = 6327;
            break;
        case 37:
            fileId = 5326;
            break;
        case 38:
            fileId = 6330;
            break;
        case 39:
            fileId = 5914;
            break;
        case 40:
            fileId = 6329;
            break;
        case 41:
            fileId = 6328;
            break;
        case 42:
            fileId = 6330;
            break;
        case 43:
            fileId = 6324;
            break;
        case 48:
            fileId = 6324;
            break;
        case 49:
            fileId = 6324;
            break;
        case 55:
            fileId = 6324;
            break;
        case 58:
            fileId = 6331;
            break;
        case 59:
            fileId = 6324;
            break;
        case 60:
            fileId = 6324;
            break;
        case 61:
            fileId = 6330;
            break;
        case 62:
            fileId = 5326;
            break;
        case 63:
            fileId = 6325;
            break;
        case 64:
            fileId = 6324;
            break;
        case 65:
            fileId = 6333;
            break;
        case 66:
            fileId = 6329;
            break;
        case 67:
            fileId = 5914;
            break;
        case 68:
            fileId = 6324;
            break;
        case 69:
            fileId = 6330;
            break;
        case 70:
            fileId = 5326;
            break;
        case 71:
            fileId = 6325;
            break;
        case 72:
            fileId = 6324;
            break;
        case 73:
            fileId = 6333;
            break;
        case 74:
            fileId = 6329;
            break;
        case 75:
            fileId = 5914;
            break;
        case 76:
            fileId = 6324;
            break;
        case 77:
            fileId = 6330;
            break;
        case 78:
            fileId = 5326;
            break;
        case 79:
            fileId = 6325;
            break;
        case 80:
            fileId = 6324;
            break;
        case 81:
            fileId = 6333;
            break;
        case 82:
            fileId = 6329;
            break;
        case 83:
            fileId = 5914;
            break;
        default:
            fileId = 5916;
            break;
    }

    NSMutableArray *array = [FileTable getCsvWithFileId:fileId];
    if (array == nil) {
        array = [FileTable getCsvWithFileId: 5916];
    }
    return array;
}


@end
