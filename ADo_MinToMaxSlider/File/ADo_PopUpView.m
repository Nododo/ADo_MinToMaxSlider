//
//  ADo_PopUpView.m
//  ADo_MinToMaxSlider
//
//  Created by 杜维欣 on 15/11/27.
//  Copyright © 2015年 Nododo. All rights reserved.
//

#import "ADo_PopUpView.h"
#import "UIView+Tool.h"

@interface ADo_PopUpView ()

@property (nonatomic,strong)NSDictionary *attrs;

@end

//这个宏是为了只有一位数字时 该空间太小导致太难看了
static float const KPaddingWidth = 5.0f;
static float const KArrowHeight = 5.0f;
static float const KArrowWidth = 5.0f;
static float const KCornerRadius = 3.0f;
static float const KTextHeight = 20.0f;
static float const KTextFont = 13.0f;

@implementation ADo_PopUpView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (NSDictionary *)attrs
{
    if (!_attrs) {
        NSMutableParagraphStyle *style = [[NSParagraphStyle alloc] mutableCopy];
        style.alignment = kCTTextAlignmentCenter;
        self.attrs = @{NSFontAttributeName : [UIFont fontWithName:@"AmericanTypewriter" size:KTextFont],
                       NSForegroundColorAttributeName : [UIColor darkGrayColor],
                       NSParagraphStyleAttributeName : style,
                       };
    }
    return _attrs;
}

- (void)drawRect:(CGRect)rect {
    float textWidth = [self calculateWidthWithString:self.text];
    float textHalfWidth = textWidth / 2 + KPaddingWidth;
    float midX = self.width / 2;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, midX, 0);
    CGContextAddLineToPoint(ctx, midX + textHalfWidth - KCornerRadius, 0);
    CGContextAddArc(ctx, midX + textHalfWidth - KCornerRadius, KCornerRadius, KCornerRadius, - 0.5f * M_PI, 0, 0);
    CGContextAddLineToPoint(ctx, midX + textHalfWidth, KTextHeight - KCornerRadius);
    CGContextAddArc(ctx, midX + textHalfWidth - KCornerRadius, KTextHeight - KCornerRadius, KCornerRadius, 0, 0.5f * M_PI, 0);
    CGContextAddLineToPoint(ctx, midX + KArrowWidth / 2, KTextHeight);
    CGContextAddLineToPoint(ctx, midX, KTextHeight + KArrowHeight);
    CGContextAddLineToPoint(ctx, midX - KArrowWidth / 2, KTextHeight);
    CGContextAddLineToPoint(ctx, midX - textHalfWidth + KCornerRadius, KTextHeight);
    CGContextAddArc(ctx, midX - textHalfWidth + KCornerRadius, KTextHeight - KCornerRadius, KCornerRadius, 0.5f * M_PI, 1.0f * M_PI, 0);
    CGContextAddLineToPoint(ctx, midX - textHalfWidth, KCornerRadius);
    CGContextAddArc(ctx, midX - textHalfWidth + KCornerRadius, KCornerRadius, KCornerRadius, M_PI, 1.5f *M_PI, 0);
    CGContextAddLineToPoint(ctx, midX, 0);
    [[UIColor orangeColor] set];
    CGContextFillPath(ctx);
    [self.text drawInRect:CGRectMake(midX - textHalfWidth - KPaddingWidth , 0, textWidth + 2 * KPaddingWidth, KTextHeight) withAttributes:self.attrs];
}

- (void)setText:(NSString *)text
{
    _text = text;
    [self setNeedsDisplay];
}

- (float)calculateWidthWithString:(NSString *)string
{
    NSDictionary *attDic = @{NSFontAttributeName : [UIFont systemFontOfSize:KTextFont]};
    CGSize size =[string boundingRectWithSize:CGSizeMake(0, KTextHeight) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil].size;
    return size.width;
}

- (void)popUp
{
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.values = @[@1,@1.5f,@1.0f,@1.3f];
    scaleAnimation.keyTimes = @[@0,@0.1f,@.4f,@.8,@1.0f];
    scaleAnimation.duration = 0.5f;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:scaleAnimation forKey:@"scale"];
}

- (void)hide
{
   [self.layer removeAnimationForKey:@"scale"];
}

@end
