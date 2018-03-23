//
//  ViewController.m
//  WLPieView
//
//  Created by wl on 2018/3/23.
//  Copyright © 2018年 https://github.com/orzzh. All rights reserved.
//

#import "ViewController.h"

#import "WLPieView.h"
#define PNLightGreen    [UIColor colorWithRed:77.0 / 255.0 green:216.0 / 255.0 blue:122.0 / 255.0 alpha:1.0f]
#define PNFreshGreen    [UIColor colorWithRed:77.0 / 255.0 green:196.0 / 255.0 blue:122.0 / 255.0 alpha:1.0f]
#define PNDeepGreen     [UIColor colorWithRed:77.0 / 255.0 green:176.0 / 255.0 blue:122.0 / 255.0 alpha:1.0f]
#define PNRed           [UIColor colorWithRed:245.0 / 255.0 green:94.0 / 255.0 blue:78.0 / 255.0 alpha:1.0f]
#define PNMauve         [UIColor colorWithRed:88.0 / 255.0 green:75.0 / 255.0 blue:103.0 / 255.0 alpha:1.0f]
#define PNBrown         [UIColor colorWithRed:119.0 / 255.0 green:107.0 / 255.0 blue:95.0 / 255.0 alpha:1.0f]
#define PNBlue          [UIColor colorWithRed:82.0 / 255.0 green:116.0 / 255.0 blue:188.0 / 255.0 alpha:1.0f]
#define PNDarkBlue      [UIColor colorWithRed:121.0 / 255.0 green:134.0 / 255.0 blue:142.0 / 255.0 alpha:1.0f]
#define PNYellow        [UIColor colorWithRed:242.0 / 255.0 green:197.0 / 255.0 blue:117.0 / 255.0 alpha:1.0f]
#define PNWhite         [UIColor colorWithRed:255.0 / 255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1.0f]
#define PNDeepGrey      [UIColor colorWithRed:99.0 / 255.0 green:99.0 / 255.0 blue:99.0 / 255.0 alpha:1.0f]
#define PNPinkGrey      [UIColor colorWithRed:200.0 / 255.0 green:193.0 / 255.0 blue:193.0 / 255.0 alpha:1.0f]
#define PNHealYellow    [UIColor colorWithRed:245.0 / 255.0 green:242.0 / 255.0 blue:238.0 / 255.0 alpha:1.0f]
#define PNLightGrey     [UIColor colorWithRed:225.0 / 255.0 green:225.0 / 255.0 blue:225.0 / 255.0 alpha:1.0f]

@interface ViewController ()
{
    WLPieView *v;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self addpie];
    
    
//    [self add1];
//    [self add2];
}
- (void)addpie{
    
    PieModel *mo = [[PieModel alloc]init];
    mo.count = 150;
    mo.title = @"面包";
    mo.descript = @"全麦面包";
    mo.color = PNBlue;
    
    PieModel *mo1 = [[PieModel alloc]init];
    mo1.count = 20;
    mo1.title = @"威化饼";
    mo1.descript = @"巧克力威化";
    mo1.color = PNDeepGreen;
    
    PieModel *mo2 = [[PieModel alloc]init];
    mo2.count = 140;
    mo2.title = @"饼干";
    mo2.descript = @"葱油味饼干";
    mo2.color = PNYellow;
    
    PieModel *mo3 = [[PieModel alloc]init];
    mo3.count = 90;
    mo3.title = @"巧克力";
    mo3.descript = @"榛子味巧克力";
    mo3.color = PNBrown;
    
    PieModel *mo4 = [[PieModel alloc]init];
    mo4.count = 120;
    mo4.title = @"牛奶";
    mo4.descript = @"脱脂牛奶";
    mo4.color = PNMauve;
    
    v = [[WLPieView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 500) withModels:@[mo,mo1,mo2,mo3,mo4]];
    v.center = self.view.center;
    v.backgroundColor = [UIColor colorWithRed:244/255.f green:244/255.f blue:244/255.f alpha:1];
    [self.view addSubview:v];
    
}

- (void)pie:(PieView *)pieview didSelectedAtIndex:(NSInteger)index{
    NSLog(@"选中了 %zd",index);
}








- (void)add1{
    
    NSString *str = @"空间看了好几块";
    CGSize size = [str boundingRectWithSize:CGSizeMake(400, 100) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30.0]} context:nil].size;
    
    CATextLayer *lary = [CATextLayer layer];
    lary.string = @"空间看了好几块";
    lary.bounds = CGRectMake(0, 0, size.width, size.height);
    //    lary.font = (__bridge CFTypeRef)(@"HiraKakuProN-W3");//字体的名字 不是 UIFont
    lary.fontSize = 30.f;//字体的大小
    //    lary.backgroundColor = [UIColor grayColor].CGColor;
    lary.wrapped = YES;//默认为No.  自动换行
    lary.alignmentMode = kCAAlignmentCenter;//字体的对齐方式
    lary.truncationMode = kCATruncationEnd; //超出范围结尾裁剪
    lary.position = CGPointMake(130, 410);//layer在view的位置 适用于跟随摸一个不固定长的的控件后面需要的
    lary.contentsScale = [UIScreen mainScreen].scale;//解决文字模糊 以Retina方式来渲染，防止画出来的文本像素化
    lary.foregroundColor =[UIColor blackColor].CGColor;//字体的颜色 文本颜色
    [self.view.layer addSublayer:lary];
}
- (void)add2{
    NSString *str = @"空间看了好几块";
    CGSize size = [str boundingRectWithSize:CGSizeMake(400, 100) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30.0]} context:nil].size;
    
    CATextLayer *lary = [CATextLayer layer];
    lary.string = @"空间看了好几块";
    lary.bounds = CGRectMake(0, 0, size.width, size.height);
    //    lary.font = (__bridge CFTypeRef)(@"HiraKakuProN-W3");//字体的名字 不是 UIFont
    lary.fontSize = 30.f;//字体的大小
    //    lary.backgroundColor = [UIColor grayColor].CGColor;
    lary.wrapped = YES;//默认为No.  自动换行
    lary.alignmentMode = kCAAlignmentCenter;//字体的对齐方式
    lary.truncationMode = kCATruncationEnd; //超出范围结尾裁剪
    lary.position = CGPointMake(130, 410);//layer在view的位置 适用于跟随摸一个不固定长的的控件后面需要的
    lary.contentsScale = [UIScreen mainScreen].scale;//解决文字模糊 以Retina方式来渲染，防止画出来的文本像素化
    lary.foregroundColor =[UIColor orangeColor].CGColor;//字体的颜色 文本颜色
    //    lary.sca
    [self.view.layer addSublayer:lary];
    
    //shapeLayer 路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, lary.frame.size.height/2)];
    [path addLineToPoint:CGPointMake(lary.frame.size.width, lary.frame.size.height/2)];
    
    //shapeLayer 必须有路径
    CAShapeLayer *la = [CAShapeLayer layer];
    la.path = path.CGPath;
    la.strokeColor = [UIColor whiteColor].CGColor;
    la.strokeStart = 0;
    la.strokeEnd = 0.1;
    la.lineWidth = lary.frame.size.height;
    lary.mask = la;
    
    CABasicAnimation *an = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    an.duration = 5.0f;
    an.repeatCount = 10;
    an.fromValue = @(0.1);
    an.toValue = @(1);
    [la addAnimation:an forKey:@"sd"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
