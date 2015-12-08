//
//  ADo_CircleView.m
//  ADo_MinToMaxSlider
//
//  Created by 杜维欣 on 15/11/27.
//  Copyright © 2015年 Nododo. All rights reserved.
//

#import "ADo_CircleView.h"
#import "UIView+Tool.h"
@implementation ADo_CircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor grayColor] set];
    CGContextAddEllipseInRect(ctx, CGRectMake(1, 1, rect.size.width - 2, rect.size.height - 2));
    CGContextSetLineWidth(ctx, 1);
    CGContextStrokePath(ctx);
    
    CGContextRef ctx1 = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] set];
    CGContextAddEllipseInRect(ctx1, CGRectMake(1, 1, rect.size.width - 2, rect.size.height - 2));
    CGContextFillPath(ctx1);
    
}


@end
