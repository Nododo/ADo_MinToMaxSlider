//
//  ADo_MinToMaxSlider.m
//  ADo_MinToMaxSlider
//
//  Created by 杜维欣 on 15/11/27.
//  Copyright © 2015年 Nododo. All rights reserved.
//

#import "ADo_MinToMaxSlider.h"
#import "UIView+Tool.h"
#import "ADo_CircleView.h"
#import "ADo_PopUpView.h"
#import "UIView+CornerMaskLayer.h"

static float const KPaddingW = 20.0f;
static float const KPaddingH = 5.0f;
static float const KProgressH = 10.0f;
static float const KTitleH = 10.0f;
static float const KCircleRadius = 30.0f;
static float const KTitleFont = 10.0f;
static float const KTolerateSpace = 5.0f;
static float const KPopWidth = 50.0f;
static float const KPopHeight = 25.0f;

@interface ADo_MinToMaxSlider ()

@property (nonatomic,assign)int maxValue;
@property (nonatomic,assign)int minValue;
@property (nonatomic,assign)float minCircleCenterX;
@property (nonatomic,assign)float maxCircleCenterX;
/**无奈的参数  因为遮挡问题需要把当前控件移动到最前面  调用bringSubviewToFront这个方法,会触发layoutSubviews方法  这个方法  会重新布局*/
@property (nonatomic,assign)BOOL firstInit;

@property (nonatomic,weak)UIView *progreesView;
@property (nonatomic,weak)UIView *bottomView;

@property (nonatomic,weak)ADo_CircleView *minView;
@property (nonatomic,weak)ADo_CircleView *maxView;
@property (nonatomic,weak)UILabel *zeroLabel;
@property (nonatomic,weak)UILabel *quarterLabel;
@property (nonatomic,weak)UILabel *threeQuarterLabel;
@property (nonatomic,weak)UILabel *finalLabel;
@property (nonatomic,weak)ADo_PopUpView *minPop;
@property (nonatomic,weak)ADo_PopUpView *maxPop;

@end

@implementation ADo_MinToMaxSlider
@synthesize maxValue = _maxValue;
@synthesize minValue = _minValue;

- (instancetype)initWithMaxValue:(int)maxValue;
{
    self = [super init];
    if (self) {
        self.maxValue = maxValue;
        [self initialize];
    }
    return self;
}

- (int)maxValue
{
    return _maxValue;
}

- (int)minValue
{
    return _minValue;
}

- (void)setMaxValue:(int)maxValue
{
    _maxValue = maxValue;
}

- (void)setMinValue:(int)minValue
{
    _minValue = minValue;
}

- (void)initialize
{
    //底部进度条
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor grayColor];
    [self addSubview:bottomView];
    self.bottomView = bottomView;
    
    //长条
    UIView *progreesView = [[UIView alloc] init];
    progreesView.backgroundColor = [UIColor cyanColor];
    [self addSubview:progreesView];
    self.progreesView = progreesView;
    
    //等比划分label显示
    [self arrangeLabel];
    
    //最小值
    ADo_CircleView *minView = [[ADo_CircleView alloc] init];
    [self addSubview:minView];
    self.minView= minView;
    
    //最大值
    ADo_CircleView *maxView = [[ADo_CircleView alloc] init];
    [self addSubview:maxView];
    self.maxView = maxView;
    
    //最小显示框
    ADo_PopUpView *minPop = [[ADo_PopUpView alloc] init];
    [minPop setText:@"0"];
    [self addSubview:minPop];
    self.minPop = minPop;
    
    //最大显示框
    ADo_PopUpView *maxPop = [[ADo_PopUpView alloc] init];
    [maxPop setText:[NSString stringWithFormat:@"%d",self.maxValue]];
    [self addSubview:maxPop];
    self.maxPop = maxPop;

    [self addGesForCircleView];

    [self bringSubviewToFront:maxView];
}

