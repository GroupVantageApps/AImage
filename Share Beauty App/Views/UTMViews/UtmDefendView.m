//
//  utmDefendView.m
//  shiseido_finder
//
//  Created by yuki.kiryu on 2016/05/11.
//  Copyright (c) 2016年 株式会社 デーコム. All rights reserved.
//

#import "UtmDefendView.h"
//#import "UserDefaultsUtil.h"
#import "UIUtil.h"
#import "StringUtils.h"
//#import "LogManager.h"
#import "NSMutableAttributedString+Additions.h"
@implementation UtmDefendView

@synthesize scrollView;
@synthesize utmDefendViewCloseBtn;


- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.coordinate = [[Coordinate alloc] init];
       
//        UIImageView *imageUtmView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 50)];
//        UIImage *image = [UIImage imageNamed: @"top_shadow"];
//        imageUtmView.image = image;
//        [self addSubview:imageUtmView];
        
        
        NSArray *utmArr = [UIUtil getUtmArray];
        
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width,self.bounds.size.height)];
        scrollView.scrollEnabled = YES;
        [self addSubview:scrollView];
        
//        self.utmDefendViewCloseBtn = [[UIButton alloc]initWithFrame:CGRectMake(23, self.bounds.size.height / 2 - 17, 11, 34)];
//        [self.utmDefendViewCloseBtn setBackgroundImage:[UIImage imageNamed:@"utm_close_btn"] forState:UIControlStateNormal];
//        [self.utmDefendViewCloseBtn setFrame:CGRectMake(23, 267 + 50, 11, 34)];
//        [self addSubview:self.utmDefendViewCloseBtn];
        
        //gb01
        [self showUtmImage:CGRectMake(0, 0, [self.coordinate coordinate:1024], [self.coordinate coordinate:508]) image:@"defend_bg"];
        
        
        //Defend and Regenerate
       CGSize titleLabel =  [self getUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[66]]
                         frame:CGRectMake(30, 29, 300, 55)
                      fontSize:23
                      tracking:0
                    lineHeight:0 red:NO bold:NO];
        
        float x = 30 + titleLabel.width + 30;
        
        [self showUtmImage:CGRectMake(x, 25, 1, 28) image:@"utm_line"];
        
        //Efficacy data for combined use of Ultimune + Moisturizer
        
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[67]]
                         frame:CGRectMake(x + 31, 27, 400, 25)
                      fontSize:14
                      tracking:0
                    lineHeight:0 red:NO bold:NO];
        
        //square
        [self showUtmImage:CGRectMake(62, 117, 17, 17) image:@"utm_square"];
        
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",[self deleteEnter:utmArr[72]]]
                         frame:CGRectMake(62 + 18, 117, 430 - 17, 17)
                      fontSize:13
                      tracking:0
                    lineHeight:0 red:NO bold:YES];
        
        //high
        [self showUtmImage:CGRectMake(72, 241, 11, 28) image:@"defend_triangle"];
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[22]]
                         frame:CGRectMake(62, 273, 29, 17)
                      fontSize:13
                      tracking:0
                    lineHeight:0 red:NO bold:YES];
        
        //Before USE
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[78]]
                         frame:CGRectMake(108, 398, 42, 28)
                      fontSize:13
                      tracking:0
                    lineHeight:0 red:NO bold:NO];
        
        //Moisturizer alone
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[80]]
                         frame:CGRectMake(196, 398, 74, 28)
                      fontSize:13
                      tracking:0
                    lineHeight:0 red:NO bold:NO];
        
        
        //Ultimune and moisturizer
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[82]]
                         frame:CGRectMake(311, 398, 89, 28)
                      fontSize:13
                      tracking:0
                    lineHeight:0 red:NO bold:NO];
        
        
        
        //AMount of ~
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",[self deleteEnter:utmArr[75]]]
                         frame:CGRectMake(93, 450, 167, 22)
                      fontSize:10
                      tracking:0
                    lineHeight:0 red:NO bold:NO];
        
        //After 4 weeks
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"(%@)",utmArr[83]]
                         frame:CGRectMake(356, 447, 116, 12)
                      fontSize:12
                      tracking:0
                    lineHeight:0 red:NO bold:NO];
        
        
        [self showUtmImage:CGRectMake([self.coordinate coordinate:539], 117, 17, 17) image:@"utm_square"];
        
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",[self deleteEnter:utmArr[73]]]
                         frame:CGRectMake([self.coordinate coordinate:539 + 18], 117, 430 - 17, 17)
                      fontSize:13
                      tracking:0
                    lineHeight:0 red:NO bold:YES];
        //high
        [self showUtmImage:CGRectMake([self.coordinate coordinate:543], 241, 11, 28) image:@"defend_triangle"];
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[22]]
                         frame:CGRectMake([self.coordinate coordinate:534], 273, 29, 17)
                      fontSize:13
                      tracking:0
                    lineHeight:0 red:NO bold:YES];
        
        //Before USE
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[78]]
                         frame:CGRectMake([self.coordinate coordinate:589], 398, 42, 28)
                      fontSize:13
                      tracking:0
                    lineHeight:0 red:NO bold:NO];
        
        //Moisturizer alone
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[80]]
                         frame:CGRectMake([self.coordinate coordinate:668], 398, 74, 28)
                      fontSize:13
                      tracking:0
                    lineHeight:0 red:NO bold:NO];
        
        
        //Ultimune and moisturizer
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[82]]
                         frame:CGRectMake([self.coordinate coordinate:784], 398, 89, 28)
                      fontSize:13
                      tracking:0
                    lineHeight:0 red:NO bold:NO];
        
        
        //Strength of barrier function
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",[self deleteEnter:utmArr[85]]]
                         frame:CGRectMake([self.coordinate coordinate:565], 450, 150, 12)
                      fontSize:10
                      tracking:0
                    lineHeight:0 red:NO bold:NO];
        
        //After 4 weeks
        [self showUtmLabelText:[NSString stringWithFormat:@"(%@)",utmArr[83]]
                         frame:CGRectMake([self.coordinate coordinate:824], 447, 116, 13)
                      fontSize:12
                      tracking:0
                    lineHeight:0 red:NO bold:NO];
        
        //Number of participants
        [self showJoitUtmLabelText:68
                               end:69
                             frame:CGRectMake([self.coordinate coordinate:533], 488,  204, 12)
                          fontSize:10
                          tracking:0
                        lineHeight:0
                             enter:YES];
        
        //Ethnicity / Age
        [self showJoitUtmLabelText:70
                               end:71
                             frame:CGRectMake([self.coordinate coordinate:727], 488, 300, 12)
                          fontSize:10
                          tracking:0
                        lineHeight:0
                             enter:YES];
        [scrollView setContentSize:CGSizeMake(self.bounds.size.width,508)];
    }
    
    return self;
}
- (void)showDefendDetail:(NSInteger)productId{
}

