//
//  AnchorGroup.swift
//  DouyuTVSwift
//
//  Created by  Zzzxf on 09/05/2018.
//  Copyright © 2018 goodDay. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    //组中对应的房间信息
    @objc  var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list  else {
                return
            }
            for dict in room_list {
                anchors.append( AnchorModel(dict: dict))
            }
        }

    }
    ///类型名
    @objc  var tag_name : String?
    //图标
    @objc var icon_name :String = "attentionvideo_collectIcon"
    //定义主播数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()

    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)

    }

    override init() {
        
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
//    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "room_list"{
//            if let dataArray = value as? [[String : NSObject]]  {
//                for dict in dataArray {
//                    anchors.append( AnchorModel(dict: dict))
//                }
//            }
//        }
//    }
}
