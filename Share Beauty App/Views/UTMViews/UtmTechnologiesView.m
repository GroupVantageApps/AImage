//
//  UtmTechnologiesView.m
//  shiseido_finder
//
//  Created by yuki.kiryu on 2016/05/10.
//  Copyright (c) 2016年 株式会社 デーコム. All rights reserved.
//

#import "UtmTechnologiesView.h"
//#import "UserDefaultsUtil.h"
#import "UIUtil.h"
#import "StringUtils.h"
#import "NSMutableAttributedString+Additions.h"
//#import "DBUtil.h"
#import "QuartzCore/QuartzCore.h"
//#import "LogManager.h"

@implementation UtmTechnologiesView

@synthesize scrollView;


- (id)initWithFrame:(CGRect)frame
{
        NSLog(@"initWithFrame");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)showTechnologiesDetail:(BOOL)isUtm{
    firstAnimation = YES;
    NSLog(@"showTechnologiesDetail");
//    UIImageView *imageUtmView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 50)];
//    UIImage *image = [UIImage imageNamed: @"top_shadow"];
//    imageUtmView.image = image;
//    [self addSubview:imageUtmView];
    
//       NSLog(@"productId:%ld",(long)productId);
    
    NSArray *utmArr = [UIUtil getUtmArray];


    [self setBackgroundColor:[UIColor whiteColor]];
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width,self.bounds.size.height)];
    scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
    [self addSubview:scrollView];

//    self.utmCloseBtn = [[UIButton alloc]initWithFrame:CGRectMake(23, self.bounds.size.height / 2 - 17, 11, 34)];
//    [self.utmCloseBtn setBackgroundImage:[UIImage imageNamed:@"utm_close_btn"] forState:UIControlStateNormal];
//    [self addSubview:self.utmCloseBtn];
    
    //gb01
    [self showUtmImage:CGRectMake(self.bounds.size.width - 602, 7, 602, 507) image:@"utm_bg_01"];

    //Technologies
   CGSize titleLabel =  [self getUtmLabelSize:[NSString stringWithFormat:@"%@",utmArr[7]]
                     frame:CGRectMake(30, 29, 200, 30)
                  fontSize:23
                  tracking:0
                lineHeight:29 red:NO bold:NO];
    
     float x = 30 + titleLabel.width + 30;
    
    //utm line
    [self showUtmImage:CGRectMake(x, 25, 1, 70) image:@"utm_line"];
    
    
    //Ultimune Complex
    [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[14]]
                     frame:CGRectMake(x + 31 , 29, 400, 25)
                  fontSize:17
                  tracking:0
                lineHeight:20 red:YES bold:NO];
    
    
    [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[15]]
                     frame:CGRectMake(x + 31 , 60, 588, 38)
                  fontSize:14
                  tracking:0
                lineHeight:18 red:NO bold:NO];
    
    
    // graph image
    self.graph_lineView = [[UIView alloc]initWithFrame:CGRectMake(185 , 160 -53 + 332, 0, 0)];
    self.graph_lineView.clipsToBounds = YES;
    [scrollView addSubview:self.graph_lineView];
    self.graph_line= [[UIImageView alloc]initWithFrame:CGRectMake(1,-332 , 587, 332)];
    UIImage * graph_line_img = [UIImage imageNamed:@"graph_line"];
    self.graph_line.image = graph_line_img;
    [self.graph_lineView addSubview:self.graph_line];


    
    //赤いeffect用
    self.redlightImgView= [[UIImageView alloc]initWithFrame:CGRectMake(179, 100 ,600, 338)];
    UIImage * redlightImg = [UIImage imageNamed:@"t_effect_redlight"];
    self.redlightImgView.image = redlightImg;
    self.redlightImgView.alpha = 0;
    [scrollView addSubview:self.redlightImgView];
    
    
    //square
    [self showUtmImage:CGRectMake(143, 128, 17, 17) image:@"utm_square"];
    
    [self showJoitUtmLabelText:20
                           end:21
                         frame:CGRectMake(143 + 18, 128, 660 - 17, 18)
                      fontSize:14
                      tracking:0
                    lineHeight:0
                         enter:NO];
       //high
    [self showUtmImage:CGRectMake(157, 200, 14, 32) image:@"high"];
    [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[22]]
                     frame:CGRectMake(144, 238, 40, 21)
                  fontSize:17
                  tracking:0
                lineHeight:0 red:NO bold:YES];
    
    //100%
    [self showUtmLabelText:[NSString stringWithFormat:@"100%%"]
                     frame:CGRectMake(140, 306, 50, 18)
                  fontSize:17
                  tracking:0
                lineHeight:0 red:NO bold:YES];
    
    
    //Function of~
    [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[25]]
                     frame:CGRectMake(68, 444, 117, 35)
                  fontSize:9
                  tracking:0
                lineHeight:0 red:NO bold:NO];

    
    //Without ~
    [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[27]]
                     frame:CGRectMake(227, 450, 121, 30)
                  fontSize:14
                  tracking:0
                lineHeight:0 red:NO bold:NO];
    
    //With ~
    [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[29]]
                     frame:CGRectMake(400, 450, 121, 30)
                  fontSize:14
                  tracking:0
                lineHeight:0 red:NO bold:NO];
    
    [self showUtmImage:CGRectMake(630, 250, 228, 210) image:@"triangle_image"];
    
    [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[14]]
                     frame:CGRectMake(709, 347, 69, 33)
                  fontSize:12
                  tracking:0
                lineHeight:0 red:YES bold:NO];
    
    [self showUtmImage:CGRectMake(self.bounds.size.width * 0.5 - 885 * 0.5, 506, 885, 12) image:@"bottom_line"];

    
