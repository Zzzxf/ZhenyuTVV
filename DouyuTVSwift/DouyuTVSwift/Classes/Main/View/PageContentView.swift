//
//  PageContentView.swift
//  DouyuTVSwift
//
//  Created by  Zzzxf on 08/05/2018.
//  Copyright © 2018 goodDay. All rights reserved.
//

import UIKit

private let ContentCellID =  "ContentCellID"
class PageContentView: UIView {

    private var  childVcs : [UIViewController]
    private var  parentViewController : UIViewController
    private lazy var  collectonView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size

        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        //create
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false  //不超过内容显示区域
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:ContentCellID)

        return collectionView
    }()


    //自定义构造函数
    init(frame: CGRect,childVcs:[UIViewController],parentViewController:UIViewController) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        setupUI()
        //return self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
//设置UI界面
extension PageContentView {
    private func setupUI(){
        for childVc in childVcs {
            parentViewController.addChildViewController(childVc)
        }
        //添加UICollectionView
        addSubview(collectonView)
        collectonView.frame = bounds


    }
}

//遵守datasource协议
extension PageContentView  :  UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        let childVc  = childVcs[indexPath.item]

        for view in cell.contentView.subviews{
            view .removeFromSuperview()
        }

        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }






}













