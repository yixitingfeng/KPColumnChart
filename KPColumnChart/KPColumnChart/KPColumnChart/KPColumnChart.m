//
//  KPColumnChart.m
//  KPColumnChart
//
//  Created by Kipling on 2017/6/1.
//  Copyright © 2017年 Kipling. All rights reserved.
//

#import "KPColumnChart.h"

@interface KPColumnChart()

//所有的图层数组
@property (nonatomic, strong)NSMutableArray *layerArr;

//单元值
@property (nonatomic, assign) CGFloat perHeight;

@end

@implementation KPColumnChart

-(NSMutableArray *)layerArr {
    
    if (!_layerArr) {
        _layerArr = [NSMutableArray array];
    }
    return _layerArr;
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _xDescTextFontSize = _yDescTextFontSize = 8.0;
        _needXandYLine = YES;
        _isShowYLine = YES;
        self.layer.masksToBounds = YES;
    }
    return self;
}

-(void)showColumnChart {
    
    [self clear];
    [self calculateMaxheightAndPerheight];
    _columnWidth = (_columnWidth <= 0 ? 15 : _columnWidth);
    _typeSpace = (_typeSpace <= 0 ? 15 : _typeSpace);
    _originX = (_originX <= 0 ? 20 : _originX);
    _infoTextSpace = (_infoTextSpace <= 0 ? 1 : _infoTextSpace);
    _columnColors = (_columnColors ? _columnColors : @[(__bridge id)[UIColor colorWithRed:0.29 green:0.85 blue:0.46 alpha:1.00].CGColor, (__bridge id)[UIColor colorWithRed:0.85 green:0.99 blue:0.90 alpha:1.00].CGColor]);
    //绘制X、Y轴  可以在此改动X、Y轴字体大小
    if (_needXandYLine) {
        [self drawXandYline];
    }
    //绘制X轴提示语  不管是否设置了是否绘制X、Y轴 提示语都应有
    if (_xShowInfoText.count > 0) {
        [self drawXandYTips];
    }
    //展示
    [self drawColumnChart];
}

/** 计算峰值与单元值 */
- (void)calculateMaxheightAndPerheight {
    
    if (!(_yLineDataArr.count && (_maxHeight > 0))) {
        CGFloat max = 0;
        for (NSString *number in _valueArr) {
            CGFloat currentNumber = [NSString stringWithFormat:@"%@",number].floatValue;
            if (currentNumber > max) {
                max = currentNumber;
            }
        }
        if (max < 5.0) {
            _maxHeight = 5.0;
        }else if(max < 10){
            _maxHeight = 10;
        }else{
            _maxHeight = max;
        }
    }
    _perHeight = (CGRectGetHeight(self.frame) - _xDescTextFontSize - 20) / _maxHeight;
}

/**绘制 x y 虚线 */
- (void)drawXandYline {
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    [self.layerArr addObject:layer];
    
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    if (self.isShowYLine) {
        [bezier moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame) - _xDescTextFontSize - 10)];
        [bezier addLineToPoint:CGPointMake(0, 20)];
    }
    [bezier moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame) - _xDescTextFontSize - 10)];
    [bezier addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - _xDescTextFontSize - 10)];
    layer.path = bezier.CGPath;
    layer.strokeColor = (_colorForXYLine == nil ? ([UIColor blackColor].CGColor) : _colorForXYLine.CGColor);
    [self.layer addSublayer:layer];
    
    //设置虚线辅助线
    if (_yLineDataArr.count) {
        [self drawAssistLine];
    }
}