-(NSString *)deleteEnter:(NSString *)text{
    
    NSString * enter = @"\n";

    text = [text stringByReplacingOccurrencesOfString:enter withString:@""];
    
    return text;
}

-(void)showUtmImage:(CGRect)frame
              image:(NSString *)name{
    
    UIImageView *imageUtmView = [[UIImageView alloc]initWithFrame:frame];
    UIImage *image = [UIImage imageNamed:name];
    imageUtmView.image = image;
    [scrollView addSubview:imageUtmView];
    
    
}



- (void)showUtmLabelTextCenter:(NSString *)text
                   frame:(CGRect)frame
                fontSize:(CGFloat)fontSize
                tracking:(CGFloat)tracking
              lineHeight:(CGFloat)lineHeight
                     red:(BOOL)redCheck
                    bold:(BOOL)boldCheck{
    NSLog(@"%@",text);
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]
                                          initWithString:[StringUtils nullToEmpty:text]];
    
    if (boldCheck) {
        [attrStr setFont:[UIUtil getReaderMedium:fontSize]];
    }else{
        [attrStr setFont:[UIUtil getReaderMedium:fontSize]];
    }
    
    if (redCheck) {
        [attrStr setTextColor:[UIUtil redColor]];
    }else{
        [attrStr setTextColor:[UIUtil grayColor]];
    }
    
    if(tracking > 0){
        [attrStr setTracking:tracking];
    }
    if(lineHeight > 0){
        [attrStr setLineHeight:lineHeight];
    }
    
    CGRect labelFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    UILabel *lbl = [[UILabel alloc]initWithFrame:labelFrame];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setAttributedText:attrStr];
    [lbl setNumberOfLines:0];
   [lbl setTextAlignment:NSTextAlignmentCenter];
    //    [lbl sizeToFit];
    lbl.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:lbl];
    
    //    return lbl.frame.size;
}

