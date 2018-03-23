//
//  PieModel.h
//  shareSDK_Demo
//
//  Created by wl on 2018/3/22.
//  Copyright © 2018年 https://github.com/orzzh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PieModel : NSObject

@property (nonatomic,copy)NSString *title;      //标题
@property (nonatomic,copy)NSString *descript;   //描述
@property (nonatomic,assign)CGFloat count;      //总数
@property (nonatomic,assign)CGFloat percent;    //百分比
@property (nonatomic,strong)UIColor *color;
@end
