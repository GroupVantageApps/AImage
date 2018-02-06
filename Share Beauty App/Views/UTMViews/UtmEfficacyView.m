//
//  UtmEfficacyView.m
//  shiseido_finder
//
//  Created by yuki.kiryu on 2016/05/11.
//  Copyright (c) 2016年 株式会社 デーコム. All rights reserved.
//

#import "UtmEfficacyView.h"
#import "UIUtil.h"
#import "StringUtils.h"
#import "NSMutableAttributedString+Additions.h"
#import "Share_Beauty_App-Swift.h"

@implementation UtmEfficacyView

@synthesize scrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)showEfficacyDetail {

    NSLog(@"showEfficacyDetail");
    firstAnimation = YES;

    NSArray * ssArr = [[NSArray alloc] init];
    if (_isIBUKI||_isWhiteLucent||_isAllDayBright) {
        ssArr = [UIUtil get17SSArray];
    }
    NSArray *utmArr = [UIUtil getUtmArray];

    [self setBackgroundColor:[UIColor whiteColor]];

    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
    [self addSubview:scrollView];

    if (_isIBUKI) {

        CGSize titleLabel = [self getUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[47]]
                                            frame:CGRectMake(30 , 29, 400 , 24)
                                         fontSize:23
                                         tracking:0
                                       lineHeight:0 red:NO bold:NO];

        float x = 30 + titleLabel.width + 30;

        [self showUtmImage:CGRectMake(x, 25, 1, 26) image:@"utm_line"];

        //The Effects of smart
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",ssArr[1]]
                         frame:CGRectMake( x + 31, 29, 400, 25)
                      fontSize:17
                      tracking:0
                    lineHeight:0 red:YES bold:NO];

        //Used over makeup
        [self getUtmLabelText:[NSString stringWithFormat:@"%@",ssArr[2]]
                        frame:CGRectMake(32 , 83, 400 , 20)
                     fontSize:18
                     tracking:0
                   lineHeight:0 red:YES bold:NO];

        //Corrects shine and pores for photogenic skin
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",ssArr[3]]
                               frame:CGRectMake( 117, 127,337 , 15)
                            fontSize:15
                            tracking:0
                          lineHeight:0 red:NO bold:YES];

        //The product suppresses shine and minimizes visible pores.
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",ssArr[4]]
                               frame:CGRectMake(512, 127, 437, 15)
                            fontSize:15
                            tracking:0
                          lineHeight:0 red:NO bold:YES];

        //After Left Image
        [self showUtmImage:CGRectMake(166, 165, 237, 241) image:@"sib01_after.jpg"];

        //Before Left Image
        self.utm01 = [[UIImageView alloc]initWithFrame:CGRectMake(166, 165, 237, 241)];
        UIImage *utm01image = [UIImage imageNamed:@"sib01_before"];
        self.utm01.image = utm01image;
        [scrollView addSubview:self.utm01];


        //After Right Image
        UIImageView *utm02_bafter = [[UIImageView alloc]initWithFrame:CGRectMake(607, 165, 255, 241)];
        UIImage *utm02image_bafter = [UIImage imageNamed:@"sib02_after.jpg"];
        utm02_bafter.image = utm02image_bafter;
        [scrollView addSubview:utm02_bafter];


        //Before Right Image
        self.utm02 = [[UIImageView alloc]initWithFrame:CGRectMake(607, 165, 255, 241)];
        UIImage *utm02image = [UIImage imageNamed:@"sib02_before"];
        self.utm02.image = utm02image;
        [scrollView addSubview:self.utm02];


        //    UIImage *imgMinimum = [[UIImage imageNamed:@"efficacy_slider_full"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
        //
        //    UIImage *imgMaximum = [[UIImage imageNamed:@"efficacy_slider_empty"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 5)];


        UIImage *imgMinimum = [UIImage imageNamed:@"efficacy_slider_full"];

        UIImage *imgMaximum = [UIImage imageNamed:@"efficacy_slider_empty"];

        //Slider Left
        UISlider * slider_left = [[UISlider alloc]initWithFrame:CGRectMake(103, 422, 360,30)];
        [slider_left setThumbImage: [UIImage imageNamed:@"sib_slider_1_40"] forState:UIControlStateNormal];
        [slider_left setMinimumTrackImage:imgMinimum forState:UIControlStateNormal];
        [slider_left setMaximumTrackImage:imgMaximum forState:UIControlStateNormal];
        slider_left.tag = 1;
        [slider_left addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:slider_left];


        //Slider Right
        UISlider * slider_right = [[UISlider alloc]initWithFrame:CGRectMake(557, 422, 360, 30)];

        [slider_right setThumbImage: [UIImage imageNamed:@"sib_slider_1_40"] forState:UIControlStateNormal];
        [slider_right setMinimumTrackImage:imgMinimum forState:UIControlStateNormal];

        [slider_right setMaximumTrackImage:imgMaximum forState:UIControlStateNormal];
        slider_right.tag = 2;
        [slider_right addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];

        [scrollView addSubview:slider_right];


        //左
        //Before
        [self showUtmImage:CGRectMake(103, 456, 8, 10) image:@"efficacy_triangle"];
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",ssArr[5]]
                               frame:CGRectMake( 79, 468, 55, 45)
                            fontSize:12
                            tracking:0
                          lineHeight:0 red:NO bold:NO];

        //After
        [self showUtmImage:CGRectMake(455, 456, 8, 10) image:@"efficacy_triangle"];
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",ssArr[6]]
                               frame:CGRectMake( 416, 468, 84, 45)
                            fontSize:12
                            tracking:0
                          lineHeight:0 red:NO bold:NO];


        //右
        //Before
        [self showUtmImage:CGRectMake(557, 456, 8, 10) image:@"efficacy_triangle"];
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",ssArr[5]]
                               frame:CGRectMake( 530, 468, 55, 45)
                            fontSize:12
                            tracking:0
                          lineHeight:0 red:NO bold:NO];


        [self showUtmLabelText:[NSString stringWithFormat:@"%@",ssArr[10]]
                         frame:CGRectMake( 510, 477, 500, 30)
                      fontSize:10
                      tracking:0
                    lineHeight:0 red:NO bold:YES];

        //After
        [self showUtmImage:CGRectMake(908, 456, 8, 10) image:@"efficacy_triangle"];
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",ssArr[6]]
                               frame:CGRectMake( 873, 468, 84, 45)
                            fontSize:12
                            tracking:0
                          lineHeight:0 red:NO bold:NO];

        //ここから二つ目のview
        int firstViewheight = 502;

        //Efficacy Results
        CGSize titleLabel2 =  [self getUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[47]]
                                              frame:CGRectMake(30, firstViewheight + 29, 400, 24)
                                           fontSize:23
                                           tracking:0
                                         lineHeight:0 red:NO bold:NO];

        float x2 = 30 + titleLabel2.width + 30;

        [self showUtmImage:CGRectMake(x2, firstViewheight + 25, 1, 26) image:@"utm_line"];

        //The effect of Smart Filtering Smoother
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",ssArr[1]]
                         frame:CGRectMake( x2 + 31, firstViewheight + 29, 400, 25)
                      fontSize:17
                      tracking:0
                    lineHeight:0 red:YES bold:NO];

        //Used on bare skin
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",ssArr[8]]
                               frame:CGRectMake( 30, firstViewheight + 80, 150, 40)
                            fontSize:17
                            tracking:0
                          lineHeight:0 red:YES bold:NO];



        //Softens focus on pores
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",ssArr[9]]
                         frame:CGRectMake( 35, firstViewheight + 140, 150, 40)
                      fontSize:15
                      tracking:0
                    lineHeight:0 red:NO bold:NO];


        //Before
        [self showUtmImage:CGRectMake(276, firstViewheight +  467, 8, 10) image:@"efficacy_triangle"];
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",ssArr[5]]
                               frame:CGRectMake( 260,firstViewheight + 478, 43, 45)
                            fontSize:12
                            tracking:0
                          lineHeight:0 red:NO bold:NO];

        //After
        [self showUtmImage:CGRectMake(749, firstViewheight +  467, 8, 10) image:@"efficacy_triangle"];
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",ssArr[6]]
                               frame:CGRectMake( 718, firstViewheight + 478, 68, 45)
                            fontSize:12
                            tracking:0
                          lineHeight:0 red:NO bold:NO];




        [self showUtmLabelText:[NSString stringWithFormat:@"%@",ssArr[10]]
                         frame:CGRectMake( 678, firstViewheight + 370, 200, 40)
                      fontSize:10
                      tracking:0
                    lineHeight:0 red:NO bold:NO];




        //Slider
        UISlider * slider_center = [[UISlider alloc]initWithFrame:CGRectMake(274,firstViewheight + 426, 483, 30)];

        [slider_center setThumbImage: [UIImage imageNamed:@"sib_slider_1_40"] forState:UIControlStateNormal];
        [slider_center setMinimumTrackImage:imgMinimum forState:UIControlStateNormal];

        [slider_center setMaximumTrackImage:imgMaximum forState:UIControlStateNormal];
        slider_center.tag = 3;
        [slider_center addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];

        [scrollView addSubview:slider_center];


        //After 2nd Center Image
        [self showUtmImage:CGRectMake(378, firstViewheight + 85, 281, 320) image:@"sib03_after.jpg"];

        NSLog(@"firstViewhegiht:%d", firstViewheight);


        //before 2nd Center Image
        self.utm03 = [[UIImageView alloc]initWithFrame:CGRectMake(378, firstViewheight + 85, 281, 320)];
        UIImage *utm03image = [UIImage imageNamed:@"sib03_before"];
        self.utm03.image = utm03image;
        [scrollView addSubview:self.utm03];

        [scrollView setContentSize:CGSizeMake(self.bounds.size.width,1053)];
        [scrollView flashScrollIndicators];



    }else if(_isWhiteLucent){

        CGSize titleLabel = [self getUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[47]]
                                            frame:CGRectMake(30 , 29, 400 , 24)
                                         fontSize:23
                                         tracking:0
                                       lineHeight:0 red:NO bold:NO];

        float x = 30 + titleLabel.width + 30;

        [self showUtmImage:CGRectMake(x, 25, 1, 26) image:@"utm_line"];

        //The effect of OnMakeup Spot Correcting Serum
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",ssArr[28]]
                         frame:CGRectMake( x + 31, 29, 400, 25)
                      fontSize:17
                      tracking:0
                    lineHeight:0 red:YES bold:NO];

        //Visual evaluation by experts
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",ssArr[29]]
                         frame:CGRectMake(170 , 80, 800 , 40)
                      fontSize:18
                      tracking:0
                    lineHeight:0 red:NO bold:YES];


        //After Center Image
        [self showUtmImage:CGRectMake(350, 135, 325, 230) image:@"whl01_after.jpg"];

        //Before Center Image
        self.utm01 = [[UIImageView alloc]initWithFrame:CGRectMake(350, 135, 325, 230)];
        UIImage *utm01image = [UIImage imageNamed:@"whl01_before"];
        self.utm01.image = utm01image;
        [scrollView addSubview:self.utm01];


        //    UIImage *imgMinimum = [[UIImage imageNamed:@"efficacy_slider_full"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
        //
        //    UIImage *imgMaximum = [[UIImage imageNamed:@"efficacy_slider_empty"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 5)];


        UIImage *imgMinimum = [UIImage imageNamed:@"efficacy_slider_full"];

        UIImage *imgMaximum = [UIImage imageNamed:@"efficacy_slider_empty"];

        //Slider Center
        UISlider * slider_left = [[UISlider alloc]initWithFrame:CGRectMake(269, 390, 473,30)];
        [slider_left setThumbImage: [UIImage imageNamed:@"whl_slider_1_13"] forState:UIControlStateNormal];
        [slider_left setMinimumTrackImage:imgMinimum forState:UIControlStateNormal];
        [slider_left setMaximumTrackImage:imgMaximum forState:UIControlStateNormal];
        slider_left.tag = 1;
        [slider_left addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:slider_left];

        //左
        //Before use
        [self showUtmImage:CGRectMake(272, 446, 8, 10) image:@"efficacy_triangle"];
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",ssArr[25]]
                               frame:CGRectMake( 246, 458, 60, 26)
                            fontSize:12
                            tracking:0
                          lineHeight:0 red:NO bold:NO];

        //After 12 weeks of regular use
        [self showUtmImage:CGRectMake(732, 446, 8, 10) image:@"efficacy_triangle"];
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",ssArr[26]]
                               frame:CGRectMake( 671, 458, 120, 10)
                            fontSize:12
                            tracking:0
                          lineHeight:0 red:NO bold:NO];

        //tested by Asian
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",ssArr[30]]
                         frame:CGRectMake(690, 317, 160, 50)
                      fontSize:15
                      tracking:0
                    lineHeight:0 red:NO bold:YES];

        [scrollView setContentSize:CGSizeMake(self.bounds.size.width,550)];

    }else if(_isAllDayBright){

        CGSize titleLabel = [self getUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[47]]
                                            frame:CGRectMake(30 , 29, 400 , 24)
                                         fontSize:23
                                         tracking:0
                                       lineHeight:0 red:NO bold:NO];

        float x = 30 + titleLabel.width + 30;

        [self showUtmImage:CGRectMake(x, 25, 1, 26) image:@"utm_line"];

        //The effect of All Day Brightener N
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",ssArr[23]]
                         frame:CGRectMake( x + 31, 29, 400, 25)
                      fontSize:17
                      tracking:0
                    lineHeight:0 red:YES bold:NO];

        //The skin’s overall brightness, clarity and radiant were enhanced.
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",ssArr[24]]
                         frame:CGRectMake(243 , 70, 800 , 40)
                      fontSize:17
                      tracking:0
                    lineHeight:0 red:NO bold:YES];


        //After Center Image
        [self showUtmImage:CGRectMake(350, 115, 325, 240) image:@"wab01_after.jpg"];

        //Before Center Image
        self.utm01 = [[UIImageView alloc]initWithFrame:CGRectMake(350, 115, 325, 240)];
        UIImage *utm01image = [UIImage imageNamed:@"wab01_before"];
        self.utm01.image = utm01image;
        [scrollView addSubview:self.utm01];


        //    UIImage *imgMinimum = [[UIImage imageNamed:@"efficacy_slider_full"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
        //
        //    UIImage *imgMaximum = [[UIImage imageNamed:@"efficacy_slider_empty"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 5)];


        UIImage *imgMinimum = [UIImage imageNamed:@"efficacy_slider_full"];

        UIImage *imgMaximum = [UIImage imageNamed:@"efficacy_slider_empty"];

        //Slider Center
        UISlider * slider_left = [[UISlider alloc]initWithFrame:CGRectMake(269, 380, 477,30)];
        [slider_left setThumbImage: [UIImage imageNamed:@"wab_slider_1_18"] forState:UIControlStateNormal];
        [slider_left setMinimumTrackImage:imgMinimum forState:UIControlStateNormal];
        [slider_left setMaximumTrackImage:imgMaximum forState:UIControlStateNormal];
        slider_left.tag = 1;
        [slider_left addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:slider_left];

        //左
        //Before use
        [self showUtmImage:CGRectMake(272, 436, 8, 10) image:@"efficacy_triangle"];
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",ssArr[25]]
                               frame:CGRectMake( 246, 448, 60, 26)
                            fontSize:12
                            tracking:0
                          lineHeight:0 red:NO bold:NO];

        //After 12 weeks of regular use
        [self showUtmImage:CGRectMake(737, 436, 8, 10) image:@"efficacy_triangle"];
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",ssArr[26]]
                               frame:CGRectMake( 676, 448, 120, 10)
                            fontSize:12
                            tracking:0
                          lineHeight:0 red:NO bold:NO];

        //tested by Asian women
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",ssArr[10]]
                         frame:CGRectMake(690, 327, 160, 30)
                      fontSize:15
                      tracking:0
                    lineHeight:0 red:NO bold:YES];

        [scrollView setContentSize:CGSizeMake(self.bounds.size.width,550)];

    }else if(_isUtm){
        isSerum = YES;

        CGSize titleLabel = [self getUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[47]]
                                            frame:CGRectMake(30 , 29, 400 , 24)
                                         fontSize:23
                                         tracking:0
                                       lineHeight:0 red:NO bold:NO];

        float x = 30 + titleLabel.width + 30;

        [self showUtmImage:CGRectMake(x, 25, 1, 26) image:@"utm_line"];

        //The Effects of Ultimune
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[48]]
                         frame:CGRectMake( x + 31, 29, 400, 25)
                      fontSize:17
                      tracking:0
                    lineHeight:0 red:YES bold:NO];

        //Skin radiance
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[49]]
                               frame:CGRectMake( 98, 84,377 , 15)
                            fontSize:14
                            tracking:0
                          lineHeight:0 red:NO bold:YES];

        //Uneven skin tone
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[52]]
                               frame:CGRectMake( 550, 84, 377, 15)
                            fontSize:14
                            tracking:0
                          lineHeight:0 red:NO bold:YES];

        //After Left Image
        [self showUtmImage:CGRectMake(98, 108, 377, 278) image:@"utm01_after"];

        //Before Left Image
        self.utm01 = [[UIImageView alloc]initWithFrame:CGRectMake(98, 108, 377, 278)];
        UIImage *utm01image = [UIImage imageNamed:@"utm01_befor"];
        self.utm01.image = utm01image;
        [scrollView addSubview:self.utm01];


        //Right Image
        UIImageView *utm02_bafter = [[UIImageView alloc]initWithFrame:CGRectMake(550, 108, 377, 278)];
        UIImage *utm02image_bafter = [UIImage imageNamed:@"utm02_after"];
        utm02_bafter.image = utm02image_bafter;
        [scrollView addSubview:utm02_bafter];


        //Before Right Image
        self.utm02 = [[UIImageView alloc]initWithFrame:CGRectMake(550, 108, 377, 278)];
        UIImage *utm02image = [UIImage imageNamed:@"utm02_befor"];
        self.utm02.image = utm02image;
        [scrollView addSubview:self.utm02];


        //    UIImage *imgMinimum = [[UIImage imageNamed:@"efficacy_slider_full"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
        //
        //    UIImage *imgMaximum = [[UIImage imageNamed:@"efficacy_slider_empty"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 5)];


        UIImage *imgMinimum = [UIImage imageNamed:@"efficacy_slider_full"];

        UIImage *imgMaximum = [UIImage imageNamed:@"efficacy_slider_empty"];

        //Slider Left
        UISlider * slider_left = [[UISlider alloc]initWithFrame:CGRectMake(105, 420, 359,30)];
        [slider_left setThumbImage: [UIImage imageNamed:@"efficacy_slider_circle"] forState:UIControlStateNormal];
        [slider_left setMinimumTrackImage:imgMinimum forState:UIControlStateNormal];
        [slider_left setMaximumTrackImage:imgMaximum forState:UIControlStateNormal];
        slider_left.tag = 1;
        [slider_left addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:slider_left];


        //Slider Right
        UISlider * slider_right = [[UISlider alloc]initWithFrame:CGRectMake(557, 420, 359, 30)];

        [slider_right setThumbImage: [UIImage imageNamed:@"efficacy_slider_circle"] forState:UIControlStateNormal];
        [slider_right setMinimumTrackImage:imgMinimum forState:UIControlStateNormal];

        [slider_right setMaximumTrackImage:imgMaximum forState:UIControlStateNormal];
        slider_right.tag = 2;
        [slider_right addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];

        [scrollView addSubview:slider_right];


        //左
        //Before use
        [self showUtmImage:CGRectMake(109, 461, 8, 10) image:@"efficacy_triangle"];
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[50]]
                               frame:CGRectMake( 85, 473, 55, 45)
                            fontSize:12
                            tracking:0
                          lineHeight:0 red:NO bold:NO];

        //After 4 weeks of us
        [self showUtmImage:CGRectMake(453, 461, 8, 10) image:@"efficacy_triangle"];
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[51]]
                               frame:CGRectMake( 415, 473, 84, 41)
                            fontSize:12
                            tracking:0
                          lineHeight:0 red:NO bold:NO];


        //右
        //Before use
        [self showUtmImage:CGRectMake(561, 461, 8, 10) image:@"efficacy_triangle"];
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[50]]
                               frame:CGRectMake( 538, 473, 55, 45)
                            fontSize:12
                            tracking:0
                          lineHeight:0 red:NO bold:NO];

        //After 4 weeks of use
        [self showUtmImage:CGRectMake(908, 461, 8, 10) image:@"efficacy_triangle"];
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[51]]
                               frame:CGRectMake( 870, 473, 84, 41)
                            fontSize:12
                            tracking:0
                          lineHeight:0 red:NO bold:NO];


        [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[55]]
                         frame:CGRectMake( 760, 397, 170, 13)
                      fontSize:11
                      tracking:0
                    lineHeight:0 red:NO bold:NO];

        //ここから二つ目のview
        int firstViewheight = 502;

        //Efficacy Results
        CGSize titleLabel2 =  [self getUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[47]]
                                              frame:CGRectMake(30, firstViewheight + 29, 400, 24)
                                           fontSize:23
                                           tracking:0
                                         lineHeight:0 red:NO bold:NO];

        float x2 = 30 + titleLabel2.width + 30;

        [self showUtmImage:CGRectMake(x2, firstViewheight + 25, 1, 26) image:@"utm_line"];

        //The Effects of Ultimune
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[48]]
                         frame:CGRectMake( x2 + 31, firstViewheight + 29, 400, 25)
                      fontSize:17
                      tracking:0
                    lineHeight:0 red:YES bold:NO];

        //Redness improved~
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[58]]
                         frame:CGRectMake( 30, firstViewheight + 112, 224, 53)
                      fontSize:14
                      tracking:0
                    lineHeight:0 red:NO bold:NO];



        //ryness and
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[59]]
                         frame:CGRectMake( 30, firstViewheight + 167, 224, 53)
                      fontSize:14
                      tracking:0
                    lineHeight:0 red:NO bold:NO];


        //Before use
        [self showUtmImage:CGRectMake(276, firstViewheight +  477, 8, 10) image:@"efficacy_triangle"];
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[60]]
                               frame:CGRectMake( 260,firstViewheight + 488, 43, 26)
                            fontSize:12
                            tracking:0
                          lineHeight:0 red:NO bold:NO];

        //6 mounth
        [self showUtmImage:CGRectMake(761, firstViewheight +  477, 8, 10) image:@"efficacy_triangle"];
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[61]]
                               frame:CGRectMake( 730, firstViewheight + 488, 68, 26)
                            fontSize:12
                            tracking:0
                          lineHeight:0 red:NO bold:NO];


        [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[62]]
                         frame:CGRectMake( 720, firstViewheight + 358, 223, 12)
                      fontSize:11
                      tracking:0
                    lineHeight:0 red:NO bold:NO];


        [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[63]]
                         frame:CGRectMake( 720, firstViewheight + 370, 240, 12)
                      fontSize:11
                      tracking:0
                    lineHeight:0 red:NO bold:NO];




        //Slider Right
        UISlider * slider_center = [[UISlider alloc]initWithFrame:CGRectMake(274,firstViewheight + 436, 497, 30)];

        [slider_center setThumbImage: [UIImage imageNamed:@"efficacy_slider_circle"] forState:UIControlStateNormal];
        [slider_center setMinimumTrackImage:imgMinimum forState:UIControlStateNormal];

        [slider_center setMaximumTrackImage:imgMaximum forState:UIControlStateNormal];
        slider_center.tag = 3;
        [slider_center addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];

        [scrollView addSubview:slider_center];


        [self showUtmImage:CGRectMake(350, firstViewheight + 112, 362, 271) image:@"utm03_after"];

        //before 2nd Center Image
        self.utm03 = [[UIImageView alloc]initWithFrame:CGRectMake(350, firstViewheight + 112, 362, 271)];
        UIImage *utm03image = [UIImage imageNamed:@"utm03_befor"];
        self.utm03.image = utm03image;
        [scrollView addSubview:self.utm03];

        [scrollView setContentSize:CGSizeMake(self.bounds.size.width,1053)];
        [scrollView flashScrollIndicators];


    }else if(_isUtmEye){
        CGSize titleLabel = [self getUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[47]]
                                            frame:CGRectMake(30, 29, 400, 30)
                                         fontSize:23
                                         tracking:0
                                       lineHeight:29 red:NO bold:NO];

        float x = titleLabel.width + 60;
        [self showUtmImage:CGRectMake(x, 25, 1, 35) image:@"utm_line"];

        //The Effects of Ultimune ~
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",utmArr[120]]
                         frame:CGRectMake( x + 31, 29, 400, 25)
                      fontSize:17
                      tracking:0
                    lineHeight:0 red:YES bold:NO];

        //Examples of improvement in deep
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[122]]
                               frame:CGRectMake( 238, 85, 550, 17)
                            fontSize:15
                            tracking:0
                          lineHeight:0 red:NO bold:NO];


        NSLog(@"utmArr122 %@",[NSString stringWithFormat:@"%@",utmArr[122]]);


        UIImage *imgMinimum = [UIImage imageNamed:@"efficacy_slider_full"];

        UIImage *imgMaximum = [UIImage imageNamed:@"efficacy_slider_empty"];

        //Slider Right
        UISlider * slider_center = [[UISlider alloc]initWithFrame:CGRectMake(259,423, 506, 30)];

        [slider_center setThumbImage: [UIImage imageNamed:@"efficacy_slider_circle_eye"] forState:UIControlStateNormal];
        [slider_center setMinimumTrackImage:imgMinimum forState:UIControlStateNormal];

        [slider_center setMaximumTrackImage:imgMaximum forState:UIControlStateNormal];
        slider_center.tag = 4;
        [slider_center addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];

        [scrollView addSubview:slider_center];



        [self showUtmImage:CGRectMake(332, 118, 360, 278) image:@"eye_after"];
        //before 2nd Center Image
        self.utm03 = [[UIImageView alloc]initWithFrame:CGRectMake(332, 118, 360, 278)];
        UIImage *utm03image = [UIImage imageNamed:@"eye_befor"];
        self.utm03.image = utm03image;
        [scrollView addSubview:self.utm03];


        //Before use
        [self showUtmImage:CGRectMake(265,  465, 8, 10) image:@"efficacy_triangle"];
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[123]]
                               frame:CGRectMake( 228, 480, 80, 26)
                            fontSize:15
                            tracking:0
                          lineHeight:18 red:NO bold:NO];

        //After 4Week
        [self showUtmImage:CGRectMake(754, 465, 8, 10) image:@"efficacy_triangle"];
        [self showUtmLabelTextCenter:[NSString stringWithFormat:@"%@",utmArr[124]]
                               frame:CGRectMake( 715, 480, 95, 40)
                            fontSize:15
                            tracking:0
                          lineHeight:18 red:NO bold:NO];
        
        
        //Agency
        [self showJoitUtmLabelText:125
                               end:126
                             frame:CGRectMake(712, 349, 174, 12)
                          fontSize:10
                          tracking:0
                        lineHeight:12
                             enter:YES];
        
        //Agency
        [self showJoitUtmLabelText:127
                               end:128
                             frame:CGRectMake(712, 361, 174, 12)
                          fontSize:10
                          tracking:0
                        lineHeight:12
                             enter:YES];
        //Agency
        [self showJoitUtmLabelText:129
                               end:130
                             frame:CGRectMake(712, 373, 174, 12)
                          fontSize:10
                          tracking:0
                        lineHeight:12
                             enter:YES];
        //Agency
        [self showJoitUtmLabelText:131
                               end:132
                             frame:CGRectMake(712, 385, 174, 12)
                          fontSize:10
                          tracking:0
                        lineHeight:12
                             enter:YES];

        [scrollView setContentSize:CGSizeMake(self.bounds.size.width,550)];
        [scrollView setAlwaysBounceHorizontal:NO];
        [scrollView setAlwaysBounceVertical:NO];
    } else if (_isEssentialEnergyMoisturizingCream) {
        isSerum = YES;
        [self showUtmImageByID:CGRectMake(0, 0, self.bounds.size.width, 513) image:6354];
        
        self.viewForLastBaselineLayout.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(50,10, self.scrollView.frame.size.width - 100,self.scrollView.frame.size.height - 20)];
        backgroundView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:backgroundView];
        float x = 80;
        // 説明文
        NSString *str = [AppItemTable getNameByItemIdWithItemId:7951];
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",str]
                         frame:CGRectMake( x, 29, 800, 25)
                      fontSize:18
                      tracking:0
                    lineHeight:0 red:NO bold:NO];
        
        //After Left Image   410 × 560 >正寸467 × 558>233 × 279
        [self showUtmImage:CGRectMake(80, 70, 410, 330) image:@"MoisturizingCream02_after"];
        
        //Before Left Image
        self.utm01 = [[UIImageView alloc]initWithFrame:CGRectMake(80, 70, 410, 330)];
        UIImage *utm01image = [UIImage imageNamed:@"MoisturizingCream02_before"];
        self.utm01.image = utm01image;
        self.utm01.contentMode = UIViewContentModeScaleAspectFit;
        [scrollView addSubview:self.utm01];
        
        //Right Image
        UIImageView *utm02_bafter = [[UIImageView alloc]initWithFrame:CGRectMake(541, 70, 410, 330)];
        UIImage *utm02image_bafter = [UIImage imageNamed:@"MoisturizingCream01_after"];
        utm02_bafter.image = utm02image_bafter;
        utm02_bafter.contentMode = UIViewContentModeScaleAspectFit;
        [scrollView addSubview:utm02_bafter];
        
        //Before Right Image
        self.utm02 = [[UIImageView alloc]initWithFrame:CGRectMake(541, 70, 410, 330)];
        UIImage *utm02image = [UIImage imageNamed:@"MoisturizingCream01_before"];
        self.utm02.image = utm02image;
        self.utm02.contentMode = UIViewContentModeScaleAspectFit;
        [scrollView addSubview:self.utm02];
        
        UIImage *imgMinimum = [UIImage imageNamed:@"efficacy_slider_full"];
        UIImage *imgMaximum = [UIImage imageNamed:@"efficacy_slider_empty"];
        
        //左 Before use   93 x 67
        [self showUtmImage:CGRectMake(80, 410, 93/3, 67/3) image:@"Befor_use"];
        //After 4 weeks of us 139 x 67
        [self showUtmImage:CGRectMake(446, 410, 139/3, 67/3) image:@"After_4_weeks"];
        
        //右 Before use
        [self showUtmImage:CGRectMake(541, 410, 93/3, 67/3) image:@"Befor_use"];
        //After 4 weeks of use
        [self showUtmImage:CGRectMake(897, 410, 139/3, 67/3) image:@"After_4_weeks"];
        
        //Slider Left
        UISlider * slider_left = [[UISlider alloc]initWithFrame:CGRectMake(80, 440, 410,45)];
        [slider_left setThumbImage: [UIImage imageNamed:@"efficacy_slider_circle_MoisturizingCream"] forState:UIControlStateNormal];
        [slider_left setMinimumTrackImage:imgMinimum forState:UIControlStateNormal];
        [slider_left setMaximumTrackImage:imgMaximum forState:UIControlStateNormal];
        slider_left.tag = 1;
        [slider_left addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:slider_left];
        
        //Slider Right
        UISlider * slider_right = [[UISlider alloc]initWithFrame:CGRectMake(537, 440, 410, 45)];
        [slider_right setThumbImage: [UIImage imageNamed:@"efficacy_slider_circle_MoisturizingCream"] forState:UIControlStateNormal];
        [slider_right setMinimumTrackImage:imgMinimum forState:UIControlStateNormal];
        [slider_right setMaximumTrackImage:imgMaximum forState:UIControlStateNormal];
        slider_right.tag = 2;
        [slider_right addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:slider_right];
        double delay = 0.5;
        [self showUtmAImage:CGRectMake(0, 513, self.bounds.size.width, 513) image:6364 delayTime:&delay];
        delay = 3.5;
        [self showUtmAImage:CGRectMake(0, 513*2, self.bounds.size.width, 513) image:6365 delayTime:&delay];
        delay = 5.5;
        [self showUtmAImage:CGRectMake(0, 513*3, self.bounds.size.width, 513) image:6366 delayTime:&delay];
        
        for (int i = 1; i < 4; i++) {
            [self setLabel:CGRectMake(140, 513*i+320, 120, 50) text:[AppItemTable getNameByItemIdWithItemId:7952] size:36];
            [self setLabel:CGRectMake(140, 513*i+370, 120, 30) text:[AppItemTable getNameByItemIdWithItemId:7954] size:15];
            [self setLabel:CGRectMake(750, 513*i+320, 200, 50) text:[AppItemTable getNameByItemIdWithItemId:7952] size:36];//7953>7952
            [self setLabel:CGRectMake(750, 513*i+370, 150, 30) text:[AppItemTable getNameByItemIdWithItemId:7955] size:15];
            [self setLabel:CGRectMake((self.bounds.size.width)/2-135, 513*i+230, 280, 150) text:[AppItemTable getNameByItemIdWithItemId:7959] size:13];
        }
        [self setLabel:CGRectMake((self.bounds.size.width)/2-180, 513+140, 350, 120) text:[AppItemTable getNameByItemIdWithItemId:7956] size:40];
        [self setLabel:CGRectMake((self.bounds.size.width)/2-180, 513*2+140, 350, 120) text:[AppItemTable getNameByItemIdWithItemId:7957] size:40];
        [self setLabel:CGRectMake((self.bounds.size.width)/2-180, 513*3+140, 350, 120) text:[AppItemTable getNameByItemIdWithItemId:7958] size:40];
        [self.scrollView setContentSize:CGSizeMake(self.bounds.size.width, 513*4)];
        
    }
    else if (_isEssentialEnergyDayCX) {
        isSerum = YES;
        double delay = 0.5;
        [self showUtmAImage:CGRectMake(0, 0, self.bounds.size.width, 513) image:6371 delayTime:&delay];
       
        for (int i = 0; i < 3; i++) {
            [self setLabel:CGRectMake(250, 513*i+320, 120, 50) text:[AppItemTable getNameByItemIdWithItemId:7952] size:36];
            [self setLabel:CGRectMake(250, 513*i+370, 120, 30) text:[AppItemTable getNameByItemIdWithItemId:7955] size:15];
            [self setLabel:CGRectMake(600, 513*i+320, 200, 50) text:[AppItemTable getNameByItemIdWithItemId:7952] size:36];//7953>7952 t-hirai
            [self setLabel:CGRectMake(600, 513*i+370, 150, 30) text:[AppItemTable getNameByItemIdWithItemId:7955] size:15];
            [self setLabel:CGRectMake((self.bounds.size.width)/2-135, 513*i+400, 280, 150) text:[AppItemTable getNameByItemIdWithItemId:7966] size:13];
        }
        [self setLabel:CGRectMake(140, 35, 350, 120) text:[AppItemTable getNameByItemIdWithItemId:7956] size:15]; // t-hirai
        [self setLabel:CGRectMake(530, 35, 350, 120) text:[AppItemTable getNameByItemIdWithItemId:7956] size:15]; // t-hirai
        [self.scrollView setContentSize:CGSizeMake(self.bounds.size.width, 513*3)];
        
    }
    else if (_isEssentialEnergyMoisturizingGelCream) {
        isSerum = YES;
        double delay = 0.5;
        [self showUtmAImage:CGRectMake(0, 0, self.bounds.size.width, 513) image:6367 delayTime:&delay];
        delay = 3.5;
        [self showUtmAImage:CGRectMake(0, 513, self.bounds.size.width, 513) image:6368 delayTime:&delay];
        delay = 5.5;
        [self showUtmAImage:CGRectMake(0, 513*2, self.bounds.size.width, 513) image:6369 delayTime:&delay];
        
        for (int i = 0; i < 3; i++) {
            [self setLabel:CGRectMake(140, 513*i+320, 120, 50) text:[AppItemTable getNameByItemIdWithItemId:7952] size:36];
            [self setLabel:CGRectMake(140, 513*i+370, 120, 30) text:[AppItemTable getNameByItemIdWithItemId:7954] size:15];
            [self setLabel:CGRectMake(750, 513*i+320, 200, 50) text:[AppItemTable getNameByItemIdWithItemId:7952] size:36];//7953>7952 t-hirai
            [self setLabel:CGRectMake(770, 513*i+370, 150, 30) text:[AppItemTable getNameByItemIdWithItemId:7955] size:15];
            [self setLabel:CGRectMake((self.bounds.size.width)/2-135, 513*i+230, 280, 150) text:[AppItemTable getNameByItemIdWithItemId:7962] size:13];
        }
        [self setLabel:CGRectMake((self.bounds.size.width)/2-180, 140, 350, 120) text:[AppItemTable getNameByItemIdWithItemId:7960] size:40]; // t-hirai
        [self setLabel:CGRectMake((self.bounds.size.width)/2-180, 513+140, 350, 120) text:[AppItemTable getNameByItemIdWithItemId:7957] size:40]; // t-hirai
        [self setLabel:CGRectMake((self.bounds.size.width)/2-180, 513*2+140, 350, 120) text:[AppItemTable getNameByItemIdWithItemId:7961] size:40];
        [self setLabel:CGRectMake((self.bounds.size.width)/2-180, 513*3+140, 350, 120) text:[AppItemTable getNameByItemIdWithItemId:7961] size:40];
        [self.scrollView setContentSize:CGSizeMake(self.bounds.size.width, 513*3)];
        
    }
    else if (_isEssentialEnergyDayCream) {
        isSerum = YES;
        [self showUtmImageByID:CGRectMake(0, 0, self.bounds.size.width, 513) image:6354];

        self.scrollView.backgroundColor = [UIColor clearColor];
        self.viewForLastBaselineLayout.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(50,10, self.scrollView.frame.size.width - 100,self.scrollView.frame.size.height - 20)];
        backgroundView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:backgroundView];
        float x = 80;
        // 説明文
        // 説明文
        NSString *str = [AppItemTable getNameByItemIdWithItemId:7963];
        [self showUtmLabelText:[NSString stringWithFormat:@"%@",str]
                         frame:CGRectMake( x, 29, 800, 25)
                      fontSize:18
                      tracking:0
                    lineHeight:0 red:NO bold:NO];
        
        //After Left Image   410 × 560 >正寸467 × 558>233 × 279
        [self showUtmImage:CGRectMake(80, 70, 410, 330) image:@"DayCream02_after"];
        
        //Before Left Image
        self.utm01 = [[UIImageView alloc]initWithFrame:CGRectMake(80, 70, 410, 330)];
        UIImage *utm01image = [UIImage imageNamed:@"DayCream02_before"];
        self.utm01.image = utm01image;
        self.utm01.contentMode = UIViewContentModeScaleAspectFit;
        [scrollView addSubview:self.utm01];
        
        //Right Image
        UIImageView *utm02_bafter = [[UIImageView alloc]initWithFrame:CGRectMake(541, 70, 410, 330)];
        UIImage *utm02image_bafter = [UIImage imageNamed:@"DayCream01_after"];
        utm02_bafter.image = utm02image_bafter;
        self.utm02.contentMode = UIViewContentModeScaleAspectFit;
        [scrollView addSubview:utm02_bafter];
        
        //Before Right Image
        self.utm02 = [[UIImageView alloc]initWithFrame:CGRectMake(541, 70, 410, 330)];
        UIImage *utm02image = [UIImage imageNamed:@"DayCream01_before"];
        self.utm02.image = utm02image;
        self.utm02.contentMode = UIViewContentModeScaleAspectFit;
        [scrollView addSubview:self.utm02];
        
        UIImage *imgMinimum = [UIImage imageNamed:@"efficacy_slider_full"];
        UIImage *imgMaximum = [UIImage imageNamed:@"efficacy_slider_empty"];
        
        //左 Before use   93 x 67
        [self showUtmImage:CGRectMake(80, 410, 93/3, 67/3) image:@"Befor_use"];
        //After 4 weeks of us 139 x 67
        [self showUtmImage:CGRectMake(446, 410, 139/3, 67/3) image:@"After_4_weeks"];
        
        //右 Before use
        [self showUtmImage:CGRectMake(541, 410, 93/3, 67/3) image:@"Befor_use"];
        //After 4 weeks of use
        [self showUtmImage:CGRectMake(897, 410, 139/3, 67/3) image:@"After_4_weeks"];
        
        //Slider Left
        UISlider * slider_left = [[UISlider alloc]initWithFrame:CGRectMake(80, 440, 410,45)];
        [slider_left setThumbImage: [UIImage imageNamed:@"efficacy_slider_circle_Emulsion"] forState:UIControlStateNormal];
        [slider_left setMinimumTrackImage:imgMinimum forState:UIControlStateNormal];
        [slider_left setMaximumTrackImage:imgMaximum forState:UIControlStateNormal];
        slider_left.tag = 1;
        [slider_left addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:slider_left];
        
        //Slider Right
        UISlider * slider_right = [[UISlider alloc]initWithFrame:CGRectMake(537, 440, 410, 45)];
        [slider_right setThumbImage: [UIImage imageNamed:@"efficacy_slider_circle_Emulsion"] forState:UIControlStateNormal];
        [slider_right setMinimumTrackImage:imgMinimum forState:UIControlStateNormal];
        [slider_right setMaximumTrackImage:imgMaximum forState:UIControlStateNormal];
        slider_right.tag = 2;
        [slider_right addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:slider_right];
        
        double delay = 0.5;
        [self showUtmAImage:CGRectMake(0, 513, self.bounds.size.width, 513) image:6370 delayTime:&delay];
       // delay = 3.5;
       // [self showUtmAImage:CGRectMake(0, 513*2, self.bounds.size.width, 513) image:6371 delayTime:&delay];
        
        
        [self setLabel:CGRectMake(75, 513+50, 210, 50) text:[AppItemTable getNameByItemIdWithItemId:7956] size:18];
        [self setLabel:CGRectMake(75+335, 513+50, 210, 50) text:[AppItemTable getNameByItemIdWithItemId:7956] size:18];
        [self setLabel:CGRectMake(75+670, 513+50, 210, 50) text:[AppItemTable getNameByItemIdWithItemId:7956] size:18];
        [self setLabel:CGRectMake(120, 513+320, 120, 50) text:[AppItemTable getNameByItemIdWithItemId:7952] size:36];
        [self setLabel:CGRectMake(120, 513+370, 120, 30) text:[AppItemTable getNameByItemIdWithItemId:7955] size:15];
        [self setLabel:CGRectMake(450, 513+320, 120, 50) text:[AppItemTable getNameByItemIdWithItemId:7952] size:36];
        [self setLabel:CGRectMake(450, 513+370, 120, 30) text:[AppItemTable getNameByItemIdWithItemId:7955] size:15];
        [self setLabel:CGRectMake(740, 513+320, 200, 50) text:[AppItemTable getNameByItemIdWithItemId:7952] size:36];
        [self setLabel:CGRectMake(765, 513+370, 150, 30) text:[AppItemTable getNameByItemIdWithItemId:7955] size:15];
        
        [self setLabel:CGRectMake((self.bounds.size.width)/2-135, 513+390, 280, 150) text:[AppItemTable getNameByItemIdWithItemId:7965] size:13];
        [self setLabel:CGRectMake((self.bounds.size.width)/2-135, 513*2+390, 280, 150) text:[AppItemTable getNameByItemIdWithItemId:7966] size:13];
        
        [self.scrollView setContentSize:CGSizeMake(self.bounds.size.width, 513*2)];
    }
}

