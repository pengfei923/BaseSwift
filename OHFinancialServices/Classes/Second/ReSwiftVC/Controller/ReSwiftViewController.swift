//
//  ReSwiftViewController.swift
//  DouYuSwift
//
//  Created by hoomsun on 2019/4/15.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import RxAlamofire

struct MusicListViewModel {
    let data = Observable.just([
        Music(name: "吻别", singer: "张学友"),
        Music(name: "爱你一万年", singer: "李宇春"),
        Music(name: "心爱的你", singer: "胡彦斌"),
        Music(name: "之心恋人", singer: "黄健翔")
        ])
}

class ReSwiftViewController: BaseViewController {
    
    let musicListViewModel = MusicListViewModel()
    
    let disposeBag = DisposeBag()
    
    let observable = Observable.of([1,2,3,4,5])
    let inverval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
    let timer = Observable<Int>.timer(1, period: 1, scheduler: MainScheduler.instance)
    
    let subject = PublishSubject<String>()
    
    
    private lazy var tableView : UITableView = {
        let tableVeiw = UITableView(rect: UIView.fullScreenBounds(), style: .grouped)
        tableVeiw.register(UINib(nibName: "ReSwiftNormalCell", bundle: nil), forCellReuseIdentifier: "ReSwiftNormalCell")
        return tableVeiw
    }()

    private lazy var textField : UITextField = {
        let textField = UITextField(placeHolder: "请在这里输入基本的信息", frame: CGRect(x: 20, y: 100, width: kScreenW - 40, height: 40))
        return textField
    }()
    
    
    private lazy var btn : UIButton = {
        let btn = UIButton(title: "点击按钮", frame: CGRect(x: 20, y: 160, width: kScreenW - 40, height: 44), corner: 5);
        return btn
    }()
    
    private lazy var label : UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 220, width: kScreenW - 40, height: 44))
        label.backgroundColor = UIColor.white
        label.textColor = UIColor.red
        return label
    }()
    
    private lazy var pwdTextField : UITextField = {
        let pwdTextField = UITextField(placeHolder: "请在这里密码信息", frame: CGRect(x: 20, y: 300, width: kScreenW - 40, height: 40))
        return pwdTextField
    }()
    
    private lazy var allStudents : [String] = {
        let allStudents = ["li","peng","fei","gao","xiao","qing","jenny"]
        return allStudents;
    }()
    
    private lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 56))
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadDataFinished()
//
//        selectData()
//        clickButton()
//        textFieldSet()
        rxTableViewData()
//        textObservable()
        
        
//        Observable.of(1,2,3,4,5,6,7,8,9,0).filter{
//            $0 > 5
//            }.subscribe(onNext: { (num) in
//                print(num)
//            }, onError: { (error) in
//                print(error)
//            }, onCompleted: nil, onDisposed: nil)
        
        Observable.of(1,2,3,4,5,5,5,6,7,8,8,8,8,4).distinctUntilChanged().subscribe(onNext: { (num) in
            print(num)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
//        Observable.of(1,2,3,4).elementAt(2).subscribe(onNext: { (num) in
//            print("这里是我返回的信息\(num)")
//        }, onError: { (error) in
//            print("返回错误信息")
//        }, onCompleted: {
//
//        }) {
//            self.disposeBag
//        }
        
        
        Observable.of(1,2,3,4,5).reduce(0, accumulator: +)
            .subscribe { (event) in
                print("这里是我返回的信息1111:\(event)")
        }.disposed(by: disposeBag)
        
    }
    
}



