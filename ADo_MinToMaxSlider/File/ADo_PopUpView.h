//
//  ADo_PopUpView.h
//  ADo_MinToMaxSlider
//
//  Created by 杜维欣 on 15/11/27.
//  Copyright © 2015年 Nododo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADo_PopUpView : UIView

@property (nonatomic,copy)NSString *text;

- (void)popUp;
- (void)hide;

@end
