
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

    }

    private func setupNavigationBar(){

//左侧按钮
//let btn = UIButton()
//btn.setImage(UIImage(named: "btn_v_gift"), for:.normal)
//btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "btn_v_gift",size:CGSize(width: 5, height: 5))
        let size = CGSize(width: 40, height: 40)

//右侧按钮
//        let historyBtn = UIButton()
//        historyBtn.setImage(UIImage(named: "dy_send_message"), for: .normal)
//        historyBtn.setImage(UIImage(named: "noble_renew_0032"), for: .highlighted)
//        historyBtn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        let historyItem = UIBarButtonItem(imageName: "dy_send_message", highlightedImage: "noble_renew_0032", size: size)
       // let historyItem = UIBarButtonItem.createItem(imageName: "dy_send_message", highlightedImage: "noble_renew_0032", size: size)

//        let searchBtn = UIButton()
//        searchBtn.setImage(UIImage(named: "anchor_music_search_button_icon"), for: .normal)
//        searchBtn.setImage(UIImage(named: "noble_renew_0032"), for: .highlighted)
//        searchBtn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        let searchItem = UIBarButtonItem(imageName: "anchor_music_search_button_icon", highlightedImage: "noble_renew_0032", size: size)
        //let searchItem = UIBarButtonItem.createItem(imageName: "anchor_music_search_button_icon", highlightedImage: "noble_renew_0032", size: size)
//
                let qrCodeItem = UIBarButtonItem(imageName: "card_add_plus", highlightedImage: "noble_renew_0032", size: size)
//        let qrCodeItem = UIBarButtonItem.createItem(imageName: "card_add_plus", highlightedImage: "noble_renew_0032", size: size)

        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrCodeItem]

    }
}
