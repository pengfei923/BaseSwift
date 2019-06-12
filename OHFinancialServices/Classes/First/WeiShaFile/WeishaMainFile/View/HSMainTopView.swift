//
//  HSMainTopView.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/8.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class HSMainTopView: UIView {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userPhoneLabel: UILabel!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var userNameCenterConstraint: NSLayoutConstraint! /// userNameLable center距离中心点的位置
    
    
    typealias clickItem = (IndexPath) -> ()
    var block : clickItem?
    
    private var loginInfo : LoginInfo = LoginInfo()
    
    class  func setMainTopView() -> HSMainTopView {
        let topView = Bundle.main.loadNibNamed("HSMainTopView", owner: nil, options: nil)?.last as! HSMainTopView
        topView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 250)
        topView.setCollectionView()
        topView.setUI()
        topView.settingBtn.backgroundColor = UIColor.green;
        return topView
    }

}

extension HSMainTopView {
    private func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: (kScreenW - 40)/3, height: self.collectionView.frame.height)
        collectionView.register(UINib(nibName: "MainTopNormalCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MainTopNormalCollectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = layout
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false;

    }
}


extension HSMainTopView {
    func setUI() {
        iconImageView.isUserInteractionEnabled = true
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = iconImageView.frame.height/2
        if ((loginInfo.savedUserInfo()?.phone) != nil) {
            userNameCenterConstraint.constant = -20;
            userPhoneLabel.isHidden = false
            userNameLabel.text = loginInfo.savedUserInfo()?.custname ?? ""
            userPhoneLabel.text = loginInfo.savedUserInfo()?.phone ?? ""
            iconImageView.kf.setImage(with: URL(string: loginInfo.savedUserInfo()!.photopath!), placeholder: UIImage(named: "center_header"), options: nil, progressBlock: nil, completionHandler: nil)
            userNameLabel.isUserInteractionEnabled = false
        } else {
            userNameCenterConstraint.constant = 0
            userPhoneLabel.isHidden = true
            userNameLabel.text = "登录 / 注册"
            iconImageView.image = UIImage(named: "center_header")
            userNameLabel.isUserInteractionEnabled = true
        }
        
    }
}

extension HSMainTopView:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainTopNormalCollectionCell", for: indexPath) as! MainTopNormalCollectionCell
        if indexPath.item == 0 {
            cell.iconTitleLabel.text = "近七日待办"
            cell.iconImageView.image = UIImage(named: "近7日还款")
        }
        if indexPath.item == 1 {
            cell.iconTitleLabel.text = "往来记录"
            cell.iconImageView.image = UIImage(named: "往来记录")
        }
        if indexPath.item == 2 {
            cell.iconTitleLabel.text = "分期计划"
            cell.iconImageView.image = UIImage(named: "分期计划")
        }
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell?.backgroundColor = UIColor.gray
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell?.backgroundColor = UIColor.white
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击了第\(indexPath.item)个item")
        if let block = self.block {
            block(indexPath)
        }
    }
    
    func clickIndexPath(block:@escaping clickItem) {
        self.block = block
    }
    
    
    
}
