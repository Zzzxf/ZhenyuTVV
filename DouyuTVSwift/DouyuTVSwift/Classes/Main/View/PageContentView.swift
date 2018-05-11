//
//  PageContentView.swift
//  DouyuTVSwift
//
//  Created by  Zzzxf on 08/05/2018.
//  Copyright © 2018 goodDay. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contentView: PageContentView ,progress : CGFloat ,sourceIndex : Int ,targetIndex : Int)
}

private let ContentCellID =  "ContentCellID"
class PageContentView: UIView {

    private var  childVcs : [UIViewController]
    private weak  var  parentViewController : UIViewController?//避免强强引用
    private var startOffsetX : CGFloat = 0
    private var isForbidScrollDelegate = false
    weak var delegate  : PageContentViewDelegate?
    private lazy var  collectonView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!   //强制解包

        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        //create
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false  //不超过内容显示区域
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:ContentCellID)

        return collectionView
    }()


    //自定义构造函数
    init(frame: CGRect,childVcs:[UIViewController],parentViewController:UIViewController?) {
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
            parentViewController?.addChildViewController(childVc)
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

//对外暴露方法控制偏移量
extension  PageContentView {
    func setCurrentIndex(currentIndex: Int)  {
        //记录需要禁止
        isForbidScrollDelegate = true

        let offsetX = CGFloat (currentIndex) * collectonView.frame.width
        collectonView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}

//contentView delegate
extension PageContentView : UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1 define
        if  isForbidScrollDelegate  { return }
        var progress : CGFloat = 0
        var sourceIndex = 0
        var targetIndex = 0
        //2 judge
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if  currentOffsetX > startOffsetX {
            //左滑
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            //source index
            sourceIndex = Int(currentOffsetX / scrollViewW)
            targetIndex = sourceIndex + 1
            if   targetIndex >= childVcs.count{
                targetIndex = childVcs.count - 1
            }
            if   currentOffsetX - startOffsetX == scrollViewW{
                progress = 1
                targetIndex = sourceIndex
                //startOffsetX = currentOffsetX
            }

        }else{
            //右滑
            progress = 1 - (currentOffsetX / scrollView.frame.width - floor(currentOffsetX / scrollViewW))
            targetIndex = Int(currentOffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            if   targetIndex < 0 {
                targetIndex = 0
            }
            if   sourceIndex >= childVcs.count{
                sourceIndex = childVcs.count - 1
            }
        }
        //3 progress /sourceindex /target send to titleView
        print("progress:\(progress)  source\(sourceIndex)  target \(targetIndex)")
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }


}











