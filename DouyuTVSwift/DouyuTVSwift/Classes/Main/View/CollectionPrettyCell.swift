//
//  CollectionPrettyCell.swift
//  DouyuTVSwift
//
//  Created by  Zzzxf on 09/05/2018.
//  Copyright © 2018 goodDay. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionPrettyCell: CollectionBaseCell {

    override var anchor : AnchorModel?{
        didSet{
            super.anchor = anchor
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
    
    @IBOutlet weak var cityBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        onlineCountLabel.layer.cornerRadius = 5
//        onlineCountLabel.layer.masksToBounds = true
    }

}
