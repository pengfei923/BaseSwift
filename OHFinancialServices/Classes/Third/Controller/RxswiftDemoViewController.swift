//
//  RxswiftDemoViewController.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/6/17.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

struct Music {
    let name : String
    let singer : String
    
    init(name:String,singer:String) {
        self.name = name
        self.singer = singer
    }
}

extension Music : CustomStringConvertible {
    var description: String {
        return "name:\(name) singer:\(singer)"
    }
}

struct MusicListViewModel {
    let data = Observable.just([
        Music(name: "李鹏飞", singer: "李鹏飞"),
        Music(name: "高晓青", singer: "飞翔"),
        Music(name: "从前的你", singer: "马大哈"),
        Music(name: "我心飞翔", singer: "高健"),
    ])
}

class RxswiftDemoViewController: BaseSwiftViewController {
    
    private lazy var label : UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 100, width: kScreenW - 40, height: 40))
        label.textColor = UIColor.red
        label.text = "helloWorld"
        return label
    }()
    private lazy var textField : UITextField = {
        let textField = UITextField(placeHolder:"placeHolder", frame: CGRect(x: 20, y: 160, width: kScreenW - 40, height: 40))
        
        return textField
    }()
    private lazy var textField1 : UITextField = {
        let textField1 = UITextField(placeHolder:"placeHolder1", frame: CGRect(x: 20, y: 210, width: kScreenW - 40, height: 40))
        
        return textField1
    }()
    
    private lazy var button : UIButton = {
        let button = UIButton(title: "确定", frame: CGRect(x: 20, y: 270, width: kScreenW - 40, height: 50), corner: 5)
        return button
    }()
    
    let disposed = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        title = "RxSwift测试"
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(textField1)
    }
    
    override func setupUI() {
        super.setupUI()
        loadDataFinished()
        let tableView = UITableView()
        
        
    }
}

extension Reactive where Base:UILabel {
    public var fontSize:Binder<CGFloat> {
        return Binder(self.base) {label,fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}
