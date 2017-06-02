//
//  ViewController.m
//  KPColumnChart
//
//  Created by Kipling on 2017/6/1.
//  Copyright © 2017年 Kipling. All rights reserved.
//

#import "ViewController.h"
#import "KPColumnChart.h"
#define k_MainBoundsWidth [UIScreen mainScreen].bounds.size.width
#define k_MainBoundsHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    KPColumnChart *column = [[KPColumnChart alloc] initWithFrame:CGRectMake(0, 64, k_MainBoundsWidth, 200)];
    
    column.valueArr =  @[@"1", @"70", @"90", @"60", @"40", @"30", @"60"];
//    column.columnColors = @[(__bridge id)[UIColor colorWithRed:0.29 green:0.85 blue:0.46 alpha:1.00].CGColor, (__bridge id)[UIColor colorWithRed:0.85 green:0.99 blue:0.90 alpha:1.00].CGColor];
//
//    column.typeSpace = 10;
//    column.isShowYLine = NO;
//    column.columnWidth = 10;
//    column.drawTextColorForX_Y = [UIColor blackColor];
//    column.colorForXYLine = [UIColor redColor];
//    column.assistColor = [UIColor redColor];
//    column.xShowInfoText = @[@"4月1日",@"2"];
//    column.maxHeight = 50;
//    column.yLineDataArr = @[@"5",@"30"];
//    column.infoTextSpace = 3;
//    column.yDescTextFontSize = 15;
//    column.xDescTextFontSize = 15;

//    column.backgroundColor = [UIColor redColor];
    [column showColumnChart];
    [self.view addSubview:column];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