- (void)arrangeLabel
{
    UILabel *zeroLabel = [[UILabel alloc] init];
    zeroLabel.text = @"0";
    zeroLabel.textAlignment = NSTextAlignmentCenter;
    zeroLabel.font = [UIFont systemFontOfSize:KTitleFont];
    [self addSubview:zeroLabel];
    self.zeroLabel = zeroLabel;
    
    UILabel *quarterLabel = [[UILabel alloc] init];
    quarterLabel.text = [NSString stringWithFormat:@"%d",self.maxValue / 3];
    quarterLabel.textAlignment = NSTextAlignmentCenter;
    quarterLabel.font = [UIFont systemFontOfSize:KTitleFont];
    [self addSubview:quarterLabel];
    self.quarterLabel = quarterLabel;
    
    
    UILabel *threeQuarterLabel = [[UILabel alloc] init];
    threeQuarterLabel.text = [NSString stringWithFormat:@"%d",self.maxValue * 2/ 3];
    threeQuarterLabel.textAlignment = NSTextAlignmentCenter;
    threeQuarterLabel.font = [UIFont systemFontOfSize:KTitleFont];
    [self addSubview:threeQuarterLabel];
    self.threeQuarterLabel = threeQuarterLabel;
    
    UILabel *finalLabel = [[UILabel alloc] init];
    finalLabel.text = [NSString stringWithFormat:@"%d",self.maxValue];
    finalLabel.font = [UIFont systemFontOfSize:KTitleFont];
    finalLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:finalLabel];
    self.finalLabel = finalLabel;
}

- (void)addGesForCircleView
{
    UIPanGestureRecognizer *panForMin = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panTheMinCircle:)];
    [self.minView addGestureRecognizer:panForMin];
    
    UIPanGestureRecognizer *panForMax = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panTheMaxCircle:)];
    [self.maxView addGestureRecognizer:panForMax];
    
}

- (void)layoutSubviews
{
    if (!self.firstInit) {
        self.bottomView.X = KPaddingW;
        self.bottomView.height = KProgressH;
        self.bottomView.centerY = self.height / 2;
        self.bottomView.width = self.width - KPaddingW * 2;
        [self.bottomView addCornerMaskLayerWithRadius:5.0f];
        
        self.progreesView.X = KPaddingW;
        self.progreesView.height = KProgressH;
        self.progreesView.centerY = self.height / 2;
        self.progreesView.width = self.width - KPaddingW * 2;
        [self.progreesView addCornerMaskLayerWithRadius:5.0f];
        
        self.zeroLabel.width = self.progreesView.width / 4;
        self.zeroLabel.centerX = KPaddingW;
        self.zeroLabel.height = KTitleH;
        self.zeroLabel.Y = self.progreesView.Y - KTitleH - KPaddingH;
        
        self.quarterLabel.width = self.progreesView.width / 4;
        self.quarterLabel.centerX = KPaddingW + self.progreesView.width / 3;
        self.quarterLabel.height = KTitleH;
        self.quarterLabel.Y = self.progreesView.Y - KTitleH - KPaddingH;
        
        self.threeQuarterLabel.width = self.progreesView.width / 4;
        self.threeQuarterLabel.centerX = KPaddingW + self.progreesView.width * 2 / 3;
        self.threeQuarterLabel.height = KTitleH;
        self.threeQuarterLabel.Y = self.progreesView.Y - KTitleH - KPaddingH;
        
        self.finalLabel.width = self.progreesView.width / 4;
        self.finalLabel.centerX = self.width - KPaddingW;
        self.finalLabel.height = KTitleH;
        self.finalLabel.Y = self.progreesView.Y - KTitleH - KPaddingH;
        
        self.minView.width = KCircleRadius;
        self.minView.centerX = KPaddingW;
        self.minView.height = KCircleRadius;
        self.minView.centerY = self.height / 2;
        self.minCircleCenterX = KPaddingW;
        
        self.minPop.width = KPopWidth;
        self.minPop.centerX = KPaddingW;
        self.minPop.height = KPopHeight;
        self.minPop.Y = self.minView.Y - KPopHeight - KPaddingH;
        
        self.maxView.width = KCircleRadius;
        self.maxView.centerX = self.width - KPaddingW;
        self.maxView.height = KCircleRadius;
        self.maxView.centerY = self.height / 2;
        self.maxCircleCenterX = self.width - KPaddingW;
        
        self.maxPop.width = KPopWidth;
        self.maxPop.centerX = self.width - KPaddingW;
        self.maxPop.height = KPopHeight;
        self.maxPop.Y = self.maxView.Y - KPopHeight - KPaddingH;
        
        self.firstInit = YES;
    }
    
    [super layoutSubviews];
    
}

