//
//  CollectionBaseCell.swift
//  DouyuTVSwift
//
//  Created by  Zzzxf on 10/05/2018.
//  Copyright © 2018 goodDay. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionBaseCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!

    @IBOutlet weak var nickNameLabel: UILabel!

    var anchor : AnchorModel?{
        didSet{
            guard let anchor = anchor else { return }
            var  onlineStr : String = ""
            if anchor.online >= 10000{
                onlineStr = "\(Int(anchor.online/10000))万在线"

            }else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            nickNameLabel.text = anchor.nickname

            //KingFisher
            guard let iconUrl = NSURL.init(string: anchor.vertical_src)  else {return}
            iconImageView.kf.setImage(with: ImageResource.init(downloadURL: iconUrl as URL) )

        }
    }

}
