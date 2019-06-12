//
//  BannerView.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/29.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit
import Kingfisher
class BannerView: UIView {

    @IBOutlet weak var BannerCollectionView: UICollectionView!
    
    @IBOutlet weak var BannerPageControl: UIPageControl!
    
    var cycleTimer : Timer?
    
    var bannerModels : [BannerModel]? {
        didSet {
            BannerCollectionView.reloadData()
            BannerPageControl.numberOfPages = bannerModels?.count ?? 0
            let indexPath = NSIndexPath(item: (bannerModels?.count ?? 0) * 10, section: 0)
            BannerCollectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            removeTimer()
            addCycleTimer()
            
        }
    }
    
    class func setupBannerView() -> BannerView {
        let banerView = Bundle.main.loadNibNamed("BannerView", owner: nil, options: nil)?.first as! BannerView
        
        let bannerViewY : CGFloat = Bool.isIPhoneXSeries() ? 44 : 0
        
        banerView.frame = CGRect(x: 0, y: bannerViewY, width: kScreenW, height: 200)
        
        banerView.setBannerCollectionView()
        banerView.setBannerpageControl()
        
        return banerView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = .flexibleBottomMargin
        BannerCollectionView.register(UINib(nibName: "BannerNormalCell", bundle: nil), forCellWithReuseIdentifier: "BannerNormalCell")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = BannerCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = BannerCollectionView.bounds.size
    }
    
}

extension BannerView {
    func setBannerCollectionView() {
        BannerCollectionView.delegate = self
        BannerCollectionView.dataSource = self
    }
    
    func setBannerpageControl() {
        BannerPageControl.currentPageIndicatorTintColor = UIColor.red
        BannerPageControl.pageIndicatorTintColor = UIColor.gray
    }
}


extension BannerView:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (bannerModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerNormalCell", for: indexPath) as! BannerNormalCell
        cell.bannerImageView.kf.setImage(with: URL(string: bannerModels![indexPath.item % bannerModels!.count].bannerurl))
        return cell
    }
}

extension BannerView {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetX = scrollView.contentOffset.x
        BannerPageControl.currentPage = Int(offSetX / scrollView.bounds.width) % 3
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addCycleTimer()
    }
}

extension BannerView {
    private func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .common)
    }
    
    private func removeTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    
    @objc private func scrollToNext() {
        let currentOffsetX = BannerCollectionView.contentOffset.x
        let offsetX = currentOffsetX + BannerCollectionView.bounds.width
        BannerCollectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
    }
}

