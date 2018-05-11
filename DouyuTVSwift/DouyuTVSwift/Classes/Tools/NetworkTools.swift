
import UIKit
import Alamofire
enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    class func requestData(type : MethodType ,urlString : String ,parameter : [String : NSString ]?=nil ,finishedCallback :  @escaping ( _ result : AnyObject) ->() ){
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post

        Alamofire.request(urlString, method: method, parameters: parameter).responseString { (response) in
            guard let result = response.result.value else {
                print(response.result.error ?? "error" )
                return
            }
            finishedCallback(result as AnyObject)
        }
    }
}

