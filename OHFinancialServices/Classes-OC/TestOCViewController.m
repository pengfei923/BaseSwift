//
//  TestOCViewController.m
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/5.
//  Copyright © 2019 hoomsun. All rights reserved.
//

#import "TestOCViewController.h"
#import <StoreKit/StoreKit.h>
@interface TestOCViewController ()<SKProductsRequestDelegate,SKPaymentTransactionObserver>
@property (nonatomic,copy) void(^returnMessage)(NSString *message);
@end

@implementation TestOCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    int (^sum)(int,int);
    
    sum = ^int (int a, int b) {
        return a + b;
    };
    
    int a = sum(10,20);
    NSLog(@"%d", a);
}

-(void)dealloc {
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

-(void)vilidataIsCanBought {
    if ([SKPaymentQueue canMakePayments]) {
        [self getProductInfo:@[@"productIds"]];
    }else {
        
    }
}

-(void)getProductInfo:(NSArray *)productIds {
    NSSet *set = [NSSet setWithArray:productIds];
    SKProductsRequest *request = [[SKProductsRequest alloc]initWithProductIdentifiers:set];;
    request.delegate = self;
    [request start];
}

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSArray *myProducts = response.products;
    if (myProducts.count == 0) {
        NSLog(@"购买产品失败");
        return;
    }
    
    SKPayment *payment = [SKPayment paymentWithProduct:myProducts[0]];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

// 当用户i交易触发下面的回调的时候就会进行相应的处理
-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(nonnull NSArray<SKPaymentTransaction *> *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased: // 交易完成
                
                break;
            case SKPaymentTransactionStateFailed: // 交易失败
                
                break;
            case SKPaymentTransactionStateRestored: // 已经购买过商品
                
                break;
            case SKPaymentTransactionStatePurchasing: // 商品添加进列表
                
                break;
            default:
                break;
        }
    }
}


@end
