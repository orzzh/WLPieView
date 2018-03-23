//
//  PieView.h
//  shareSDK_Demo
//
//  Created by wl on 2018/3/22.
//  Copyright © 2018年 https://github.com/orzzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieModel.h"

@class PieView;

@protocol PieViewDelegate<NSObject>

- (void)pie:(PieView *)pieview didSelectedAtIndex:(NSInteger)index;

@end



@interface PieView : UIView

@property (nonatomic,weak)id<PieViewDelegate> delegete;
@property (nonatomic,assign)BOOL isSelect; //是否可点击 默认yes
@property (nonatomic,assign)BOOL isSelectAnimation; //是否点击效果 默认yes

- (instancetype)initWithFrame:(CGRect)frame withModels:(NSArray <PieModel*>*)ary;

//刷新
- (void)reloadWithAry:(NSArray <PieModel*>*)ary;

//选中当前Index
- (void)selectAtIndet:(NSInteger)index;

//选择当前model
- (void)selectAtModel:(PieModel*)model;

//重置动画
- (void)initAnimation;

//移除选中状态
- (void)removeSelectStatus;

@end
