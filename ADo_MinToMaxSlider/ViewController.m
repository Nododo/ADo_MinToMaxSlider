//
//  ViewController.m
//  ADo_MinToMaxSlider
//
//  Created by 杜维欣 on 15/11/27.
//  Copyright © 2015年 Nododo. All rights reserved.
//

#import "ViewController.h"
#import "ADo_MinToMaxSlider.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ADo_MinToMaxSlider *slider = [[ADo_MinToMaxSlider alloc] initWithMaxValue:500];
    slider.frame = CGRectMake(0, 100, self.view.frame.size.width, 100);
    [self.view addSubview:slider];
    
    UILabel *minLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 100, 100)];
    minLabel.backgroundColor = [UIColor orangeColor];
    minLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:minLabel];
    
    UILabel *maxLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 200, 100, 100)];
    maxLabel.backgroundColor = [UIColor yellowColor];
    maxLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:maxLabel];
    
    slider.minToMax = ^(int minValue,int maxValue)
    {
        minLabel.text = [NSString stringWithFormat:@"%d",minValue];
        maxLabel.text = [NSString stringWithFormat:@"%d",maxValue];
    };
}
@end