//    DBUtil *dbUtil = [[DBUtil alloc]init];
//    NSLog(@"productId:%ld",(long)productId);
//    NSDictionary *product = [dbUtil getProduct:productId];
    
//    NSString * gcode = [product objectForKey:@"gcode"];
    
    if(isUtm){
//        [LogManager setValue:@"utm_tech_1"];
        isSerum = YES;
        
        //ここから二つ目のview
        int firstViewheight = 502;
        
        //gb02
        [self showUtmImage:CGRectMake(0,firstViewheight + 83, self.bounds.size.width, 383) image:@"utm_bg_02"];
        
        //Technologies
        CGSize titleLabel =  [self getUtmLabelSize:[NSString stringWithFormat:@"%@",utmArr[7]]
                         frame:CGRectMake(30, firstViewheight + 29, 200, 30)
                      fontSize:23
                      tracking:0
                    lineHeight:29 red:NO bold:NO];
        
        float x = 30 + titleLabel.width + 30;
        
        //utm line
        [self showUtmImage:CGRectMake(x, firstViewheight + 25, 1, 26) image:@"utm_line"];
        
        
        //ImuCalm Compound™
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[31]]
                         frame:CGRectMake( x + 31, firstViewheight + 29, 400, 25)
                      fontSize:17
                      tracking:0
                    lineHeight:0 red:YES bold:NO];
        
  
        //RELAXED
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[33]]
                         frame:CGRectMake( 275, firstViewheight + 98, 98, 29)
                      fontSize:23
                      tracking:0
                    lineHeight:0 red:YES bold:YES];
        
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[35]]
                         frame:CGRectMake( 273, firstViewheight + 124, 102, 16)
                      fontSize:15
                      tracking:0
                    lineHeight:0 red:NO bold:NO];
        
        //line:ENERGIZED
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[34]]
                         frame:CGRectMake( 656, firstViewheight + 98, 123, 29)
                      fontSize:23
                      tracking:0
                    lineHeight:0 red:YES bold:YES];
        
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[36]]
                         frame:CGRectMake(645, firstViewheight + 124, 143, 16)
                      fontSize:15
                      tracking:0
                    lineHeight:0 red:NO bold:NO];

        
        //Happy
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[39]]
                         frame:CGRectMake(487, firstViewheight + 108, 54, 18)
                      fontSize:17
                      tracking:0
                    lineHeight:0 red:NO bold:NO];
        
        //Energized
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[40]]
                         frame:CGRectMake(674, firstViewheight + 260, 63, 19)
                      fontSize:17
                      tracking:0
                    lineHeight:0 red:NO bold:NO];
        
        
        
        //UnHappy
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[41]]
                         frame:CGRectMake(475, firstViewheight + 405, 75, 19)
                      fontSize:17
                      tracking:0
                    lineHeight:0 red:NO bold:NO];
        
        //Relaxed
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[42]]
                         frame:CGRectMake(280, firstViewheight + 260, 63, 19)
                      fontSize:17
                      tracking:0
                    lineHeight:0 red:NO bold:NO];
        
        
        //white bg
        [self showUtmImage:CGRectMake(192, firstViewheight + 372, 251, 31) image:@"t_btn_white"];
        
        
        UIImageView * leftBtnBg = [[UIImageView alloc]initWithFrame:CGRectMake(192, firstViewheight + 372, 251, 31)];
        UIImage * btnBgImg = [UIImage imageNamed:@"t_btn_bg"];
        leftBtnBg.image = btnBgImg;
        [scrollView addSubview:leftBtnBg];
        [self addRepeatAlphaAnimation:leftBtnBg];
        
        UIButton *leftEffectBtn = [[UIButton alloc]initWithFrame:CGRectMake(222, firstViewheight + 380, 190, 19)];
        NSMutableAttributedString * leftEffectBtnStr =  [self getUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[37]]
                                                                         frame:CGRectMake(222, firstViewheight + 380, 190, 19)
                                                                      fontSize:17
                                                                      tracking:0
                                                                    lineHeight:0 red:YES bold:YES];
        [leftEffectBtn setAttributedTitle:leftEffectBtnStr forState:UIControlStateNormal];
        [leftEffectBtn addTarget:self
                        action:@selector(onClickLeftArrowAnimation)
              forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:leftEffectBtn];
        
        
        //white bg
        [self showUtmImage:CGRectMake(588, firstViewheight + 372, 251, 31) image:@"t_btn_white"];
        
        
        UIImageView * rightBtnBg = [[UIImageView alloc]initWithFrame:CGRectMake(588, firstViewheight + 372, 251, 31)];
        rightBtnBg.image = btnBgImg;
        [scrollView addSubview:rightBtnBg];
        [self addRepeatAlphaAnimation:rightBtnBg];
        
        UIButton *rightEffectBtn = [[UIButton alloc]initWithFrame:CGRectMake(641, firstViewheight + 380, 150, 19)];
        NSMutableAttributedString * rightEffectBtnStr =  [self getUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[38]]
                                                                        frame:CGRectMake(222, firstViewheight + 380, 190, 19)
                                                                     fontSize:17
                                                                     tracking:0
                                                                   lineHeight:0 red:YES bold:YES];
        [rightEffectBtn setAttributedTitle:rightEffectBtnStr forState:UIControlStateNormal];
        [rightEffectBtn addTarget:self
                          action:@selector(onClickRightArrowAnimation)
                forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:rightEffectBtn];
        
        
        
        
        
        [self showJoitUtmLabelText:43
                               end:45
                             frame:CGRectMake(161, firstViewheight + 440, 652, 50)
                          fontSize:12
                          tracking:0
                        lineHeight:0
                             enter:YES];
        
        
