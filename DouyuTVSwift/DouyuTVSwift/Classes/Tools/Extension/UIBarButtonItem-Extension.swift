//
//  UIBarButtonItem-Extension.swift
//  DouyuTVSwift
//
//  Created by  Zzzxf on 07/05/2018.
//  Copyright © 2018 goodDay. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem{
//    class func  createItem(imageName:String,highlightedImage:String,size:CGSize)->UIBarButtonItem{
//
//        let  btn = UIButton()
//        btn.setImage(UIImage(named: imageName), for: .normal)
//        btn.setImage(UIImage(named: highlightedImage), for: .highlighted)
//        btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
//
//        let barItem = UIBarButtonItem(customView: btn)
//        return barItem
//
//
//    }
    //便利构造函数   ： convenience开头    明确调用一个设计的构造函数（self）
    convenience  init(imageName:String,highlightedImage:String = "" ,size:CGSize  =  CGSize(width: 0, height: 0)) {
        //创建UIButton
                let  btn = UIButton()

        //设置图片
        btn.setImage(UIImage(named: imageName), for: .normal)

        if  highlightedImage != ""{
            btn.setImage(UIImage(named: highlightedImage), for: .highlighted)
        }
        if  size == CGSize(width: 0, height: 0  ){
            btn.sizeToFit()
        }
        else{
            btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        }
        //初始化
        self.init(customView:btn)
    }


}
