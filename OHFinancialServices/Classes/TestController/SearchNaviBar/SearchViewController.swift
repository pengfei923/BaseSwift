//
//  SearchViewController.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/7.
//  Copyright © 2019 hoomsun. All rights reserved.
//

//import UIKit
//
//@available(iOS 11.0, *)
//class SearchViewController: BaseSwiftViewController {
//
//    var searchController : UISearchController = {
//
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.dimsBackgroundDuringPresentation = true
//        searchController.searchBar.sizeToFit()
//        searchController.searchBar.searchTextPositionAdjustment = UIOffset.init(horizontal: 10, vertical: 0)
//        return searchController
//    }()
//
//    private lazy var tableView : UITableView = {
//        let tableView = UITableView(frameSelf: UIView.fullScreenBounds(), style: .grouped)
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(UINib(nibName: "SecondNormalCell", bundle: nil), forCellReuseIdentifier: "SecondNormalCell")
//        return tableView
//    }()
//
//    let schoolArray = ["清华大学","北京大学","中国人民大学","北京交通大学","北京工业大学",
//                       "北京航空航天大学","北京理工大学","北京科技大学","中国政法大学",
//                       "中央财经大学","华北电力大学","北京体育大学","上海外国语大学","复旦大学",
//                       "华东师范大学","上海大学","河北工业大学"]
//
//    var searchArray:[String] = [String]() {
//        didSet {
//            self.tableView.reloadData()
//        }
//    }
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        if searchController.isActive {
//
//            UIView.animate(withDuration: 1) {
//                self.tableView.sectionHeaderHeight = 10
//            }
//        }
//    }
//
//    override func setupUI() {
//        super.setupUI()
//        searchController.searchResultsUpdater = self
//        navigationItem.searchController = searchController
//        navigationItem.hidesSearchBarWhenScrolling = true
//        view.addSubview(tableView)
//    }
//}
//
//@available(iOS 11.0, *)
//extension SearchViewController:UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        searchArray = schoolArray.filter({ (school) -> Bool in
//            return school.contains(searchController.searchBar.text!)
//        })
//    }
//}
//
//@available(iOS 11.0, *)
//extension SearchViewController:UITableViewDelegate,UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if searchController.isActive {
//            return searchArray.count
//        }else {
//            return schoolArray.count
//        }
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondNormalCell", for: indexPath) as! SecondNormalCell
//        cell.leftTitleLabel.text = ""
//        if searchController.isActive {
//            cell.titleLabel.text = searchArray[indexPath.row]
//        }else {
//            cell.titleLabel.text = schoolArray[indexPath.row]
//        }
//        cell.rightTitleLabel.text = ""
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        if searchController.isActive {
//            print("\(searchArray[indexPath.row])")
//        }else {
//            print("\(schoolArray[indexPath.row])")
//        }
//    }
//}
