//
//  KPColumnChart.h
//  KPColumnChart
//
//  Created by Kipling on 2017/6/1.
//  Copyright © 2017年 Kipling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPColumnChart : UIView

/**
 * 渐变色 
 */
@property (nonatomic, strong) NSArray *columnColors;

/**
 *  Y 轴描述信息字体 默认 8
 */
@property (nonatomic, assign) CGFloat yDescTextFontSize;

/**
 *  X 轴描述信息字体 默认 8
 */
@property (nonatomic, assign) CGFloat xDescTextFontSize;

/**
 *  数据源
 */
@property (nonatomic, strong) NSArray *valueArr;

/**
 *  X 轴描述数据源
 */
@property (nonatomic, strong) NSArray *xShowInfoText;

/**
 *  柱间隔 默认5
 */
@property (nonatomic, assign) CGFloat typeSpace;

/**
 *  柱宽 默认40
 */
@property (nonatomic, assign) CGFloat columnWidth;

/**
 *  x起始值 默认20
 */
@property (nonatomic, assign) CGFloat originX;

/**
 *  是否需要轴线
 */
@property (nonatomic, assign) BOOL needXandYLine;

/**
 *  Y, X 轴线背景色
 */
@property (nonatomic, strong) UIColor *colorForXYLine;

/**
 *  X, Y 轴线描述字体颜色
 */
@property (nonatomic, strong) UIColor *drawTextColorForX_Y;

/**
 *  复制线背景色
 */
@property (nonatomic, strong) UIColor *assistColor;

/**
 *   Y 轴线开关
 */
@property (nonatomic, assign) BOOL isShowYLine;

/**
 *  峰值
 */
@property (nonatomic, assign) CGFloat maxHeight;

/**
 *  Y轴辅助线数据源
 */
@property (nonatomic, strong)NSArray *yLineDataArr;

/**
 *  开始绘制
 */
- (void)showColumnChart;

/**
 *  清除图层
 */
- (void)clear;

/**
 *   x轴描述信息间隔
 */
@property (nonatomic, assign) NSInteger infoTextSpace;

@end