-(void)showUtmImage:(CGRect)frame
              image:(NSString *)name{

    UIImageView *imageUtmView = [[UIImageView alloc]initWithFrame:frame];
    UIImage *image = [UIImage imageNamed:name];
    imageUtmView.image = image;
    imageUtmView.contentMode = UIViewContentModeScaleAspectFit;
    [scrollView addSubview:imageUtmView];
}
-(void)showUtmImageByID:(CGRect)frame
                  image:(NSInteger *)ID{
    
    UIImageView *imageUtmView = [[UIImageView alloc]initWithFrame:frame];
    NSURL *path = [FileTable getPath:ID];
    NSData *data = [NSData dataWithContentsOfURL:path];
    imageUtmView.image = [UIImage imageWithData:data];
    [scrollView addSubview:imageUtmView];
}
-(void)showUtmAImage:(CGRect)frame
              image:(NSInteger *)ID
          delayTime:(double *)time{
    
    [Utility setAImageFromObjcWithView:scrollView rect:frame id:ID delayTime:*time];
}

-(void)setLabel:(CGRect)frame
           text:(NSString *)text
           size:(NSInteger)point{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    [label setFont:[UIFont systemFontOfSize:point weight:UIFontWeightBold]];
//     [label setFont:[UIFont systemFontOfSize:point weight:UIFontWeightBold]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    [scrollView addSubview:label];
}
-(void)setLabelSmall:(CGRect)frame
           text:(NSString *)text{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    [label setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightBold]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    [scrollView addSubview:label];
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
    int before = (int)frame.size.width;
    int after =(int)lbl.bounds.size.width;
    int check  =  before - after;

    if (check > 0) {
        lbl.frame = CGRectMake(frame.origin.x + check*0.5, frame.origin.y , lbl.bounds.size.width, lbl.bounds.size.height);
    }
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
    //    [lbl setTextAlignment:NSTextAlignmentCenter];
    //    [lbl sizeToFit];
    lbl.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:lbl];

    //    return lbl.frame.size;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

