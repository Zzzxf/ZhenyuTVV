//
//  CollectionNormalCell.swift
//  DouyuTVSwift
//
//  Created by  Zzzxf on 08/05/2018.
//  Copyright © 2018 goodDay. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionNormalCell: CollectionBaseCell {
    @IBOutlet weak var roomNameLabel: UILabel!

    override var anchor : AnchorModel? {
        didSet{
            super.anchor = anchor

            roomNameLabel.text = anchor?.room_name
        }
    }


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
