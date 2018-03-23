//
//  PieView.m
//  shareSDK_Demo
//
//  Created by wl on 2018/3/22.
//  Copyright © 2018年 https://github.com/orzzh. All rights reserved.
//

#import "PieView.h"
@interface PieView()

@property (nonatomic,copy)NSMutableArray<PieModel*> *model_Ary;
@property (nonatomic,copy)NSMutableArray *path_Ary;
@property (nonatomic,strong)CABasicAnimation *animation;
@property (nonatomic,strong)CAShapeLayer *maskLayer;              //动画效果mask
@property (nonatomic,strong)CAShapeLayer *selectLayer;            //选中layer
@end
@implementation PieView
{
    CGFloat curruePercent;      //当前绘制百分百总和
    CALayer *_contentLayer;     //中心layer 容器
    
    CGFloat width;
    CGFloat radius;
    CGPoint center;
}
#pragma  mark - public method

- (instancetype)initWithFrame:(CGRect)frame withModels:(NSArray <PieModel*>*)ary{
    self = [super initWithFrame:frame];
    if (self) {
        [self stepDefin];
        [self stepData:ary];
        [self stepView];
        [self initAnimation];
    }
    return self;
}

- (void)reloadWithAry:(NSArray<PieModel *> *)ary{
    [_contentLayer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [_contentLayer removeFromSuperlayer];
    _contentLayer = nil;
    _path_Ary = [[NSMutableArray alloc]init];

    [self stepData:ary];
    [self stepView];
    [self initAnimation];
}

- (void)initAnimation{
    [self removeSelectStatus];
    [self.maskLayer removeAnimationForKey:@"starAnimation"];
    _contentLayer.mask = self.maskLayer;
    [self.maskLayer addAnimation:self.animation forKey:@"starAnimation"];
}

- (void)removeSelectStatus{
    [self.selectLayer removeFromSuperlayer];
    self.selectLayer = nil;
}

- (void)selectAtIndet:(NSInteger)index{
    [self didSelectedAtInt:index];
}

- (void)selectAtModel:(PieModel*)model{
    if (self.model_Ary && self.path_Ary) {
        NSInteger index = [self.model_Ary indexOfObject:model];
        [self selectAtIndet:index];
    }
}


#pragma mark - private method

- (void)stepDefin{
    _isSelect = YES;
    _isSelectAnimation = YES;
    curruePercent = 0;
    width  = self.frame.size.width;
    radius = self.frame.size.width/2;
    center = CGPointMake(self.frame.size.width/2, self.frame.size.width/2);
    _path_Ary = [[NSMutableArray alloc]init];
}

- (void)stepData:(NSArray *)ary{
    _model_Ary = [NSMutableArray arrayWithArray:ary];
    CGFloat sumCount = 0;
    
    //计算总和
    for (PieModel *model in _model_Ary) {
        sumCount += model.count;
    }
    //计算所占百分百
    for (int i = 0; i<_model_Ary.count; i++) {
        PieModel *model = _model_Ary[i];
        CGFloat percent = model.count/sumCount;
        model.percent = percent;
    }
}


#pragma mark - add layer

- (void)stepView{
    
    //扇形图 layer
    _contentLayer = [CALayer layer];
    _contentLayer.frame = self.bounds;
    [self.layer addSublayer:_contentLayer];
    
    for (int i = 0; i<_model_Ary.count; i++) {
        PieModel *model = _model_Ary[i];
        CGFloat star = curruePercent;
        CGFloat end  = model.percent+star;
        CGFloat startAngle = -M_PI_2+M_PI_2*4*star;
        CGFloat endAngle   = M_PI_2*4*end-M_PI_2;
        
        //记录已绘制百分百
        curruePercent +=model.percent;
        
        //绘制
        [self createLayerWithStartAngle:startAngle
                           endAngle:endAngle
                              color:model.color
                                  model:model];
        
        
    }
}

- (void)createLayerWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle color:(UIColor *)color model:(PieModel *)model{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:startAngle
                                                      endAngle:endAngle clockwise:YES];
    [path addLineToPoint:center];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = color.CGColor;
    [_contentLayer addSublayer:layer];
    [_path_Ary addObject:path];
    
    //标签坐标
    float r = width/4;
    CGFloat bLWidth = width/6+5 >= 45 ? 40 : width/6;
    CGFloat lab_x = center.x + (r + bLWidth/2) * cos((startAngle + (endAngle - startAngle)/2)) - bLWidth/2;
    CGFloat lab_y = center.y + (r + bLWidth*3/8) * sin((startAngle + (endAngle - startAngle)/2)) - bLWidth*3/8+3;
    
    //加字
    CATextLayer *textLayer = [[CATextLayer alloc]init];
    textLayer.frame = CGRectMake(lab_x, lab_y, bLWidth, bLWidth*3/4);
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.string = [NSString stringWithFormat:@"%.f%%",model.percent*100];
    textLayer.fontSize = width/15;
    textLayer.foregroundColor = [UIColor whiteColor].CGColor;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [_contentLayer addSublayer:textLayer];
}



#pragma  mark - toucheDelegate

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!self.isSelect) {return;}
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    //中间镂空圆范围不可点
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithArcCenter:center radius:width/10 startAngle:M_PI_2 endAngle:M_PI_2*4 clockwise:YES];
    
    //遍历点击的区域
    for (UIBezierPath *path in _path_Ary) {
        if ([path containsPoint:point] && ![rectPath containsPoint:point]) {
            NSInteger index =[_path_Ary indexOfObject:path];
            [self didSelectedAtInt:index];
            return;
        }
    }
}

- (void)didSelectedAtInt:(NSInteger)index{
    
    if (self.delegete && [self.delegete respondsToSelector:@selector(pie:didSelectedAtIndex:)]) {
        [self.delegete pie:self didSelectedAtIndex:index];
    }

    if (!self.isSelectAnimation) {return;}
    
    CGFloat sum = 0;
    if (index !=0) {
        for (int i = 0; i<index; i++) {
            PieModel *modle = [_model_Ary objectAtIndex:i];
            sum += modle.percent;
        }
    }
    PieModel *modle = [_model_Ary objectAtIndex:index];
    self.selectLayer.strokeStart = sum;
    self.selectLayer.strokeEnd = modle.percent+sum;
    self.selectLayer.strokeColor = modle.color.CGColor;
}



#pragma mark - lazyload


- (CABasicAnimation *)animation{
    if (!_animation) {
        CABasicAnimation *an = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        an.duration = 1;
        an.fromValue = @(0);
        an.toValue = @(1);
        an.removedOnCompletion = NO;
        an.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];;
        _animation = an;
    }
    return _animation;
}

- (CAShapeLayer *)maskLayer{
    if (!_maskLayer) {
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:radius
                                                        startAngle:-M_PI_2
                                                          endAngle:M_PI_2*3 clockwise:YES];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = [UIColor blackColor].CGColor;
        layer.lineWidth = width-width/5;
        _maskLayer = layer;
    }
    return _maskLayer;
}

- (CAShapeLayer *)selectLayer{
    if (!_selectLayer) {
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:radius
                                                        startAngle:-M_PI_2
                                                          endAngle:M_PI_2*3 clockwise:YES];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = [UIColor blackColor].CGColor;
        layer.lineWidth = radius/6;
        layer.opacity = 0.4;
        _selectLayer = layer;
        [_contentLayer insertSublayer:layer atIndex:0];
    }
    return _selectLayer;
}



@end
