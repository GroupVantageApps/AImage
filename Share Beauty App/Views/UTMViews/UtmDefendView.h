//
//  utmDefendView.h
//  shiseido_finder
//
//  Created by yuki.kiryu on 2016/05/11.
//  Copyright (c) 2016年 株式会社 デーコム. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Coordinate.h"

@protocol UtmDefendViewDelegate <NSObject>
@end

@interface UtmDefendView : UIView
@property (nonatomic, weak) id <UtmDefendViewDelegate> delegate;
- (void)showDefendDetail:(NSInteger)productId;
- (id)initWithFrame:(CGRect)frame;
@property(nonatomic)UIScrollView *scrollView;
@property(nonatomic)UIButton * utmDefendViewCloseBtn;
@property(nonatomic)UIView * fStarView;
@property(nonatomic)UIView * sStarView;
@property(nonatomic)NSTimer * starEffectTimer;
@property(nonatomic)Coordinate * coordinate;
-(void)stopTimer;
@end