- (void)showUtmLabelText:(NSString *)text
                   frame:(CGRect)frame
                fontSize:(CGFloat)fontSize
                tracking:(CGFloat)tracking
              lineHeight:(CGFloat)lineHeight
                     red:(BOOL)redCheck
                    bold:(BOOL)boldCheck{
    NSLog(@"%@",text);
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]
                                          initWithString:[StringUtils nullToEmpty:text]];
    
    if (boldCheck) {
        [attrStr setFont:[UIUtil getReaderMedium:fontSize]];
    }else{
        [attrStr setFont:[UIUtil getReaderMedium:fontSize]];
    }
    
    if (redCheck) {
        [attrStr setTextColor:[UIUtil redColor]];
    }else{
        [attrStr setTextColor:[UIUtil grayColor]];
    }
    
    if(tracking > 0){
        [attrStr setTracking:tracking];
    }
    if(lineHeight > 0){
        [attrStr setLineHeight:lineHeight];
    }
    
    CGRect labelFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    UILabel *lbl = [[UILabel alloc]initWithFrame:labelFrame];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setAttributedText:attrStr];
    [lbl setNumberOfLines:0];
     //   [lbl setTextAlignment:NSTextAlignmentCenter];
    //    [lbl sizeToFit];
    lbl.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:lbl];
    
    //    return lbl.frame.size;
}
- (CGSize)getUtmLabelText:(NSString *)text
                   frame:(CGRect)frame
                fontSize:(CGFloat)fontSize
                tracking:(CGFloat)tracking
              lineHeight:(CGFloat)lineHeight
                     red:(BOOL)redCheck
                    bold:(BOOL)boldCheck{
    NSLog(@"%@",text);
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]
                                          initWithString:[StringUtils nullToEmpty:text]];
    
    if (boldCheck) {
        [attrStr setFont:[UIUtil getReaderMedium:fontSize]];
    }else{
        [attrStr setFont:[UIUtil getReaderMedium:fontSize]];
    }
    
    if (redCheck) {
        [attrStr setTextColor:[UIUtil redColor]];
    }else{
        [attrStr setTextColor:[UIUtil grayColor]];
    }
    
    if(tracking > 0){
        [attrStr setTracking:tracking];
    }
    if(lineHeight > 0){
        [attrStr setLineHeight:lineHeight];
    }
    
    CGRect labelFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    UILabel *lbl = [[UILabel alloc]initWithFrame:labelFrame];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setAttributedText:attrStr];
    [lbl setNumberOfLines:0];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [lbl sizeToFit];
    lbl.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:lbl];
    
    return lbl.frame.size;
}


- (void)showJoitUtmLabelText:(int)start
                         end:(int)end
                       frame:(CGRect)frame
                    fontSize:(CGFloat)fontSize
                    tracking:(CGFloat)tracking
                  lineHeight:(CGFloat)lineHeight
                       enter:(BOOL)enterCheck{

    NSArray *utmArr = [UIUtil getUtmArray];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",utmArr[start]]];
    
    
    
    int rimit = end - start;
    for (int i = 0; i < rimit ; i++) {
        
        if (enterCheck) {
            NSMutableAttributedString *joint =  [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@": %@",[NSString stringWithFormat:@"%@",[self deleteEnter:utmArr[start + i + 1]]]]];
            [attrStr appendAttributedString:joint];
        }else{
            NSMutableAttributedString *joint =  [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",utmArr[start + i + 1]]];
            [attrStr appendAttributedString:joint];
        }
    }
   ;
    [attrStr setFont:[UIUtil getReaderMedium:fontSize]];
    [attrStr setTextColor:[UIUtil grayColor]];
    
    if(tracking > 0){
        [attrStr setTracking:tracking];
    }
    if(lineHeight > 0){
        [attrStr setLineHeight:lineHeight];
    }
    
    CGRect labelFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    UILabel *lbl = [[UILabel alloc]initWithFrame:labelFrame];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setAttributedText:attrStr];
    [lbl setNumberOfLines:0];
    //    [lbl setTextAlignment:NSTextAlignmentCenter];
    //    [lbl sizeToFit];
    lbl.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:lbl];
    


}

