//
//  UtmTechnologiesView.h
//  shiseido_finder
//
//  Created by yuki.kiryu on 2016/05/10.
//  Copyright (c) 2016年 株式会社 デーコム. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UtmTechnologiesView : UIView<UIScrollViewDelegate>{

    BOOL firstAnimation;
    BOOL isSerum;

}
- (void)showTechnologiesDetail:(BOOL)isUtm;
- (void)showImucalmCompound:(BOOL)isUtm;
- (void)showImucalmArrowEffect:(BOOL)isUtm;
- (id)initWithFrame:(CGRect)frame;
@property(nonatomic)UIScrollView *scrollView;
@property(nonatomic)UIView *contentView;
@property(nonatomic)UIButton * utmCloseBtn;
@property(nonatomic)UIImageView *graph_line;
@property(nonatomic)UIView *graph_lineView;
@property(nonatomic) UIView *starView;
@property(nonatomic) UIView *starViewEye;
@property(nonatomic)NSTimer * starEffectTimer;
@property(nonatomic)NSTimer * starEffectTimerEye;
@property(nonatomic)UIImageView * redlightImgView;
@property(nonatomic)UIImageView * eyeRedLightImgView;
@property(nonatomic)UILabel * eyeRedLabel;
-(void)doAnimation;
-(void)stopTimer;
@end
