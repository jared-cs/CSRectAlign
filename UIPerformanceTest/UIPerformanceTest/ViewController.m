//
//  ViewController.m
//  UIPerformanceTest
//
//  Created by Jack-Sparrow on 2022/11/11.
//

#import "ViewController.h"
#import "UIView+CSRectAlign.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *label = [UILabel new];
    label.text = @"你吃了么.nn";
    CGRect rect  = CGRectMake(100.9, 100.4, 93.2, 21.4);
    CGRect rect1 = CGRectAlignPixel(rect);
    CGRect rect2 = CGRectMake(floor(100.9), floor(100.4), ceil(93.2), ceil(21.4));
    CGRect rect3 = CGRectIntegral(rect);
    label.frame = rect;
//    label.frame = rect1;
//    [label alignFrame];
    [self.view addSubview:label];

    NSLog(@"\norigin = %@, \nalgin = %@, \nfloor-ceil = %@, \nIntegral = %@",
          NSStringFromCGRect(rect),
          NSStringFromCGRect(rect1),
          NSStringFromCGRect(rect2),
          NSStringFromCGRect(rect3));
}

@end
