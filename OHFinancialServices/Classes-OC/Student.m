//
//  Student.m
//  OHFinancialServices
//
//  Created by hoomsun on 2019/6/26.
//  Copyright © 2019 hoomsun. All rights reserved.
//

#import "Student.h"



@implementation Student

+(instancetype)sharedInstance {
    static Student * _shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[self alloc]init];
    });
    return _shareInstance;
}



@end
