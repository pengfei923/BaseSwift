//
//  NewCustomAnnotationView.h
//  MerchantToCustomer
//
//  Created by 闪电狗 on 2018/11/16.
//  Copyright © 2018 李鹏飞. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "NewCustomCalloutView.h"
@interface NewCustomAnnotationView : MAAnnotationView

@property (nonatomic, readonly) NewCustomCalloutView *calloutView;

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) UIImage *statusImage;

@end