//        [self showUtmImage:CGRectMake(self.bounds.size.width * 0.5 - 885 * 0.5,firstViewheight + 506, 885, 12) image:@"bottom_line"];
        
        
        
        

        
    }else{
    
        //ここから二つ目のview EyeTreatMent
//        [LogManager setValue:@"utmEye_tech_1"];
        int firstViewheight = 502;
        
        //gb02
        [self showUtmImage:CGRectMake(0,firstViewheight , self.bounds.size.width, 544) image:@"t_bg_eye"];
        
        self.eyeRedLightImgView= [[UIImageView alloc]initWithFrame:CGRectMake(490, firstViewheight +  170 ,410, 250)];
        UIImage * redlightImg = [UIImage imageNamed:@"t_effect_redlight"];
        self.eyeRedLightImgView.image = redlightImg;
        self.eyeRedLightImgView.alpha = 0;
        [scrollView addSubview:self.eyeRedLightImgView];
        
        //Technologies
       CGSize titleLabel =  [self getUtmLabelSize:[NSString stringWithFormat:@"%@",utmArr[7]]
                         frame:CGRectMake(30, firstViewheight + 29, 200, 30)
                      fontSize:23
                      tracking:0
                    lineHeight:29 red:NO bold:NO];
       
        float x = 30 + titleLabel.width + 30;
        
        //utm line
        [self showUtmImage:CGRectMake(x, firstViewheight + 25, 1, 70) image:@"utm_line"];
        
        
        //ImuMoisture Extract™
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[105]]
                         frame:CGRectMake( x + 31, firstViewheight + 29, 400, 25)
                      fontSize:17
                      tracking:0
                    lineHeight:20 red:YES bold:NO];
        
        //By combining ~
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[106]]
                         frame:CGRectMake(x + 31,firstViewheight + 60, 588, 38)
                      fontSize:14
                      tracking:0
                    lineHeight:18 red:NO bold:NO];
        
        
        //square
        [self showUtmImage:CGRectMake(143,firstViewheight + 128, 17, 17) image:@"utm_square"];
        
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[107]]
                             frame:CGRectMake(143 + 18,firstViewheight + 128, 510 - 17, 17)
                          fontSize:14
                          tracking:0
                        lineHeight:18 red:NO bold:NO];

        //high
        [self showUtmImage:CGRectMake(256 - 30, 173 + firstViewheight, 14, 32) image:@"high"];
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[22]]
                               frame:CGRectMake(256 - 43, firstViewheight + 238 - 26, 40, 21)
                            fontSize:17
                            tracking:0
                          lineHeight:21 red:NO bold:YES];
        
        //Self-defense
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[109]]
                         frame:CGRectMake(136,firstViewheight + 421,125, 35)
                      fontSize:10
                      tracking:0
                    lineHeight:11 red:NO bold:NO];
        
        //Further boots the effect
        
        self.eyeRedLabel = [[UILabel alloc]initWithFrame:CGRectMake(320, firstViewheight + 184, 255, 74)];
        NSMutableAttributedString * eyeRedLabelStr =  [self getUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[110]]
                                                                        frame:CGRectMake(222, firstViewheight + 380, 190, 19)
                                                                     fontSize:20
                                                                     tracking:0
                                                                   lineHeight:21 red:YES bold:YES];
        [self.eyeRedLabel setAttributedText:eyeRedLabelStr];
        self.eyeRedLabel.alpha = 0;
        self.eyeRedLabel.numberOfLines = 0;
        [scrollView addSubview:self.eyeRedLabel];
        

        //controll
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[113]]
                         frame:CGRectMake(324,firstViewheight + 423, 48, 18)
                      fontSize:14
                      tracking:0
                    lineHeight:15 red:NO bold:NO];
        


        //Ultiume Complex
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[115]]
                         frame:CGRectMake(482,firstViewheight + 423, 60, 36)
                      fontSize:14
                      tracking:0
                    lineHeight:15 red:NO bold:NO];
        
        //Ultiume Complex +
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[117]]
                         frame:CGRectMake(634,firstViewheight + 423,130, 36)
                      fontSize:14
                      tracking:0
                    lineHeight:15 red:NO bold:NO];
        
        
        //*Measure ~
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",[self deleteEnter:utmArr[118]]]
                         frame:CGRectMake(326,firstViewheight + 471,580, 14)
                      fontSize:10
                      tracking:0
                    lineHeight:11 red:NO bold:NO];

        
 
        

    }
    
    
    