- (void)didMoveToSuperview{
    
    [super didMoveToSuperview];
    [self doAnimation];

}
-(void)doAnimation{
    
    // graph image
    UIView *graphLineView = [[UIView alloc]initWithFrame:CGRectMake(98 , 390, 0, 0)];
    graphLineView.clipsToBounds = YES;
    [scrollView addSubview:graphLineView];
    UIImageView * graphLineImgView= [[UIImageView alloc]initWithFrame:CGRectMake(1,- 148 , 343, 148)];
    UIImage * graph_line_img = [UIImage imageNamed:@"d_graph_line"];
    graphLineImgView.image = graph_line_img;
    [graphLineView addSubview:graphLineImgView];
    
    [UIView animateWithDuration:0.5f
                          delay:0.2f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         graphLineView.frame = CGRectMake(98, 390 - 148 , 343, 148);
                         graphLineImgView.frame = CGRectMake(0, 0 , 343, 148);
                         
                     }
                     completion:^(BOOL finished){
                    
                     }];
    
    float duration = 0.5;
    
    UIImageView * firstRedLightImgView = [[UIImageView alloc]initWithFrame:CGRectMake(135, 148, 415, 240)];
    UIImage * firstRedLightImg = [UIImage imageNamed:@"effect_redlight"];
    firstRedLightImgView.image = firstRedLightImg;
    firstRedLightImgView.alpha = 0;
    [scrollView addSubview:firstRedLightImgView];
    
    //星用のView
    self.fStarView = [[UIView alloc]initWithFrame:CGRectMake(250, 200, 216, 135)];
    [scrollView addSubview:self.fStarView];
    
    
    float firstGrayGraph = [self drawUpAnimation:@"d_block_3_5s"
                                           frame:CGRectMake(210, 388, 47, 80)
                                        duration:duration
                                           delay:0.7];
   
    float firstRedGraph = [self drawUpAnimation:@"d_block_3_5m"
                                          frame:CGRectMake(315, 388, 47, 180)
                                       duration:0.5
                                          delay:firstGrayGraph];
    
    
    [self drawAlphaAnimation:@"t1_utm" frame:CGRectMake(300 , 184 , 148, 252) duration:duration delay:firstRedGraph];
    
    
    [UIView animateWithDuration:duration
                          delay:firstRedGraph
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         firstRedLightImgView.alpha = 1;
                     }
                     completion:^(BOOL finished){
                         
                     }];

    
    
    float firstArrowView = [self drawUpAnimation:@"d_arrow_3_5"
                                           frame:CGRectMake(254, 313, 60, 100)
                                        duration:duration
                                           delay:firstRedGraph];

    //二つ目のグラフアニメーション
    int margin_x = [self.coordinate coordinate:474];

    // graph image
    UIView *sGraphLineView = [[UIView alloc]initWithFrame:CGRectMake([self.coordinate coordinate:98] + margin_x, 390, 0, 0)];
    sGraphLineView.clipsToBounds = YES;
    [scrollView addSubview:sGraphLineView];
    UIImageView * sGraphLineImgView= [[UIImageView alloc]initWithFrame:CGRectMake(1,- 148 , 343, 148)];
    UIImage * s_graph_line_img = [UIImage imageNamed:@"d_graph_line"];
    sGraphLineImgView.image = s_graph_line_img;
    [sGraphLineView addSubview:sGraphLineImgView];
    
    [UIView animateWithDuration:0.5f
                          delay:firstArrowView
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         sGraphLineView.frame = CGRectMake([self.coordinate coordinate:98] + margin_x, 390 - 148 , 343, 148);
                         sGraphLineImgView.frame = CGRectMake(0, 0 , 343, 148);
                         
                     }completion:^(BOOL finished){
                     
                        
                     }];
    
    
    
  
    UIImageView * sRedLightImgView = [[UIImageView alloc]initWithFrame:CGRectMake([self.coordinate coordinate:135] + margin_x, 148, 415, 240)];
    UIImage * sRedLightImg = [UIImage imageNamed:@"effect_redlight"];
    sRedLightImgView.image = sRedLightImg;
    sRedLightImgView.alpha = 0;
    [scrollView addSubview:sRedLightImgView];
    
    //星用のView
    self.sStarView = [[UIView alloc]initWithFrame:CGRectMake([self.coordinate coordinate:250]+ margin_x, 200, 216, 135)];
    [scrollView addSubview:self.sStarView];
    
    
    float sGrayGraph = [self drawUpAnimation:@"d_block_2s"
                                           frame:CGRectMake([self.coordinate coordinate:210] + margin_x, 387, 47, 85)
                                        duration:duration
                                           delay:firstArrowView + duration];
    
    float sRedGraph = [self drawUpAnimation:@"d_block_2m"
                                          frame:CGRectMake([self.coordinate coordinate:315] + margin_x, 387, 47, 180)
                                       duration:0.5
                                          delay:sGrayGraph];
    
    
    [self drawAlphaAnimation:@"t1_utm" frame:CGRectMake([self.coordinate coordinate:300] + margin_x, 184  , 148, 252) duration:duration delay:sRedGraph];
    
    
    [UIView animateWithDuration:duration
                          delay:sRedGraph
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         sRedLightImgView.alpha = 1;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    
    
    float sArrowView = [self drawUpAnimation:@"d_arrow_2"
                                           frame:CGRectMake([self.coordinate coordinate:254] + margin_x, 300, 60, 87)
                                        duration:duration
                                           delay:sRedGraph];
 
    NSArray *utmArr = [UIUtil getUtmArray];
    
    [self modifyStr:[NSString stringWithFormat:@"%@",utmArr[76]] delay:sArrowView];
    
    [self modifyStr:[NSString stringWithFormat:@"%@",utmArr[86]] delay:sArrowView];
    
    if (self.superview) {
        [NSTimer scheduledTimerWithTimeInterval:sArrowView target:self selector:@selector(startTimer) userInfo:nil repeats:NO
         ];
    }
    
    
}