- (void)panTheMinCircle:(UIPanGestureRecognizer *)panTheMin
{
    [self bringSubviewToFront:self.minView];
    float tempMinCenterX = self.minCircleCenterX;
    CGPoint minPoint = [panTheMin translationInView:panTheMin.view];
    float deltaX = minPoint.x;
    self.minCircleCenterX += deltaX;
    if (self.minCircleCenterX >= KPaddingW && self.minCircleCenterX <= self.maxCircleCenterX) {
        panTheMin.view.centerX = self.minCircleCenterX;
        self.progreesView.X = self.minCircleCenterX;
        self.progreesView.width -= deltaX;
        self.minPop.centerX = self.minCircleCenterX;
        int minValue = (int)(self.minCircleCenterX - KPaddingW) / (self.width - KPaddingW * 2) * self.maxValue;
        [self.minPop setText:[NSString stringWithFormat:@"%d",minValue]];
    }else
    {
        self.minCircleCenterX = tempMinCenterX;

    }
    if (panTheMin.state == UIGestureRecognizerStateBegan) {
        [self.minPop popUp];
    }
    if (panTheMin.state == UIGestureRecognizerStateEnded) {
        [self.minPop hide];
        [self calculateValue];
    }
    [panTheMin setTranslation:CGPointZero inView:panTheMin.view];
}

- (void)panTheMaxCircle:(UIPanGestureRecognizer *)panTheMax
{
    [self bringSubviewToFront:self.maxView];
    float tempMaxCenterX = self.maxCircleCenterX;
    CGPoint minPoint = [panTheMax translationInView:panTheMax.view];
    float deltaX = minPoint.x;
    self.maxCircleCenterX += deltaX;
    if (self.maxCircleCenterX >= self.minCircleCenterX && self.maxCircleCenterX <= self.width - KPaddingW) {
        panTheMax.view.centerX = self.maxCircleCenterX;
        self.progreesView.width += deltaX;
        self.maxPop.centerX = self.maxCircleCenterX;
        int maxValue = (int)(self.maxCircleCenterX - KPaddingW) / (self.width - KPaddingW * 2) * self.maxValue;
        [self.maxPop setText:[NSString stringWithFormat:@"%d",maxValue]];
    }else
    {
        self.maxCircleCenterX = tempMaxCenterX;
    }
    if (panTheMax.state == UIGestureRecognizerStateBegan) {
        [self.maxPop popUp];
    }
    if (panTheMax.state == UIGestureRecognizerStateEnded) {
        if (self.maxCircleCenterX < KPaddingW + KTolerateSpace) {
            [self resumMaxView];
        }
        [self.maxPop hide];
        [self calculateValue];
    }
    [panTheMax setTranslation:CGPointZero inView:panTheMax.view];
}

- (void)resumMaxView
{
    self.maxCircleCenterX = self.width - KPaddingW;
    [UIView animateWithDuration:0.5f delay:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.maxView.centerX = self.width - KPaddingW;
        self.maxPop.centerX = self.width - KPaddingW;
        self.progreesView.width = self.maxCircleCenterX - self.minCircleCenterX;
    } completion:^(BOOL finished) {
        [self.maxPop setText:[NSString stringWithFormat:@"%d",self.maxValue]];
        [self calculateValue];
    }];
}

- (void)calculateValue
{
  int minValue = (int)(self.minCircleCenterX - KPaddingW) / (self.width - KPaddingW * 2) * self.maxValue;
  int maxValue = (int)(self.maxCircleCenterX - KPaddingW) / (self.width - KPaddingW * 2) * self.maxValue;
    if (self.minToMax) {
        self.minToMax(minValue,maxValue);
    }
}

@end