//    [scrollView setContentSize:CGSizeMake(self.bounds.size.width,1053)];
    [scrollView setContentSize:CGSizeMake(self.bounds.size.width,1000)];
    [scrollView flashScrollIndicators];
    [self doAnimation];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
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

- (void)showUtmLabelText:(NSString *)text
                     frame:(CGRect)frame
                  fontSize:(CGFloat)fontSize
                  tracking:(CGFloat)tracking
              lineHeight:(CGFloat)lineHeight
                     red:(BOOL)redCheck
                    bold:(BOOL)boldCheck{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]
                                          initWithString:[StringUtils nullToEmpty:text]];
   
    if (boldCheck) {
    [attrStr setFont:[UIUtil getSystemBold:fontSize]];
    }else{
    [attrStr setFont:[UIUtil getSystemBold:fontSize]];
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
//    [lbl setTextAlignment:NSTextAlignmentCenter];
//    [lbl sizeToFit];
    lbl.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:lbl];
    
//    return lbl.frame.size;
}
- (CGSize)getUtmLabelSize:(NSString *)text
                    frame:(CGRect)frame
                 fontSize:(CGFloat)fontSize
                 tracking:(CGFloat)tracking
               lineHeight:(CGFloat)lineHeight
                      red:(BOOL)redCheck
                     bold:(BOOL)boldCheck{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]
                                          initWithString:[StringUtils nullToEmpty:text]];
    
    if (boldCheck) {
        [attrStr setFont:[UIUtil getSystemBold:fontSize]];
    }else{
        [attrStr setFont:[UIUtil getSystemBold:fontSize]];
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
- (NSMutableAttributedString *)getUtmLabelText:(NSString *)text
                   frame:(CGRect)frame
                fontSize:(CGFloat)fontSize
                tracking:(CGFloat)tracking
              lineHeight:(CGFloat)lineHeight
                     red:(BOOL)redCheck
                    bold:(BOOL)boldCheck{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]
                                          initWithString:[StringUtils nullToEmpty:text]];
    
    if (boldCheck) {
        [attrStr setFont:[UIUtil getSystemBold:fontSize]];
    }else{
        [attrStr setFont:[UIUtil getSystemBold:fontSize]];
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
    
    return attrStr;
    
}