-(void)startTimer{
    
    if (self.superview) {
        self.starEffectTimer =
        [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(addStarEffect:) userInfo:nil repeats:YES
         ];
    }


}

-(void)addEffect:(UIView*)view{
    
    // アニメーションの初期化　アニメーションのキーパスを"transform"にする
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    // 回転の開始と終わりの角度を設定　単位はラジアン
    anim.fromValue = [NSNumber numberWithDouble:0];
    anim.toValue = [NSNumber numberWithDouble:2 * M_PI];
    
    // 回転軸の設定
    anim.valueFunction = [CAValueFunction functionWithName:kCAValueFunctionRotateZ];
    
    
    
    CABasicAnimation *fadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    fadeIn.fromValue = @1;
    fadeIn.toValue   = @0.1;
    fadeIn.duration = 1;
    
    CABasicAnimation *fadeOut = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    fadeOut.fromValue = @0.1;
    fadeOut.toValue   = @1;
    fadeOut.beginTime = 1;
    fadeOut.duration = 1;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    group.duration = 2;
    group.repeatCount = HUGE_VALF;
    group.timingFunction  =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.animations = @[
                         fadeIn,
                         fadeOut,
                         anim,
                         ];
    
    
    
    // アニメーションをレイヤーにセット
    [view.layer addAnimation:group forKey:nil];
    
    
}


-(float)drawUpAnimation:(NSString*)imgName frame:(CGRect)frame duration:(float)duration delay:(float)delay{

    int x = frame.origin.x;
    int y = frame.origin.y;
    int w = frame.size.width;
    int h = frame.size.height;
    
    UIView * baseView = [[UIView alloc]initWithFrame:CGRectMake(x , y , w, 0)];
    baseView.clipsToBounds = YES;
    [scrollView addSubview:baseView];
    UIImageView *baseImgView= [[UIImageView alloc]initWithFrame:CGRectMake(0, -h , w, h)];
    UIImage *  baseImg = [UIImage imageNamed:imgName];
    baseImgView.image = baseImg;
    [baseView addSubview:baseImgView];
    
    
    [UIView animateWithDuration:duration
                          delay:delay
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         baseView.frame = CGRectMake(x , y - h, w, h);
                         baseImgView.frame = CGRectMake(0 , 0, w, h);
                         
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    return duration + delay;

}

-(float)drawAlphaAnimation:(NSString*)imgName frame:(CGRect)frame duration:(float)duration delay:(float)delay{

    int x = frame.origin.x;
    int y = frame.origin.y;
    int w = frame.size.width;
    int h = frame.size.height;
    
    UIImageView *baseImgView= [[UIImageView alloc]initWithFrame:CGRectMake(x, y , w, h)];
    UIImage *  baseImg = [UIImage imageNamed:imgName];
    baseImgView.image = baseImg;
    baseImgView.alpha = 0;
    [scrollView addSubview:baseImgView];
    
    
    [UIView animateWithDuration:duration
                          delay:delay
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         baseImgView.alpha = 1;
                         
                     }
                     completion:^(BOOL finished){

                         
                     }];

    return duration + delay;
}

-(void)addStarEffect:(NSTimer*)timer{
    
    
    
    int x = random()%216 + 1;
    int y = random()%135 + 1;
    int size = random()%10 + 5;
    
    UIImageView * star = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, size, size)];
    star.image = [UIImage imageNamed:@"t_star"];
    star.alpha = 0;
    [self.fStarView addSubview:star];
    
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         star.alpha = 1;
                         
                     }
                     completion:^(BOOL finished){
                         //アニメーションが終了したときの処理
                         //                         NSLog(@"終了1");
                         
                         //alphaアニメーションスタート
                         [UIView animateWithDuration:0.5f
                                          animations:^{
                                              
                                              star.alpha = 0;
                                              
                                          }
                                          completion:^(BOOL finished){
                                              //アニメーションが終了したときの処理
                                              [star removeFromSuperview];
                                          }];
                         
                     }];

    
    UIImageView * s_star = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, size, size)];
    s_star.image = [UIImage imageNamed:@"t_star"];
    s_star.alpha = 0;
    [self.sStarView addSubview:s_star];
    
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         s_star.alpha = 1;
                         
                     }
                     completion:^(BOOL finished){
                         //アニメーションが終了したときの処理
                         
                         //alphaアニメーションスタート
                         [UIView animateWithDuration:0.5f
                                          animations:^{
                                              
                                              s_star.alpha = 0;
                                              
                                          }
                                          completion:^(BOOL finished){
                                              //アニメーションが終了したときの処理
                                              [s_star removeFromSuperview];
                                              
                                          }];
                         
                     }];

}


