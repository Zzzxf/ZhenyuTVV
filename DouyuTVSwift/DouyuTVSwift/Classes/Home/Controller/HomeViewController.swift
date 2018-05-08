
//
//  HomeViewController.swift
//  DouyuTVSwift
//
//  Created by  Zzzxf on 07/05/2018.
//  Copyright © 2018 goodDay. All rights reserved.
//

import UIKit
private let kTitleViewH : CGFloat = 40
class HomeViewController: UIViewController {

    private lazy var pageTitleView : PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH, width: kScreenWidth, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        //titleView.backgroundColor = UIColor.purple
        return titleView
    }()

    private lazy var pageContentView : PageContentView = {
        let contentH = kScreenHeight - kStatusBarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenWidth, height: contentH)

        var childVcs = [UIViewController]()
        for _ in 0..<4{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)


        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        return contentView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()


    }

}

///设置UI界面
extension HomeViewController{
    private func setupUI(){
        
        automaticallyAdjustsScrollViewInsets = false

        setupNavigationBar()

        view.addSubview(pageTitleView)

        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }

    private func setupNavigationBar(){

//左侧按钮
//let btn = UIButton()
//btn.setImage(UIImage(named: "btn_v_gift"), for:.normal)
//btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "btn_v_gift",size:CGSize(width: 5, height: 5))
        let size = CGSize(width: 40, height: 40)

//右侧按钮

        let historyItem = UIBarButtonItem(imageName: "dy_send_message", highlightedImage: "noble_renew_0032", size: size)
       // let historyItem = UIBarButtonItem.createItem(imageName: "dy_send_message", highlightedImage: "noble_renew_0032", size: size)

        let searchItem = UIBarButtonItem(imageName: "anchor_music_search_button_icon", highlightedImage: "noble_renew_0032", size: size)
        //let searchItem = UIBarButtonItem.createItem(imageName: "anchor_music_search_button_icon", highlightedImage: "noble_renew_0032", size: size)
//
                let qrCodeItem = UIBarButtonItem(imageName: "card_add_plus", highlightedImage: "noble_renew_0032", size: size)
//        let qrCodeItem = UIBarButtonItem.createItem(imageName: "card_add_plus", highlightedImage: "noble_renew_0032", size: size)

        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrCodeItem]

    }
}
