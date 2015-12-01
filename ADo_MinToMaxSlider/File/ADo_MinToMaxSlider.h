//
//  ADo_MinToMaxSlider.h
//  ADo_MinToMaxSlider
//
//  Created by 杜维欣 on 15/11/27.
//  Copyright © 2015年 Nododo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADo_MinToMaxSlider : UIView

- (instancetype)initWithMaxValue:(int)maxValue;

@property (nonatomic,copy)void(^minToMax)(int minValue,int maxValue);

@end