-(void)addWaterAnimation:(CGRect)frame delay:(float)delay image:(UIView *)image
{
    //しずるアニメーション
    
    int x = frame.origin.x;
    int y = frame.origin.y;
    int w = frame.size.width;
    int h = frame.size.height;
    

    UIImageView * effect_bg = [[UIImageView alloc]initWithFrame:CGRectMake(x + w*0.5, y + h*0.5, 0, 0)];
    effect_bg.image = [UIImage imageNamed:@"sizle_base"];
    [scrollView addSubview:effect_bg];

    image.alpha = 0;
    [scrollView addSubview:image];
    
    
    

    [UIView animateWithDuration:1.0f
                          delay:delay
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         [effect_bg setFrame:CGRectMake(x, y, w, h)];
                         
                     }
                     completion:^(BOOL finished){

                         //alphaアニメーションスタート
                         [UIView animateWithDuration:1.0f
                                          animations:^{
                                              
                                              image.alpha = 1;
                                              
                                          }
                                          completion:^(BOOL finished){
                                              //アニメーションが終了したときの処理
                                              
                                              UIImageView * effect_highlight = [[UIImageView alloc]initWithFrame:CGRectMake(x , y , w, h)];
                                              effect_highlight.image = [UIImage imageNamed:@"sizle_highlight"];
                                              [scrollView addSubview:effect_highlight];
                                              [self addEffect:effect_highlight];
                                              
                                              
                                          }];
                         
                     }];
    
    



}
-(void)modifyStr:(NSString *)str delay:(float)delay{

    NSRange found = [str rangeOfString:@"3.5" options:NSLiteralSearch];
    NSString * string_left = @"";
    NSString * string_right = @"";
    
    if (found.location != NSNotFound)
    {

        string_left = [str substringToIndex:found.location];
        string_right = [str substringFromIndex:found.location + found.length];
        
        
        if (![string_left isEqualToString:@""] && ![string_left isEqualToString:@""]) {
            
            string_left =  [string_left stringByReplacingOccurrencesOfString:@" " withString:@""];
            string_right =  [string_right stringByReplacingOccurrencesOfString:@" " withString:@""];

            NSMutableAttributedString *attrStr_left = [[NSMutableAttributedString alloc]
                                                  initWithString:[StringUtils nullToEmpty:[NSString stringWithFormat:@"%@",string_left]]];
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]
                                                  initWithString:[StringUtils nullToEmpty:@"3.5"]];
            
            NSMutableAttributedString *attrStr_right = [[NSMutableAttributedString alloc]
                                                  initWithString:[StringUtils nullToEmpty:string_right]];

            [attrStr_left setFont:[UIUtil getReaderMedium:17]];
            [attrStr_left setTextColor:[UIUtil redColor]];
            [attrStr setFont:[UIUtil getReaderMedium:55]];
            [attrStr setTextColor:[UIUtil redColor]];
            [attrStr_right setFont:[UIUtil getReaderMedium:17]];
            [attrStr_right setTextColor:[UIUtil redColor]];
            
            CGRect viewFrame = CGRectMake(135, 145, 130, 130);
            UIView * view = [[UIView alloc]initWithFrame:viewFrame];
            
            CGRect labelFrame_1 = CGRectMake(0, 23, 130, 20);
            UILabel *lbl = [[UILabel alloc]initWithFrame:labelFrame_1];
            [lbl setBackgroundColor:[UIColor clearColor]];
            [lbl setAttributedText:attrStr_left];
            [lbl setNumberOfLines:0];
            lbl.textAlignment = NSTextAlignmentCenter;
            lbl.adjustsFontSizeToFitWidth = YES;
            [view addSubview:lbl];

            CGRect labelFrame_2 = CGRectMake(0, 15 + lbl.frame.size.height, 130, 70);
            UILabel *lbl_2 = [[UILabel alloc]initWithFrame:labelFrame_2];
            [lbl_2 setBackgroundColor:[UIColor clearColor]];
            [lbl_2 setAttributedText:attrStr];
            [lbl_2 setNumberOfLines:0];
            lbl_2.textAlignment = NSTextAlignmentCenter;
            lbl_2.adjustsFontSizeToFitWidth = YES;
            [view addSubview:lbl_2];
            
            CGRect labelFrame_3 = CGRectMake(0, 5 + lbl.frame.size.height + lbl_2.frame.size.height, 130, 20);
            UILabel *lbl_3 = [[UILabel alloc]initWithFrame:labelFrame_3];
            [lbl_3 setBackgroundColor:[UIColor clearColor]];
            [lbl_3 setAttributedText:attrStr_right];
            [lbl_3 setNumberOfLines:0];
            lbl_3.textAlignment = NSTextAlignmentCenter;
            lbl_3.adjustsFontSizeToFitWidth = YES;
            [view addSubview:lbl_3];
            
             [self addWaterAnimation:CGRectMake(135, 145, 130, 130) delay:delay image:view];
            
        }else if ([string_left isEqualToString:@""]){
        
            string_right =  [string_right stringByReplacingOccurrencesOfString:@" " withString:@"\n"];

            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]
                                                  initWithString:[StringUtils nullToEmpty:@"3.5"]];
            
            NSMutableAttributedString *attrStr_right = [[NSMutableAttributedString alloc]
                                                        initWithString:[StringUtils nullToEmpty:string_right]];
            
            [attrStr setFont:[UIUtil getReaderMedium:55]];
            [attrStr setTextColor:[UIUtil redColor]];
            [attrStr_right setFont:[UIUtil getReaderMedium:17]];
            [attrStr_right setTextColor:[UIUtil redColor]];
            
            CGRect viewFrame = CGRectMake(135, 145, 130, 130);
            UIView * view = [[UIView alloc]initWithFrame:viewFrame];
            
        
            CGRect labelFrame_2 = CGRectMake(0, 15 , 130, 70);
            UILabel *lbl_2 = [[UILabel alloc]initWithFrame:labelFrame_2];
            [lbl_2 setBackgroundColor:[UIColor clearColor]];
            [lbl_2 setAttributedText:attrStr];
            [lbl_2 setNumberOfLines:0];
            lbl_2.textAlignment = NSTextAlignmentCenter;
            lbl_2.adjustsFontSizeToFitWidth = YES;
            [view addSubview:lbl_2];
            
            CGRect labelFrame_3 = CGRectMake(0,  lbl_2.frame.size.height -15, 130, 60);
            UILabel *lbl_3 = [[UILabel alloc]initWithFrame:labelFrame_3];
            [lbl_3 setBackgroundColor:[UIColor clearColor]];
            [lbl_3 setAttributedText:attrStr_right];
            [lbl_3 setNumberOfLines:0];
            lbl_3.textAlignment = NSTextAlignmentCenter;
            lbl_3.adjustsFontSizeToFitWidth = YES;
            [view addSubview:lbl_3];
        
                  [self addWaterAnimation:CGRectMake(135, 145, 130, 130) delay:delay image:view];
        }
        
    }
    
    
    NSRange found_2 = [str rangeOfString:@"2" options:NSLiteralSearch];
    NSString * string_left_2 = @"";
    NSString * string_right_2 = @"";
    
    
    if (found_2.location != NSNotFound)
    {
        string_left_2 = [str substringToIndex:found_2.location];
        string_right_2 = [str substringFromIndex:found_2.location + found_2.length];
        int margin_x = [self.coordinate coordinate:474];
        
        if (![string_left_2 isEqualToString:@""] && ![string_right_2 isEqualToString:@""]) {
            string_left_2 =  [string_left_2 stringByReplacingOccurrencesOfString:@" " withString:@""];
            string_right_2 =  [string_right_2 stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            NSMutableAttributedString *attrStr_left = [[NSMutableAttributedString alloc]
                                                       initWithString:[StringUtils nullToEmpty:[NSString stringWithFormat:@"%@",string_left_2]]];
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]
                                                  initWithString:[StringUtils nullToEmpty:@"2"]];
            
            NSMutableAttributedString *attrStr_right = [[NSMutableAttributedString alloc]
                                                        initWithString:[StringUtils nullToEmpty:string_right_2]];
            
            [attrStr_left setFont:[UIUtil getReaderMedium:17]];
            [attrStr_left setTextColor:[UIUtil redColor]];
            [attrStr setFont:[UIUtil getReaderMedium:55]];
            [attrStr setTextColor:[UIUtil redColor]];
            [attrStr_right setFont:[UIUtil getReaderMedium:17]];
            [attrStr_right setTextColor:[UIUtil redColor]];
            
            CGRect viewFrame = CGRectMake([self.coordinate coordinate:135] + margin_x, 145, 130, 130);
            UIView * view = [[UIView alloc]initWithFrame:viewFrame];
            
            CGRect labelFrame_1 = CGRectMake(0, 23, 130, 20);
            UILabel *lbl = [[UILabel alloc]initWithFrame:labelFrame_1];
            [lbl setBackgroundColor:[UIColor clearColor]];
            [lbl setAttributedText:attrStr_left];
            [lbl setNumberOfLines:0];
            lbl.textAlignment = NSTextAlignmentCenter;
            lbl.adjustsFontSizeToFitWidth = YES;
            [view addSubview:lbl];
            
            CGRect labelFrame_2 = CGRectMake(0, 15 + lbl.frame.size.height, 130, 70);
            UILabel *lbl_2 = [[UILabel alloc]initWithFrame:labelFrame_2];
            [lbl_2 setBackgroundColor:[UIColor clearColor]];
            [lbl_2 setAttributedText:attrStr];
            [lbl_2 setNumberOfLines:0];
            lbl_2.textAlignment = NSTextAlignmentCenter;
            lbl_2.adjustsFontSizeToFitWidth = YES;
            [view addSubview:lbl_2];
            
            CGRect labelFrame_3 = CGRectMake(0, 5 + lbl.frame.size.height + lbl_2.frame.size.height, 130, 20);
            UILabel *lbl_3 = [[UILabel alloc]initWithFrame:labelFrame_3];
            [lbl_3 setBackgroundColor:[UIColor clearColor]];
            [lbl_3 setAttributedText:attrStr_right];
            [lbl_3 setNumberOfLines:0];
            lbl_3.textAlignment = NSTextAlignmentCenter;
            lbl_3.adjustsFontSizeToFitWidth = YES;
            [view addSubview:lbl_3];
            
             [self addWaterAnimation:CGRectMake([self.coordinate coordinate:135] + margin_x, 145, 130, 130) delay:delay image:view];
           
        }else if ([string_left_2 isEqualToString:@""]){
            string_right_2 =  [string_right_2 stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
            
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]
                                                  initWithString:[StringUtils nullToEmpty:@"2"]];
            
            NSMutableAttributedString *attrStr_right = [[NSMutableAttributedString alloc]
                                                        initWithString:[StringUtils nullToEmpty:string_right_2]];
            
            [attrStr setFont:[UIUtil getReaderMedium:55
                              ]];
            [attrStr setTextColor:[UIUtil redColor]];
            [attrStr_right setFont:[UIUtil getReaderMedium:17]];
            [attrStr_right setTextColor:[UIUtil redColor]];
            
            CGRect viewFrame = CGRectMake([self.coordinate coordinate:135] + margin_x, 145, 130, 130);
            UIView * view = [[UIView alloc]initWithFrame:viewFrame];
            
            
            CGRect labelFrame_2 = CGRectMake(0, 15 , 130, 70);
            UILabel *lbl_2 = [[UILabel alloc]initWithFrame:labelFrame_2];
            [lbl_2 setBackgroundColor:[UIColor clearColor]];
            [lbl_2 setAttributedText:attrStr];
            [lbl_2 setNumberOfLines:0];
            lbl_2.textAlignment = NSTextAlignmentCenter;
            lbl_2.adjustsFontSizeToFitWidth = YES;
            [view addSubview:lbl_2];
            
            CGRect labelFrame_3 = CGRectMake(0,  lbl_2.frame.size.height -15, 130, 60);
            UILabel *lbl_3 = [[UILabel alloc]initWithFrame:labelFrame_3];
            [lbl_3 setBackgroundColor:[UIColor clearColor]];
            [lbl_3 setAttributedText:attrStr_right];
            [lbl_3 setNumberOfLines:0];
            lbl_3.textAlignment = NSTextAlignmentCenter;
            lbl_3.adjustsFontSizeToFitWidth = YES;
            [view addSubview:lbl_3];
            
//            [scrollView addSubview:view];
            
  
            [self addWaterAnimation:CGRectMake([self.coordinate coordinate:135] + margin_x, 145, 130, 130) delay:delay image:view];
        }
    
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)stopTimer{
    
    if ([self.starEffectTimer isValid]) {
        [self.starEffectTimer invalidate];
    }else{
    }
    
}
@end