extension ReSwiftViewController {
    override func setupUI() {
        super.setupUI()
        
        tableView.tableHeaderView = searchBar
        view.addSubview(tableView)
        
//        view.addSubview(textField)
//        view.addSubview(btn)
//        view.addSubview(label)
//        view.addSubview(pwdTextField)
//        textField.rx.text.orEmpty.asObservable().subscribe(onNext: { (string) in
//            print(string)
//        }, onError: { (error) in
//
//        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
//        textField.rx.text.changed.subscribe(onNext: { (event) in
//            print(event)
//        }).disposed(by: disposeBag)
        
//        textField.rx.text.orEmpty.bind(to: label.rx.text)
        
        
        _ = textField.rx.text.orEmpty.bind(to: pwdTextField.rx.text)
        _ = textField.rx.text.orEmpty.map{"当前字数\($0.count)"}
        .bind(to: label.rx.text)
        _ = textField.rx.text.orEmpty.map{$0.count > 10 && $0.count < 21}
            .subscribe(onNext: { [weak self](bool) in
                self?.btn.isEnabled = bool
                self?.btn.backgroundColor = bool == true ? UIColor.red : UIColor.gray
            }, onError: {(error) in
                print(error)
            }).disposed(by: disposeBag)
        
//        textField.rx.controlEvent([.editingDidBegin]).asObservable().subscribe(onNext: { (_) in
//            print("开始编辑")
//        }, onError: { (error) in
//
//        }).disposed(by: disposeBag)
        textField.rx.controlEvent([.editingDidEnd]).asObservable().subscribe(onNext: { (_) in
            self.pwdTextField.becomeFirstResponder()
        }, onError: { (error) in
            
        }).disposed(by: disposeBag)
        
        pwdTextField.rx.controlEvent([.editingDidEnd]).asObservable().subscribe(onNext: { (_) in
            self.pwdTextField.resignFirstResponder()
        }, onError: { (error) in
            
        }).disposed(by: disposeBag)
        
    }
}



extension ReSwiftViewController {
    
    private func ObservableData() {
        _ = Observable<Int>.of(0,1,2,3,4,5,6,7).groupBy(keySelector: {(e) -> String in
            return e % 2 == 0 ? "偶数" : "奇数"
        }).subscribe{(e) in
            switch e {
            case .next(let group) :
                _ = group.asObservable().subscribe({(e) in
                    print("key:\(group.key) value\(e.element ?? 0)")
                })
            default:print("")
            }
            }.disposed(by: disposeBag)
        
        _ = Observable.of(1,2,3).map{$0 * 10}
            .subscribe(onNext: { (a) in
                print(a)
            }, onError: { (error) in
                print(error)
            }, onCompleted: {
                
            }, onDisposed: nil)
        
        subject.onNext("1111")
        _ = subject.subscribe(onNext: { (string) in
            print("第一次订阅:",string)
        }, onError: { (error) in
            
        }, onCompleted: {
            print("1111完成")
        }, onDisposed: nil)
        
        subject.onNext("22222")
        subject.subscribe(onNext: { (string) in
            print("第二次订阅:",string)
        }, onError: { (error) in
            
        }, onCompleted: {
            print("2222完成")
        }, onDisposed: nil)
    }
}

