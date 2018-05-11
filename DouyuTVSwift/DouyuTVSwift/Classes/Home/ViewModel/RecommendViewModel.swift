//
//  RecommendViewModel.swift
//  DouyuTVSwift
//
//  Created by  Zzzxf on 09/05/2018.
//  Copyright © 2018 goodDay. All rights reserved.
//

import UIKit

class RecommendViewModel {
    lazy var anchorGroups : [AnchorGroup ] = [AnchorGroup]()
    private lazy var bigDataGroup :AnchorGroup = AnchorGroup()
    private lazy var prettyDataGroup :AnchorGroup = AnchorGroup()
   // private lazy var bigDataGroup :AnchorGroup = AnchorGroup()


}
//network
extension RecommendViewModel {
    func requestData( finishedCallBack : @escaping ()->() ){
        let parameters = ["time" : NSDate.getCurrentTime() as NSString , "limit":"4","offset":"0"]

        let dGroup = DispatchGroup.init()
        //var ddgroup = DispatchGroup()
        dGroup.enter()
        //DispatchGroup.enter(dGroup)

        //1.tuijianshuju
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameter: ["time":NSDate.getCurrentTime() as NSString]) { (result) in
            let  resultDict = self.getDictionaryFromJSONString(jsonString: result as! String)
            guard let dataArr = resultDict["data"] as?[[String : NSObject]] else {return}
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "broadcast_privilege_disable_icon"
            for dict in dataArr{
                let anModel  =  AnchorModel(dict: dict)
                self.bigDataGroup.anchors .append(anModel)
            }
            dGroup.leave()
            print("首页000")

            //DispatchGroup.leave(group1)
        }

        //2.yanzhishuju
        dGroup.enter()
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameter: parameters) { (result) in
            print(result)
            //将result转成字典
            let  resultDict = self.getDictionaryFromJSONString(jsonString: result as! String)
            //           guard let resultDict = result as?[String : NSObject] else {
            //                return
            //            }
            //根据datakey获得数组
            guard let dataArr = resultDict["data"] as?[[String : NSObject]] else {return}
            //let group = AnchorGroup()
            //
            self.prettyDataGroup.tag_name = "颜值"
            self.prettyDataGroup.icon_name = "broadcast_privilege_disable_icon"


            for dict in dataArr{

                let anchor = AnchorModel(dict: dict)
                self.prettyDataGroup.anchors.append(anchor)

            }

            dGroup.leave()
            print("首页111")
        }


        //3.houxubufenyouxi
        //let nowDate = NSDate()
        //let interval = nowDate.timeIntervalSince1970
        dGroup.enter()
        NetworkTools .requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameter: parameters) { (result) in
            //print(result)
            //将result转成字典
             let  resultDict = self.getDictionaryFromJSONString(jsonString: result as! String)
            //根据datakey获得数组
            guard let dataArr = resultDict["data"] as?[[String : NSObject]] else {return}
            //遍历数组
            for dict in dataArr {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            for group in self.anchorGroups{
                guard group.tag_name != nil else {
                    return
                }
                for anchor in group.anchors{
                    //print(anchor.nickname)
                }
                //print("========")
            }
            dGroup.leave()
            print("0--12")
        }
        dGroup.notify(queue: DispatchQueue.main) {
            print("all downloaded!!!!")
            self.anchorGroups.insert(self.prettyDataGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishedCallBack()
        }


    }
}
extension RecommendViewModel{
    func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{

        let jsonData:Data = jsonString.data(using: .utf8)!

        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()

    }
}