- (void)showUtmLabelTextCenter:(NSString *)text
                   frame:(CGRect)frame
                fontSize:(CGFloat)fontSize
                tracking:(CGFloat)tracking
              lineHeight:(CGFloat)lineHeight
                     red:(BOOL)redCheck
                    bold:(BOOL)boldCheck{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]
                                          initWithString:[StringUtils nullToEmpty:text]];
    
    if (boldCheck) {
        [attrStr setFont:[UIUtil getSystemBold:fontSize]];
    }else{
        [attrStr setFont:[UIUtil getSystemBold:fontSize]];
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


- (void)showJoitUtmLabelText:(int)start
                         end:(int)end
                   frame:(CGRect)frame
                fontSize:(CGFloat)fontSize
                tracking:(CGFloat)tracking
                  lineHeight:(CGFloat)lineHeight
                       enter:(BOOL)enterCheck {
    
    NSArray *utmArr = [UIUtil getUtmArray];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:[self deleteEnter:[NSString stringWithFormat:@"%@",utmArr[start]]]];


    
    int rimit = end - start;
    for (int i = 0; i < rimit ; i++) {
        
        if (enterCheck) {
            NSMutableAttributedString *joint =  [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@",utmArr[start + i + 1]]];
            [attrStr appendAttributedString:joint];
        }else{
        NSMutableAttributedString *joint =  [[NSMutableAttributedString alloc]initWithString:[self deleteEnter:[NSString stringWithFormat:@"%@",utmArr[start + i + 1]]]];
        [attrStr appendAttributedString:joint];
        }
    }
    [attrStr setFont:[UIUtil getSystemBold:fontSize]];
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
    lbl.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:lbl];
    
}
- (void)didMoveToSuperview{

    [super didMoveToSuperview];
}


- (void)doAnimation
{

    
    float duration = 0.5;
    [scrollView bringSubviewToFront:self.graph_lineView];
    [UIView animateWithDuration:duration
                          delay:0.5f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
    
                         self.graph_lineView.frame = CGRectMake(185, 160 -53 , 587, 332);
                       self.graph_line.frame = CGRectMake(0, 0 , 587, 332);

                     }
                     completion:^(BOOL finished){
    
                     }];


    
    //星のアニメーション用のViewを生成
    self.starView = [[UIView alloc]initWithFrame:CGRectMake(300, 200, 300, 200)];
    [scrollView addSubview:self.starView];
    
    
    float grayGraphView  = [self drawUpAnimation:@"t_gray_graph" frame:CGRectMake(263 , 436.5, 52, 127)  duration:duration delay:1.0];
    
   
    float redGraphView =  [self drawUpAnimation:@"t_red_graph" frame:CGRectMake(433 , 436.5, 54, 207)  duration:duration delay:grayGraphView];

 
    [self drawAlphaAnimation:@"t1_utm" frame:CGRectMake(460 - 50, 216 - 24  ,161, 300) duration:duration delay:redGraphView];
    
    
    //redlight用アニメーション
    [UIView animateWithDuration:duration
                          delay:redGraphView
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         self.redlightImgView.alpha = 1;
                         
                     }
                     completion:^(BOOL finished){
                         
                     }];

    float arrowView = [self drawUpAnimation:@"t_arrow" frame:CGRectMake(322, 346 - 30 , 105, 81) duration:duration delay:redGraphView];


    
    //しずるエフェクト用
    UIImageView * effect_bg = [[UIImageView alloc]initWithFrame:CGRectMake(220 + 70, 150 + 70, 0, 0)];
    effect_bg.image = [UIImage imageNamed:@"sizle_base"];
    [scrollView addSubview:effect_bg];
    

    
    UIImageView *effect  = [[UIImageView alloc]initWithFrame:CGRectMake(220 , 150 , 140, 140)];
    effect.image = [UIImage imageNamed:@"t_effect_64"];
    effect.alpha = 0;
    [scrollView addSubview:effect];
    
    
    [UIView animateWithDuration:duration
                          delay:arrowView
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         [effect_bg setFrame:CGRectMake(220, 150, 140, 140)];
                         
                     }
                     completion:^(BOOL finished){

                         
                         //alphaアニメーションスタート
                         [UIView animateWithDuration:duration
                                          animations:^{
                                              
                                              effect.alpha = 1;
                                              
                                          }
                                          completion:^(BOOL finished){
                                              //アニメーションが終了したときの処理
                                           
                                              UIImageView * effect_highlight = [[UIImageView alloc]initWithFrame:CGRectMake(220 , 150, 140, 140)];
                                              effect_highlight.image = [UIImage imageNamed:@"sizle_highlight"];
                                              [scrollView addSubview:effect_highlight];
                                            
                                              [self addEffect:effect_highlight];
                                              
                                              if (self.superview) {
                                              self.starEffectTimer =
                                              [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(addStarEffect:) userInfo:nil repeats:YES
                                               ]; }

                                              
                                          }];
                         
                     }];
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

