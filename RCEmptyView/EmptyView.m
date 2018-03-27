//
//  EmptyView.m
//  RCEmptyView
//
//  Created by RongCheng on 2018/3/27.
//  Copyright © 2018年 MBRB. All rights reserved.
//

#import "EmptyView.h"

@interface EmptyView ()
@end;

@implementation EmptyView{
    UILabel *_titleLab;
    UIImageView *_img;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth |  UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    }
    return self;
}

- (void)setupImage:(NSString *)image title:(NSString *)title{
    _titleLab = [[UILabel alloc]init];
    
    _titleLab.text = title;
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.numberOfLines = 0;
    _titleLab.textColor = [UIColor redColor];
    _titleLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:_titleLab];
    
    UIImageView *_img = [[UIImageView alloc]init];
    
    _img.image = [UIImage imageNamed:image];
    _img.contentMode = UIViewContentModeCenter;
    [self addSubview:_img];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _titleLab.bounds = CGRectMake(0, 0, ceilf(self.frame.size.width*0.6), 40);
    _titleLab.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
    
    _img.bounds = CGRectMake(0, 0, 120, 120);
    _img.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5-60);
}
+ (instancetype)emptyWithImage:(NSString *)image title:(NSString *)title{
    EmptyView *emptyView = [[self alloc]init];
    [emptyView setupImage:image title:title];
    return emptyView;
}


@end
