//
//  UIScrollView+RCEmpty.h
//  RCEmptyView
//
//  Created by RongCheng on 2018/3/27.
//  Copyright © 2018年 MBRB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EmptyView;
@interface UIScrollView (RCEmpty)
@property (nonatomic,strong)EmptyView *rc_emptyView;
@end