/** 绘制辅助线 */
- (void)drawAssistLine {
    UIBezierPath *assist = [UIBezierPath bezierPath];
    
    for (NSInteger i = 0; i < _yLineDataArr.count; i++) {
//        NSInteger pace = (_maxHeight) / 5;
        CGFloat height = _perHeight *[_yLineDataArr[i] floatValue];
        [assist moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame) - height - _xDescTextFontSize - 10)];
        [assist addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - height - _xDescTextFontSize - 10)];
        
        CATextLayer *textLayer = [CATextLayer layer];
        textLayer.contentsScale = [UIScreen mainScreen].scale;
        NSString *text = _yLineDataArr[i];
        CGSize textSize = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX,30) textFont:self.yDescTextFontSize aimString:text];
        textLayer.frame = CGRectMake(CGRectGetWidth(self.frame) - 10 - textSize.width, CGRectGetHeight(self.frame) - height - textSize.height - 5 - _xDescTextFontSize - 10, textSize.width, textSize.height);
        
        UIFont *font = [UIFont systemFontOfSize:self.yDescTextFontSize];
        CFStringRef fontName = (__bridge CFStringRef)font.fontName;
        CGFontRef fontRef = CGFontCreateWithFontName(fontName);
        textLayer.font = fontRef;
        textLayer.fontSize = font.pointSize;
        CGFontRelease(fontRef);
        
        textLayer.string = text;
        textLayer.foregroundColor = (_drawTextColorForX_Y==nil?[UIColor blackColor].CGColor:_drawTextColorForX_Y.CGColor);
        [self.layer addSublayer:textLayer];
        [self.layerArr addObject:textLayer];
    }
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = assist.CGPath;
    shapeLayer.strokeColor = (_assistColor ==nil?([UIColor darkGrayColor].CGColor):_assistColor.CGColor);
    shapeLayer.lineWidth = 0.5;
    
    [self.layer addSublayer:shapeLayer];
    [self.layerArr addObject:shapeLayer];
}

/** 绘制X轴提示语  不管是否设置了是否绘制X、Y轴 提示语都应有 */
- (void)drawXandYTips {
    for (NSInteger i = 0; i < _xShowInfoText.count; i++) {
        
        CATextLayer *textLayer = [CATextLayer layer];
        CGSize size = [_xShowInfoText[i] boundingRectWithSize:CGSizeMake(100, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.xDescTextFontSize]} context:nil].size;
        
        textLayer.frame = CGRectMake( i * (_columnWidth + _typeSpace) * _infoTextSpace + _originX - (size.width - _columnWidth) / 2.f, CGRectGetHeight(self.frame) - self.xDescTextFontSize - 5, size.width, size.height);
        textLayer.string = _xShowInfoText[i];
        textLayer.contentsScale = [UIScreen mainScreen].scale;
        UIFont *font = [UIFont systemFontOfSize:self.xDescTextFontSize];
        textLayer.fontSize = font.pointSize;
        textLayer.foregroundColor = _drawTextColorForX_Y.CGColor;
        textLayer.alignmentMode = kCAAlignmentCenter;
        
        [self.layer addSublayer:textLayer];
        [self.layerArr addObject:textLayer];
    }
}

/** 绘制柱状图 */
- (void)drawColumnChart {
    
    for (NSInteger i = 0; i < _valueArr.count; i++) {
        CGFloat height =[_valueArr[i] floatValue] *_perHeight;
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = _columnColors;
        gradientLayer.frame = CGRectMake(i * _columnWidth + i * _typeSpace + _originX, CGRectGetHeight(self.frame) - height - 1 - 10 - _xDescTextFontSize, _columnWidth, height);
        [self.layer addSublayer:gradientLayer];
        [self.layerArr addObject:gradientLayer];
    }
}

-(void)clear{
    for (CALayer *lay in self.layerArr) {
        [lay removeAllAnimations];
        [lay removeFromSuperlayer];
    }
}

/**
 *  返回字符串的占用尺寸
 *
 *  @param maxSize   最大尺寸
 *  @param fontSize  字号大小
 *  @param aimString 目标字符串
 *
 *  @return 占用尺寸
 */
- (CGSize)sizeOfStringWithMaxSize:(CGSize)maxSize textFont:(CGFloat)fontSize aimString:(NSString *)aimString{
    
    return [[NSString stringWithFormat:@"%@",aimString] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    
}

@end
