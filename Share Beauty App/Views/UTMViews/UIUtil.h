//
//  UIUtil.h
//  shiseido_finder
//
//  Created by DCOM on 2014/02/07.
//  Copyright (c) 2014年 株式会社 デーコム. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
extern const CGFloat kButtonAlphaStateEnabled; ///< ボタン有効時のアルファ値
extern const CGFloat kButtonAlphaStateDisabled; ///< ボタン無効時のアルファ値


/**
 *  UI操作に関するユーティリティ
 */
@interface UIUtil : NSObject



/**
 *  ラベルを生成し、親Viewに追加します。
 *
 *  @param view       親View
 *  @param text       表示テキスト
 *  @param fontSize   フォントサイズ
 *  @param frame      位置、サイズ
 *  @param newLineFlg 改行フラグ（TRUE:改行する　FALSE:改行しない）
 */
+ (void)showLabelText:(UIView *)view text:(NSString *)text fontSize:(NSInteger)fontSize frame:(CGRect)frame newline:(BOOL)newLineFlg;

/**
 *  画面遷移時のアニメーション効果にスライドを設定します。
 *
 *  @param navigationController ナビゲーションコントローラー
 */
+ (void)setTransitionSlide:(UINavigationController *)navigationController;

/**
 *  画面遷移時のアニメーション効果にスライドを設定します。
 *
 *  @param navigationController ナビゲーションコントローラー
 *  @param subtype アニメーションタイプ
 */
+ (void)setTransitionSlide:(UINavigationController *)navigationController from:(NSString *)subtype;

/**
 *  画面遷移時のアニメーション効果にフェードを設定します。
 *
 *  @param navigationController ナビゲーションコントローラー
 */
+ (void)setTransitionFade:(UINavigationController *)navigationController;

/**
 *  資生堂フォント(Light)を返します。
 *
 *  @param fontSize フォントサイズ
 *
 *  @return 資生堂フォント
 */
+ (UIFont *)getShiseidoLight:(CGFloat)fontSize;

/**
 *  資生堂フォント（Bold）を返します。
 *
 *  @param fontSize フォントサイズ
 *
 *  @return 資生堂フォント
 */
+ (UIFont *)getShiseidoBold:(CGFloat)fontSize;

/**
 *  資生堂フォント（ExtraBold）を返します。
 *
 *  @param fontSize フォントサイズ
 *
 *  @return 資生堂フォント
 */
+ (UIFont *)getShiseidoExtraBold:(CGFloat)fontSize;

/**
 *  資生堂フォント（ExtraLight）を返します。
 *
 *  @param fontSize フォントサイズ
 *
 *  @return 資生堂フォント
 */
+ (UIFont *)getShiseidoExtraLight:(CGFloat)fontSize;

/**
 *  Optima Regularフォントを返します。
 *
 *  @param fontSize フォントサイズ
 *
 *  @return Optimaフォント
 */
+ (UIFont *)getOptimaRegular:(CGFloat)fontSize;

/**
 *  スライドアニメーション
 *
 *  @param view     view
 *  @param frame    領域
 *  @param delegate デリゲート
 */
+ (void)slideAnimation:(UIView *)view frame:(CGRect)frame delegate:(id)delegate;

/**
 *  文字の長さをもとにラベルの高さを計算し、返します。
 *
 *  @param labelText 表示文字
 *  @param width     ラベルの幅
 *  @param fontSize  フォントサイズ
 *
 *  @return ラベルの高さ
 */
+ (CGFloat)getLabelHeight:(NSString *)labelText width:(CGFloat)width fontsize:(NSInteger)fontSize;

/**
 *  親Viewの高さを子Viewをもとに計算し、返します。
 *
 *  @param view 親View
 *
 *  @return 高さ
 */
+ (CGFloat)getContentHeight:(UIView *)view;

/**
 *  画像のトリミングを行います。
 *
 *  @param img  トリミングする画像
 *  @param rect トリミングしたい領域
 *
 *  @return トリミングした画像
 */
+ (UIImage *)trimImage:(UIImage *)img rect:(CGRect)rect;

/**
 *  iOSバージョンによって、y座標を変換し返します。
 *
 *  @param height iOS7の場合の高さ
 *
 *  @return
 */
+ (CGFloat)convertPointY:(CGFloat)y;

/**
 *  背景画像を取得します。
 *
 *  @param imageName 画像ファイル名
 *  @param rect      表示領域
 *
 *  @return 画像
 */
+ (UIImage *)getBackGroundImage:(NSString *)imageName rect:(CGRect)rect;

/**
 * @brief Shiseido-Lightxフォントを取得する
 * Shiseido-LightとPostScript名が同一になっている
 * @param [in] fontSize フォントサイズ
 * @return Shiseido-Lightxフォントs
 *
 * @author takafujii
 * @date 2014/06/05
 */
+ (UIFont *)getShiseidoLightx:(CGFloat)fontSize;

+ (UIFont *)getReaderBold:(CGFloat)fontSize;

+ (UIFont *)getSystemBold:(CGFloat)fontSize;

/**
 * @brief グレイ文字色を取得する
 * @return グレイ文字色
 *
 * @author takafujii
 * @date 2014/06/05
 */
+ (UIColor *)grayColor;

/**
 * @brief 赤色文字色を取得する
 * @return 赤色文字色
 *
 * @author takafujii
 * @date 2014/06/05
 */
+ (UIColor *)redColor;

/**
 * @brief 経線用の灰色を取得する
 * @return 灰色
 *
 * @author takafujii
 * @date 2014/06/05
 */
+ (UIColor *)borderLineGrayColor;

/**
 * @brief LineStepの赤色文字色を取得する
 * @return 赤色文字色
 *
 * @author takafujii
 * @date 2014/06/05
 */
+ (UIColor *)lineStepRedColor;

/**
 * @brief LineStepの赤枠の色を取得する
 * @return 赤色文字色
 *
 * @author takafujii
 * @date 2014/06/05
 */
+ (UIColor *)lineStepBorderRedColor;

/**
 * @brief LineStepのグレイの枠色を取得する
 * @return 赤色文字色
 *
 * @author takafujii
 * @date 2014/06/05
 */
+ (UIColor *)lineStepBorderGrayColor;

/**
 * @brief サイドメニューのSettingボタンタップ時のPopOverの背景色
 * @return 灰色
 *
 * @author takafujii
 * @date 2014/06/27
 */
+ (UIColor *)settingViewBgGrayColor;

/**
 * @brief NSStringを指定した条件のNSAttributedStringに変換する
 * @param [in] text 修飾を行いたい元のテキスト
 * @param [in] font フォント
 * @param [in] color テキストカラー
 * @param [in] trackingPt トラッキングの値（pt）
 * @return NSAttributedString
 *
 * @author takafujii
 * @date 2014/06/05
 */
+ (NSAttributedString *)convertStringToAttributedString:(NSString *)text
                                               withFont:(UIFont *)font
                                              withColor:(UIColor *)color
                                           withTracking:(float)trackingPt;

+ (CGSize)attributeStringSize:(NSAttributedString *)string withWidth:(float)width;


+ (BOOL)isiOS7Later;


+ (UIImage *)imageWithColor:(UIColor *)color;

+ (NSMutableArray *)getUtmArray;
+ (NSArray *)get17SSArray;

@end
