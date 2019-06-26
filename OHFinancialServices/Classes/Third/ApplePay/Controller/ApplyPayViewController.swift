//
//  ApplyPayViewController.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/6/26.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit
import StoreKit
class ApplyPayViewController: BaseSwiftViewController {

    
    var productID : String!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productID = "1498173591743985"
        setupUI()
        
        
    }
    
    override func setupUI() {
        super.setupUI()
        loadDataFinished()
        SKPaymentQueue.default().add(self as SKPaymentTransactionObserver)
        gotoApplePay()
    }
    
    deinit {
        
    }
    
    //验证是否可以内购
    func gotoApplePay() {
        if SKPaymentQueue.canMakePayments() {
            // 验证通过
            self.requestProductId()
        }else {
            print("暂时无法购买")
        }
    }
    
    func requestProductId() {
        let productArr:[String] = [productID]
        let sets = NSSet.init(array: productArr) as! Set<String>
        let skRequest = SKProductsRequest.init(productIdentifiers: sets)
        skRequest.delegate = self as SKProductsRequestDelegate
        skRequest.start()
        
    }
    
}


extension ApplyPayViewController:SKProductsRequestDelegate,SKPaymentTransactionObserver {
    //支付状态的回调
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:SKPaymentTransaction in transactions {
            print("返回的状态\(transaction.transactionState)");
        }
        
    }
    //商品请求成功的回调
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products
        for item:SKProduct in products {
            if item.productIdentifier == self.productID {
                self.buyProduct(item)
            }
        }
    }
    
    func buyProduct(_ product:SKProduct){
        let skpay:SKPayment = SKPayment.init(product: product)
        SKPaymentQueue.default().add(skpay)
    }
    
    //获取支付成功的凭证
    func buyAppleProductSuccessWithPaymnetTransaction(_ paymentTransaction:SKPaymentTransaction) {
        let url = Bundle.main.appStoreReceiptURL
        let appstoreRequest = URLRequest.init(url: url!)
        do {
            let reciptaData = try NSURLConnection.sendSynchronousRequest(appstoreRequest, returning: nil)
            let transactionRecipsting:String = reciptaData.base64EncodedString(options: .endLineWithLineFeed)
            self.checkAppstorePayResultWithBase64String(transactionRecipsting)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func checkAppstorePayResultWithBase64String(_ base64String:String) {
        print("这里是往t后台传入的信息")
    }
}