-(void)stopTimer{

    if ([self.starEffectTimer isValid]) {
       
        [self.starEffectTimer invalidate];
    }
    
    if ([self.starEffectTimerEye isValid]) {
        [self.starEffectTimerEye invalidate];
    }
    
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

-(void)addRepeatAlphaAnimation:(UIImageView *)imgView{
    // 2秒間キーフレームアニメーションを実行する（逆再生＆リピート）
    [UIView animateKeyframesWithDuration:1.0
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionAutoreverse | UIViewKeyframeAnimationOptionRepeat
                              animations:^{

                                  imgView.alpha = 0;
                                  
                              } completion:NULL];

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


-(void)addArrowEffect{

    int margin_y = 502;
    UIImage *crossImg = [UIImage imageNamed:@"t_cross"];
    UIImageView * crossImgView = [[UIImageView alloc]initWithFrame:CGRectMake(506, 260 + margin_y, 10, 10)];
    crossImgView.image = crossImg;
    [scrollView addSubview:crossImgView];
    
    [UIView animateWithDuration:0.5f
                         delay:0.5f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         crossImgView.frame = CGRectMake(370, 135 + margin_y, 283, 263);
                         
                     }
                     completion:^(BOOL finished){
                         

                     }];
    
    
}


-(void)addStarEffect:(NSTimer*)timer{


    
    int x = random()%300 + 1;
    int y = random()%200 + 1;
    int size = random()%15 + 5;
    
    UIImageView * star = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, size, size)];
    star.image = [UIImage imageNamed:@"t_star"];
    star.alpha = 0;
    [self.starView addSubview:star];
    
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         star.alpha = 1;
                         
                     }
                     completion:^(BOOL finished){
                         //アニメーションが終了したときの処理
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

    
    
}

-(void)addStarEffectEye:(NSTimer*)timer{
    
    
    
    int x = random()%200 + 1;
    int y = random()%100 + 1;
    int size = random()%10 + 5;
    
    UIImageView * star = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, size, size)];
    star.image = [UIImage imageNamed:@"t_star"];
    star.alpha = 0;
    [self.starViewEye addSubview:star];
    
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         star.alpha = 1;
                         
                     }
                     completion:^(BOOL finished){
                         //アニメーションが終了したときの処理
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
    
    
    
}

-(void)onClickLeftArrowAnimation{
    
    int margin = 502;;
    UIView * leftArrowView = [[UIView alloc]initWithFrame:CGRectMake(345, 366 + margin, 345, 0)];
    leftArrowView.clipsToBounds = YES;
    UIImageView * leftArrowImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -218 , 345, 218)];
    leftArrowImgView.image = [UIImage imageNamed:@"t_arrow_left"];
    [leftArrowView addSubview:leftArrowImgView];
    [scrollView addSubview:leftArrowView];
    
    [UIView animateWithDuration:1.0f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         leftArrowView.frame = CGRectMake(345 , 366 + margin - 218 , 345, 218);
                         leftArrowImgView.frame = CGRectMake(0 , 0 , 345, 218);
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                    }];
    
    
}
-(void)onClickRightArrowAnimation{
    int margin = 502;
    UIView * rightArrowView = [[UIView alloc]initWithFrame:CGRectMake(335, 366 + margin, 345, 0)];
    rightArrowView.clipsToBounds = YES;
    UIImageView * rightArrowImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -218 , 345, 218)];
    rightArrowImgView.image = [UIImage imageNamed:@"t_arrow_right"];
    [rightArrowView addSubview:rightArrowImgView];
    [scrollView addSubview:rightArrowView];
    
    [UIView animateWithDuration:1.0f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         rightArrowView.frame = CGRectMake(335 , 366 + margin - 218 , 345, 218);
                         rightArrowImgView.frame = CGRectMake(0 , 0 , 345, 218);
                         
                         
                     }
                     completion:^(BOOL finished){
                     }];
    
    
    
    
}

