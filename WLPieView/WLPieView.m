//
//  WLPieView.m
//  shareSDK_Demo
//
//  Created by wl on 2018/3/22.
//  Copyright © 2018年 https://github.com/orzzh. All rights reserved.
//

#import "WLPieView.h"
@interface WLPieView()<PieViewDelegate>
{
    UIView *_desview;
    UILabel *_deslbl;
}
@property (nonatomic,strong)PieView *pieview;
@property (nonatomic,copy)NSArray *pieAry;

@end
@implementation WLPieView

- (instancetype)initWithFrame:(CGRect)frame withModels:(NSArray <PieModel*>*)ary{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.pieAry = [NSArray arrayWithArray:ary];
    
        [self stepView];
        
    }
    return self;
}

- (void)stepView{
    
    [self addSubview:self.pieview];

    //循环添加标签
    CGFloat block_width = 30;
    CGFloat margin_space = 20;
    CGFloat margin_x = 40;
    CGFloat margin_y = 340;
    CGFloat width =  (self.frame.size.width-margin_x*2-3*margin_space)/4;
    
    for (int i =0; i<self.pieAry.count; i++) {
        PieModel *model = self.pieAry[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(margin_x+i%4*(margin_space+width), margin_y+i/4*(margin_space+30), block_width, block_width);
        btn.backgroundColor = model.color;
        btn.layer.cornerRadius = 5;
        btn.tag = i;
        [btn addTarget:self action:@selector(didSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(btn.frame.origin.x+block_width+2, btn.frame.origin.y, width, 30)];
        lbl.text = [NSString stringWithFormat:@"%@",model.title];
        lbl.textColor = [UIColor blackColor];
        [self addSubview:lbl];
    }
    
    //创建说明view
    _desview = [[UIView alloc]initWithFrame:CGRectMake(margin_x, 435, self.frame.size.width-margin_x*2, self.frame.size.height-415)];
    _desview.backgroundColor = [UIColor grayColor];
    _desview.layer.cornerRadius = 10;
    _desview.transform = CGAffineTransformMakeTranslation(0, _desview.frame.size.height);
    [self addSubview:_desview];
    
    _deslbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, _desview.frame.size.width-40, 30)];
    _deslbl.textColor = [UIColor whiteColor];
    [_desview addSubview:_deslbl];
    
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    b.frame =CGRectMake(0, 0, 100, 60);
    [b setTitle:@"重置动画" forState:UIControlStateNormal];
    [b setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [b addTarget:self action:@selector(animationadd) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:b];
    
}

- (void)animationadd{
    [self.pieview initAnimation];
    [self removeDesview];
}

#pragma mark - action

- (void)didSelect:(UIButton *)sender{
    
    //选中
    [self.pieview selectAtIndet:sender.tag];
//    [self.pieview selectAtModel:self.pieAry[sender.tag]];
}



#pragma mark - PieViewDelegate

- (void)pie:(PieView *)pieview didSelectedAtIndex:(NSInteger)index{
    
    PieModel *model = [self.pieAry objectAtIndex:index];
    _deslbl.text = [NSString stringWithFormat:@"%@:%@ %.f个 占%.f%%",model.title,model.descript,model.count,model.percent*100];
    
    [self addDesView];
}


- (void)addDesView{
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _desview.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {

    }];
}

- (void)removeDesview{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _desview.transform = CGAffineTransformTranslate(_desview.transform, 0, -5);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            _desview.transform = CGAffineTransformTranslate(_desview.transform,0, _desview.frame.size.height);
        }completion:nil];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];

    if (CGRectContainsPoint(_desview.frame, point)) {
        [self removeDesview];
    }
}


#pragma mark - lazyload

- (PieView *)pieview{
    if (!_pieview) {
        _pieview = [[PieView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-150, 20, 300, 300) withModels:self.pieAry];
        _pieview.delegete = self;
    }
    return _pieview;
}

@end
