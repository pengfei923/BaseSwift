//
//  OHRepayFirstViewController.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/6/12.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class OHRepayFirstViewController: BaseSwiftViewController {

    var list = [1,2,3,4,5,6,7,8]
    var bookAmuont = ["harrypotter":100,"junglebook":200]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func setupUI() {
        super.setupUI()
        loadDataFinished()
        
//        let newList = list.map { (value) -> String in
//            return "\(value * 10)"
//        }
        let newList = list.map({$0 * 10})
        let newBookAmount = bookAmuont.map { (key,value) in
            return key.capitalized
        }
        let indexList = list.enumerated().map { (index,item) in
        }
        
        let bList = list.filter { (value) -> Bool in
            return value % 2 == 0
        }
        
        let bBookAmount = bookAmuont.filter { (key,value) -> Bool in
            return value > 150
        }
        
        let cList = list.reduce(0) { (x, y) in
            return x + y;
        }
        
        print(cList)
        
        
        
        print(bBookAmount)
        
        print(bList)
        
        print(indexList)
        
        print(newBookAmount)
        
        print(newList)
    }
}


struct Celsius {
    var temperatureInCelsius : Double
    init(fromFahrenheit fahrenheit:Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
}