extension ReSwiftViewController {
    private func textObservable() {
        _ = observable.subscribe { (event) in
            
        }.disposed(by: disposeBag)
        
//        inverval
//            .map { "当前索引数：\(60 - $0 )"}
//            .bind { [weak self](text) in
//                //收到发出的索引数后显示到label上
//                self?.label.text = text
//
//                print(text)
//            }
//            .disposed(by: disposeBag)
        
        _ = timer.subscribe(onNext: { (event) in
            print("李鹏飞:\(60 - event)")
        }, onError: { (error) in
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
     
        inverval.map{"当前索引数\(60 - $0)"}
        .bind(to: label.rx.text)
        .disposed(by: disposeBag)
        
        
        
        
//        inverval.map{CGFloat($0)}.bind(to: label.rx.fontSize).disposed(by: disposeBag)
        
//        let binder : Binder<String> = Binder(label) { (view, text) in
//            view.text = text
//        }
        
        Observable.of(1,2,1).delay(3, scheduler: MainScheduler.instance).subscribe { (event) in
            print("这里+++++++\(event)")
        }.disposed(by: disposeBag)
        
        
    }
}

extension ReSwiftViewController {
    private func rxTableViewData() {
        
        self.tableView.mj_header = MJRefreshNormalHeader()
        let viewModel = ViewModel(headerRefresh: self.tableView.mj_header.rx.refreshing.asDriver())
        viewModel.tableData.asDriver().drive(tableView.rx.items) { (tableView,row,element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReSwiftNormalCell") as! ReSwiftNormalCell
            cell.leftLabel.text = "\(row + 1)\(element)"
            return cell
        }.disposed(by: disposeBag)
        
        
        viewModel.endHeaderRefreshing.drive(tableView.mj_header.rx.endRefreshing).disposed(by: disposeBag)
        
//        viewModel.tableData.asDriver().drive(tableView.rx.items) {
//
//        }
        
        
//        let urlString = "https://www.douban.com/j/app/radio/channels"
//        let url = URL(string: urlString)
//        let request = URLRequest(url: url!)
//
//        let data = URLSession.shared.rx.json(request: request).map{result -> [[String : Any]] in
//            if let data = result as? [String: Any],
//                let channels = data["channels"] as? [[String: Any]] {
//                return channels
//            }else{
//                return []
//            }
//        }
//
//
//        data.bind(to: tableView.rx.items) { (tableView ,row , element) in
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ReSwiftNormalCell") as? ReSwiftNormalCell
//            cell?.rightLabel.text = "项目名称\(element["name"] ?? "")"
//            cell?.leftLabel.text = "编号信息\(element["channel_id"] ?? "")"
//            return cell!
//        }.disposed(by: disposeBag)
        
    
        
    
        
        
        
//        _ = musicListViewModel.data.bind(to: tableView.rx.items(cellIdentifier: "ReSwiftNormalCell",cellType: ReSwiftNormalCell.self)) {
//            _ , music,cell in
//
//            cell.accessoryType = .disclosureIndicator
//            cell.leftLabel?.text = music.name
//            cell.rightLabel?.text = music.singer
//
//        }.disposed(by: disposeBag)
//
//        _ = tableView.rx.modelSelected(Music.self).subscribe { (music) in
//            print("你选中的歌曲信息是\(music)")
//        }.disposed(by: disposeBag)

//        _ = tableView.rx.itemSelected.subscribe(onNext: { [weak self](indexPath) in
//            self!.tableView.deselectRow(at: indexPath, animated: true)
//
//        }, onError: { (error) in
//
//        }).disposed(by: disposeBag)
        
    
    }
    
}

extension ReSwiftViewController {
    private func textFieldSet() {
        
//        let text = textField.rx.text.orEmpty.asObservable()
//        text.subscribe { (nil) in
//            print("这里是我展示的问题\(text)")
//        }
        
        _ = textField.rx.text.subscribe(onNext: {(string) in
            print("\(string ?? "")")
            
        }, onError: { (error) in
            
        }, onCompleted: nil, onDisposed: nil)
        
        _ = textField.rx.text.orEmpty.map{$0.count > 5 && $0.count < 11}.share(replay: 1).subscribe(onNext: { [weak self](bool) in
            self?.btn.isEnabled = bool
            self?.btn.backgroundColor = bool == true ? UIColor.red : UIColor.gray
            }, onError: { (error) in
                
        }, onCompleted: nil, onDisposed: nil)
        
        _ = textField.rx.text.orEmpty.bind(to: label.rx.text)
        
        
        let btnEnabled = btn.rx.isEnabled;
        print("按钮是否可以被点击\(btnEnabled)")

    }
}

extension ReSwiftViewController {
    private func clickButton() {
        _ = btn.rx.tap.asObservable().subscribe { (nil) in
            
            print("button的点击事件\(self.textField.text ?? "")")
        }
    }
}

extension ReSwiftViewController {
    private func selectData() {
        print("这里一共有多少个学生:\(allStudents.count)")
        // 从所有数据选择出合适的数据
        let selectStudnet = allStudents.filter { (student) -> Bool in
            //            student.contains("n")
            student.count > 3
        }
        selectStudnet.forEach { (stu) in
            print("\(stu)都应该唱歌")
        }
        print("这里是选择的学生\(selectStudnet)")
    }
}

