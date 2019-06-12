//
//  NewCustomCalloutView.m
//  MerchantToCustomer
//
//  Created by 闪电狗 on 2018/11/16.
//  Copyright © 2018 李鹏飞. All rights reserved.
//

#import "NewCustomCalloutView.h"
#import "UIView+Frame.h"
@interface NewCustomCalloutView()
@property (nonatomic,strong) UIImageView *portraitView; //图片
@property (nonatomic,strong) UILabel *titleLabel; //标题

@end
#define kArrorHeight        0

#define kPortraitMargin     5
#define kPortraitWidth      20
#define kPortraitHeight     14

#define kTitleWidth         180
#define kTitleHeight        20

@implementation NewCustomCalloutView

-(instancetype)initWithFrame:(CGRect)frame width:(CGFloat)width {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = width;
        [self initSubViews];
    }
    return self;
}

-(void)setTitle:(NSString *)title {
    _title = title;
    [self refreshUIWithTitle:_title];
    self.titleLabel.text = title;
}

-(void)setImage:(UIImage *)image {
    _image = image;
    [self refreshUIWithImage:_image];;
    self.portraitView.image = image;
}

-(UIImageView *)portraitView {
    if (!_portraitView) {
        _portraitView = [[UIImageView alloc] initWithFrame:CGRectMake(kPortraitMargin, kPortraitMargin, kPortraitWidth, kPortraitWidth)];
//        _portraitView.image = [UIImage imageNamed:@"ic_point"];
        _portraitView.layer.cornerRadius = kPortraitWidth/2.0f;
        _portraitView.layer.masksToBounds = YES;
    }
    return _portraitView;
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _titleLabel.textColor = UIColor.blackColor;
        
        _titleLabel.frame = CGRectMake(kPortraitMargin * 2 + kPortraitWidth, kPortraitMargin, self.width, kTitleHeight);
    }
    return _titleLabel;
}

-(void)initSubViews {
    [self addSubview:self.portraitView];
    [self addSubview:self.titleLabel];
}

-(void)refreshUIWithTitle:(NSString *)titleStr {
    CGFloat width = [self getWidthWithText:titleStr height:kTitleHeight font:14];
    CGRect titleLabelFrame = self.titleLabel.frame;
    titleLabelFrame.size = CGSizeMake(width, kTitleHeight);
    self.titleLabel.frame = titleLabelFrame;
}

-(void)refreshUIWithImage:(UIImage *)image {
    if (image) {
        self.titleLabel.origin = CGPointMake(kPortraitMargin * 2 + kPortraitWidth, kPortraitMargin);
    }else {
        self.titleLabel.origin = CGPointMake(kPortraitMargin * 2, kPortraitMargin);
    }
}

#pragma mark - draw rect

- (void)drawRect:(CGRect)rect
{
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor whiteColor] CGColor];
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

- (void)drawInContext:(CGContextRef)context
{
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
    
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 0.0f;
    CGFloat minx = CGRectGetMinX(rrect);
    CGFloat midx = CGRectGetMidX(rrect);
    CGFloat maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
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
