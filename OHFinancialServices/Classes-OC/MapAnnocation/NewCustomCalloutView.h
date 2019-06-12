//
//  NewCustomCalloutView.h
//  MerchantToCustomer
//
//  Created by 闪电狗 on 2018/11/16.
//  Copyright © 2018 李鹏飞. All rights reserved.
//

#import "BaseCustomCalloutView.h"

@interface NewCustomCalloutView : UIView
///起始位置图片
@property (nonatomic,strong) UIImage *image;
///位置title
@property (nonatomic,copy) NSString *title;

-(instancetype)initWithFrame:(CGRect)frame width:(CGFloat)width;

@property (nonatomic,assign) CGFloat width;

@end