-(void)sliderAction:(UISlider *)slider{


    int tag = (int)slider.tag;

    switch (tag) {
        case 1:
            self.utm01.alpha = 1 - slider.value;
            break;

        case 2:
            self.utm02.alpha = 1 - slider.value;
            break;

        case 3:
            self.utm03.alpha = 1 - slider.value;
            break;

        case 4:
            self.utm03.alpha = 1 - slider.value;
            break;

    }

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
            NSMutableAttributedString *joint =  [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@": %@",[NSString stringWithFormat:@"%@",utmArr[start + i + 1]]]];
            [attrStr appendAttributedString:joint];
        }else{
            NSMutableAttributedString *joint =  [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",utmArr[start + i + 1]]];
            [attrStr appendAttributedString:joint];
        }
    }

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
- (CGSize)getUtmLabelText:(NSString *)text
                    frame:(CGRect)frame
                 fontSize:(CGFloat)fontSize
                 tracking:(CGFloat)tracking
               lineHeight:(CGFloat)lineHeight
                      red:(BOOL)redCheck
                     bold:(BOOL)boldCheck{
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSLog(@"c:%f",self.scrollView.contentOffset.y);
    
    if ((int)self.scrollView.contentOffset.y > 400) {
        if (firstAnimation) {
            if (isSerum) {
            }else{
            }
            firstAnimation = NO;
        }
        
    }


}
@end
