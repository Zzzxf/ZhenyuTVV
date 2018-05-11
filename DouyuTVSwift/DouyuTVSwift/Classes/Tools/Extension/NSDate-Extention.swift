//
//  NSDate-Extention.swift
//  DouyuTVSwift
//
//  Created by  Zzzxf on 09/05/2018.
//  Copyright © 2018 goodDay. All rights reserved.
//

import Foundation

extension NSDate{
    class func getCurrentTime() -> String{
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
