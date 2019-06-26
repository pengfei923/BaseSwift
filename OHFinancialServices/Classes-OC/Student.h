//
//  Student.h
//  OHFinancialServices
//
//  Created by hoomsun on 2019/6/26.
//  Copyright © 2019 hoomsun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StudentDelegate <NSObject>

@property (nonatomic,strong) NSString * _Nonnull name;

+(void)study;


@end

//void (^ _Nonnull MyBlockOne)(void) = ^(void) {
//
//};
//
//
//void (^ _Nonnull MyBlockTwo)(int a) = ^(int a) {
//
//};
//
//void (^ _Nonnull MyBlockThree)(int,int) = ^(int a,int b) {
//    return a + b;
//};
//
//void (^ _Nonnull MyBlockFour)(void) = ^(void) {
//    return @"这里是我返回的信息";
//};

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject

@property (nonatomic,weak) id<StudentDelegate> delegate;

@property (nonatomic,copy) void(^StudyBlock)(NSString *name);

+(instancetype)sharedInstance;

@property (nonatomic,copy) void(^returnMessage)(NSString *returnMessage);

@end

NS_ASSUME_NONNULL_END
