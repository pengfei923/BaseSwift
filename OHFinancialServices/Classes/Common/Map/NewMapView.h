//
//  NewMapView.h
//  MerchantToCustomer
//
//  Created by 闪电狗 on 2018/11/16.
//  Copyright © 2018 李鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "NewCustomAnnotationView.h"
#import <AMapSearchKit/AMapSearchKit.h>

@interface NewMapView : UIView

@property (nonatomic,copy) void(^returnMessage)(NSString *name);

-(instancetype)initWithFrame:(CGRect)frame locationAnnotationPoint:(CGPoint)locationAnnotationPoint;

@end

