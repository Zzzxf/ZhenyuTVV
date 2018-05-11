//
//  PageTitleView.swift
//  DouyuTVSwift
//
//  Created by  Zzzxf on 07/05/2018.
//  Copyright © 2018 goodDay. All rights reserved.
//

import UIKit

protocol PagetTitleDelegate : class {  //class 表明只能被类遵守实现
    func pageTitleView(titleView : PageTitleView , selectedIndex index : Int)  //selectedIndex外部参数 index内部参数
}

//定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)   //darkGray
private let kSelectedColor : (CGFloat,CGFloat,CGFloat) = (255,128,0) //orange

class PageTitleView: UIView {

    //定义属性
    private var currentIndex : Int = 0
    private var titles:[String]
    weak var delegate : PagetTitleDelegate?
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
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            let labelX : CGFloat = labelW * CGFloat(index)

            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
            //5 .gesture
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)



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
        guard  let  firstLabel = titleLabels.first else {return}
        firstLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        scrollView.addSubview(scrollLine)

        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }

}

//label ges
extension PageTitleView{
    @objc private func titleLabelClick(tapGes : UITapGestureRecognizer){

        guard let currentLabel = tapGes.view as? UILabel else { return }
        //if currentLabel.tag == currentIndex{return}

        let oldLabel = titleLabels[currentIndex]
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)

        currentLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        currentIndex = currentLabel.tag

        let scrollLinePosition = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLinePosition
        }
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)

    }
}
extension PageTitleView {
    func setTitleWithProgress(progress: CGFloat , sourceIndex : Int , targetIndex: Int)  {
        //1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        //2 处理滑块
        let moveTotalX = (targetLabel.frame.origin.x)  - sourceLabel.frame.origin.x
        let moveX = moveTotalX  * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        //Color Gradient
        let colorDelta = (kSelectedColor.0 - kNormalColor.0,kSelectedColor.1-kNormalColor.1,kSelectedColor.2 - kNormalColor.2)
        sourceLabel.textColor = UIColor(r: kSelectedColor.0 - colorDelta.0 * progress, g: kSelectedColor.1 - colorDelta.1 * progress, b: kSelectedColor.2 - colorDelta.2 * progress)
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        currentIndex = targetIndex


    }

}
