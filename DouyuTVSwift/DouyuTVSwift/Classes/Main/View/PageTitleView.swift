//
//  PageTitleView.swift
//  DouyuTVSwift
//
//  Created by  Zzzxf on 07/05/2018.
//  Copyright © 2018 goodDay. All rights reserved.
//

import UIKit
private let kScrollLineH : CGFloat = 2
class PageTitleView: UIView {

    //定义属性
    private var titles:[String]

    private lazy var titleLabels : [UILabel] = [UILabel]()

    private lazy  var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        //scrollView.isPagingEnabled = false
        scrollView.bounces = false
        return scrollView
    }()
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor  = UIColor.orange
        return scrollLine
    }()

    //自定义构造函数
    init(frame: CGRect,titles:[String]) {

        self.titles = titles
        super.init(frame:frame)
        setupUI()
    }

    //重写构造函数必须要重写initwithcoder函数
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageTitleView{
    private func setupUI(){
        addSubview(scrollView)
        scrollView.frame = bounds
        //添加label
        setupTitleLabels()
        //line
        setupBottomLineAndScrollLine()
        //
        guard  let  firstLabel = titleLabels.first else {return}
        firstLabel.textColor = UIColor.orange
        scrollView.addSubview(scrollLine)

        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }

    private func setupTitleLabels(){
        //frame
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH  : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        for(index,title) in titles.enumerated(){
            //create uilabel
            let label = UILabel()

            label.text = title
            label.tag  = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            let labelX : CGFloat = labelW * CGFloat(index)

            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
        }

    }

    private func setupBottomLineAndScrollLine(){
        //tianjiadixian
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray

        let lineH :CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y:frame.height - lineH , width: frame.width, height: lineH)
        //scrollView.addSubview(bottomLine)
        addSubview(bottomLine)



    }

}
