//
//  UtmEfficacyView.h
//  shiseido_finder
//
//  Created by yuki.kiryu on 2016/05/11.
//  Copyright (c) 2016年 株式会社 デーコム. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UtmEfficacyView : UIView<UIScrollViewDelegate>{
    BOOL firstAnimation;
    BOOL isSerum;
}
- (void)showEfficacyDetail;
- (id)initWithFrame:(CGRect)frame;
@property(nonatomic)UIScrollView *scrollView;
@property(nonatomic)UIImageView * utm01;
@property(nonatomic)UIImageView * utm02;
@property(nonatomic)UIImageView * utm03;
@property(nonatomic)UIButton * utmCloseBtn;
@property(nonatomic)BOOL isIBUKI;
@property(nonatomic)BOOL isWhiteLucent;
@property(nonatomic)BOOL isAllDayBright;
@property(nonatomic)BOOL isUtm;
@property(nonatomic)BOOL isUtmEye;
@end
