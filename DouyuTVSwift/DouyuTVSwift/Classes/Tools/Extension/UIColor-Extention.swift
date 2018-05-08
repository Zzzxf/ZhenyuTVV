//
//  UIColor-Extention.swift
//  DouyuTVSwift
//
//  Created by  Zzzxf on 08/05/2018.
//  Copyright © 2018 goodDay. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    convenience  init(r:CGFloat , g: CGFloat , b: CGFloat){
        //self.init(r: r/255.0, g: g/255.0, b: b/255.0 )
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}
