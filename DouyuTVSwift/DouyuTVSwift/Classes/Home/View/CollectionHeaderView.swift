//
//  CollectionHeaderView.swift
//  DouyuTVSwift
//
//  Created by  Zzzxf on 08/05/2018.
//  Copyright © 2018 goodDay. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var iconImageView: UIImageView!
    var group:AnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named:group?.icon_name ?? "btn_album_collect" )
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    


}