-(void)addAnimationEyeGraph{

    int margin_y = 502;
    float duration = 0.5;
    
    UIView * graphLineView = [[UIView alloc]initWithFrame:CGRectMake(256, 173 + 247 + margin_y, 0, 0)];
    graphLineView.clipsToBounds = YES;
    [scrollView addSubview:graphLineView];
    
    UIImageView * graphLineImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,  - 247,550 , 247)];
    graphLineImgView.image = [UIImage imageNamed:@"t_glaph_line_eye"];
    [graphLineView addSubview:graphLineImgView];

    
    [UIView animateWithDuration:duration
                          delay:0.5f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                        graphLineView.frame = CGRectMake(256, 173 + margin_y , 550, 247);
                        graphLineImgView.frame = CGRectMake(0, 0 , 550 , 247);
                         
                     }
                     completion:^(BOOL finished){

                     }];
    
    
    //星用のやつ
    self.starViewEye = [[UIView alloc]initWithFrame:CGRectMake(600, 250 + margin_y, 200, 100)];
    [scrollView addSubview:self.starViewEye];
    
    float grayGraphView  = [self drawUpAnimation:@"t_graph_gray_eye" frame:CGRectMake(321 , 417 + margin_y, 52, 72)  duration:duration delay:1.0];
    
    
    float redGraphView_1 =  [self drawUpAnimation:@"t_graph_red_eye" frame:CGRectMake(485 , 417 + margin_y, 52, 111)  duration:duration delay:grayGraphView];
    
     float redGraphView_2 =  [self drawUpAnimation:@"t_graph_red_2_eye" frame:CGRectMake(662 , 417 + margin_y, 52, 203)  duration:duration delay:redGraphView_1];
    
    
    [self drawAlphaAnimation:@"utmeye_image" frame:CGRectMake(662, 213 + margin_y + 5 ,98, 227) duration:duration delay:redGraphView_2];
    
    

    [UIView animateWithDuration:duration
                          delay:redGraphView_2
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                        self.eyeRedLightImgView.alpha = 1;
                         
                     }
                     completion:^(BOOL finished){
                         
                         
                     }];
    
    
    UIView * arrowView = [[UIView alloc]initWithFrame:CGRectMake(540, 308 + margin_y , 0, 90)];
    arrowView.clipsToBounds = YES;
    [scrollView addSubview:arrowView];
    UIImageView *arrowImgView= [[UIImageView alloc]initWithFrame:CGRectMake(0, - 90 ,115, 90)];
    UIImage * arrowImg = [UIImage imageNamed:@"t_arrow_eye"];
    arrowImgView.image = arrowImg;
    [arrowView addSubview:arrowImgView];
    
    [UIView animateWithDuration:duration
                          delay:redGraphView_2
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         arrowView.frame = CGRectMake(540 , 308 + margin_y - 90, 115, 90);
                         arrowImgView.frame = CGRectMake(0 , 0 ,115, 90);
                         
                     }
                     completion:^(BOOL finished){
                         
                       
                        if (self.superview) {
                             self.starEffectTimerEye =
                             [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(addStarEffectEye:) userInfo:nil repeats:YES
                              ];
                         }
                         
                         [UIView animateWithDuration:1.0f
                                               delay:0.0f
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              
                                                self.eyeRedLabel.alpha = 1;
                                              
                                          }
                                          completion:^(BOOL finished){
                                              
                                             
                                          }];
                         
                         
                     }];


    

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    
    if ((int)self.scrollView.contentOffset.y > 400) {
        if (firstAnimation) {
            
            if (isSerum) {
                [self addArrowEffect];
//                [LogManager setValue:@"utm_tech_2"];
            }else{
                [self addAnimationEyeGraph];
//                [LogManager setValue:@"utmEye_tech_2"];
            
            }
           
            
            firstAnimation = NO;
        }
        
    }
    
}

@end
