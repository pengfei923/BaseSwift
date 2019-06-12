//
//  NewCustomAnnotationView.m
//  MerchantToCustomer
//
//  Created by 闪电狗 on 2018/11/16.
//  Copyright © 2018 李鹏飞. All rights reserved.
//

#import "NewCustomAnnotationView.h"

@interface NewCustomAnnotationView()
@property (nonatomic, strong, readwrite) NewCustomCalloutView *calloutView;
@end

#define kCalloutHeight      30.0

@implementation NewCustomAnnotationView

- (void)setTitle:(NSString *)title {
    _title = title;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (self.selected == selected) {
        return;
    }
    CGFloat width = [self getWidthWithText:self.title height:20 font:14];
    if (selected) {
        if (self.calloutView == nil)
        {
            if (width == 0) {
                self.calloutView.hidden = YES;
            }else {
                self.calloutView.hidden = NO;
                if (self.statusImage) {
                    self.calloutView = [[NewCustomCalloutView alloc]initWithFrame:CGRectMake(0, 0, width + 40, kCalloutHeight) width:width];
                }else {
                    self.calloutView = [[NewCustomCalloutView alloc]initWithFrame:CGRectMake(0, 0, width + 20, kCalloutHeight) width:width];
                }
            }
        }
        [self setupUIWithWidth:width];
        
        self.calloutView.width = width;
        self.calloutView.image = self.statusImage;
        self.calloutView.title = self.title;
        [self addSubview:self.calloutView];
    }else {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

-(void)setupUIWithWidth:(CGFloat)width {
    CGRect calloutViewFrame = self.calloutView.frame;
    if (self.statusImage) {
        calloutViewFrame.size = CGSizeMake(width + 40, kCalloutHeight);
    }else {
        calloutViewFrame.size = CGSizeMake(width + 20, kCalloutHeight);
    }
    
    self.calloutView.frame = calloutViewFrame;
    self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,-CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
    self.calloutView.layer.cornerRadius = self.calloutView.frame.size.height / 2;
    self.calloutView.layer.masksToBounds = YES;
}

//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}

@end
