//
//  ADo_CircleView.h
//  ADo_MinToMaxSlider
//
//  Created by 杜维欣 on 15/11/27.
//  Copyright © 2015年 Nododo. All rights reserved.
//

#import "UIView+Tool.h"

@implementation UIView (Tool)

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setY:(CGFloat)Y
{
    CGRect frameT = self.frame;
    frameT.origin.y = Y;
    self.frame = frameT;
}

- (CGFloat)Y
{
    return self.frame.origin.y;
}

- (void)setX:(CGFloat)X
{
    CGRect frameT = self.frame;
    frameT.origin.x = X;
    self.frame = frameT;
}

- (CGFloat)X
{
    return self.frame.origin.x;
}

-(void)setWidth:(CGFloat)width
{
    CGRect frameT = self.frame;
    frameT.size.width = width;
    self.frame = frameT;
}

- (CGFloat)width
{ 
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frameT = self.frame;
    frameT.size.height = height;
    self.frame = frameT;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frameT = self.frame;
    frameT.size = size;
    self.frame = frameT;
}

- (CGSize)size
{
    return self.frame.size;
}

@end
