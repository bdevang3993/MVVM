//
//  APIRequest.swift
//  ArcitechForApp
//
//  Created by devang bhavsar on 28/12/19.
//  Copyright © 2019 devang bhavsar. All rights reserved.
//

import UIKit
import Alamofire
class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
class APIRequest: NSObject {
    static let shared = APIRequest()
    private override init() {
        
    }
    func getAPIRequest<T:Decodable>(serviceName: String, completionBlockSuccess aBlock: @escaping ((T) -> Void), andFailureBlock failBlock:@escaping ((AnyObject) -> Void)) {
        performGetRequest(serviceName: serviceName, success: aBlock, failure: failBlock)
    }
    
    func performGetRequest<T:Decodable>(serviceName: String,success successBlock: @escaping ((T) -> Void), failure failureBlock: @escaping ((AnyObject) -> Void)) {
        
        //        let strURL = serviceName
        //        let url = URL(string: strURL)
        let allURLData = serviceName.components(separatedBy: "/")
        let strLastURl:String = allURLData.last!
        print("Last Object=\(strLastURl)")
        let checkInterNet:Bool =  Connectivity.isConnectedToInternet()
       
        var headers:HTTPHeaders?
        headers = nil
        print("Service Name = \(serviceName)")
        //let strAccessToken:String = ""
//        if strAccessToken == nil {
//            let objDefault = UserDefaults.standard
//            let isAccessToken = objDefault.value(forKey: kAccessToken) != nil
//            if isAccessToken {
//                strAccessToken = (objDefault.value(forKey: kAccessToken) as! String)
//            }
//        }
//        print("AccessToken = \(strAccessToken!)")
//        headers = [
//            "Authorization": "Bearer \(strAccessToken!)",
//            "Content-Type": "application/x-www-form-urlencoded"
//        ]
//        print("Header = \(headers)")
        
        // let Auth_header    = [ "Authorization" : tokenString! ]
        if checkInterNet == true {
            
            Alamofire.request(serviceName, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (responsed) in
                switch responsed.result { //DataResponse<Any>
                    
                case .success(_):
                    if responsed.response?.statusCode == 200 || responsed.response?.statusCode == 201 {
                        do {
                            
                            if let json = try JSONSerialization.jsonObject(with: responsed.data!, options: .allowFragments) as? [String: Any] { //[]
                                // try to read out a string array
                                print("Data = \(json)")
//                                let value:Int = json["error"] as! Int
//                                if  value != 0 {
//                                    let message = json["message"] as! String
//                                    failureBlock(message as AnyObject)
//                                    break
//                                }
                            }
                            
                            let obj = try JSONDecoder().decode(T.self , from: responsed.data!)
                            successBlock(obj)
                        }
                        catch {
                            failureBlock("API response not coming please try again" as AnyObject)
                        }
                    }
                    else
                    {
                        failureBlock("API response not coming please try again" as AnyObject)
                    }
                    break
                case .failure(let error):
                    debugPrint("getEvents error: \(error)")
                    
                    failureBlock(error.localizedDescription as AnyObject)
                    break
                @unknown default:
                    print("")
                }
            }
        }
        else {
             failureBlock("Please check your Internet Connection " as AnyObject)
        }
    }
    
    
    func callWebservice<T:Decodable>(serviceName: String, withMethod method: String, andParams params: [String:Any], showLoader loader: Bool, completionBlockSuccess aBlock: @escaping ((T) -> Void), andFailureBlock failBlock:@escaping ((AnyObject) -> Void)) {
        if loader {
            // Show loader
        }
        performPostRequest(serviceName: serviceName, method: method, andParams: params, success: aBlock, failure: failBlock)
    }
    
    func performPostRequest<T:Decodable>(serviceName: String, method methodName: String, andParams params: [String:Any], success successBlock: @escaping ((T) -> Void), failure failureBlock: @escaping ((AnyObject) -> Void)) {
        
        //        let strURL = serviceName
        //        let url = URL(string: strURL)
        
        let allURLData = serviceName.components(separatedBy: "/")
        let strLastURl:String = allURLData.last!
        
      
        
        var headers:HTTPHeaders?
        headers = nil
        
        let arrData = serviceName.components(separatedBy: "/")//serviceName.split(separator: "/")
        
        var lastName: String?
        lastName = arrData.last
        
        
        print("Service Name = \(serviceName)")
        print("ParaMeters = \(params)")
        
        
        
        
//        if lastName == "signin" || lastName == "signup" || lastName == "otp_verify" || lastName == "forgot_password" || lastName == "login_linkedin" || lastName == "set_password"
//        {
//
//            headers = nil
//
//        }
//        else
//        {
//            if strAccessToken == nil || strAccessToken!.count <= 0 {
//                failureBlock("please check the Internet connection" as AnyObject)
//            }
//            print("AccessToken = \(strAccessToken)")
//            headers = [
//                "Authorization": "Bearer \(strAccessToken!)"/*,
//                 "Content-Type": "application/X-Access-Token"*/
//            ]
//
//            print("Header = \(headers)")
//
//        }
        
        
        // let Auth_header    = [ "Authorization" : tokenString! ]
        
        let checkInterNet:Bool =  Connectivity.isConnectedToInternet()
        if checkInterNet == true {
            Alamofire.request(serviceName, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (responsed) in
                switch responsed.result { //DataResponse<Any>
                    
                case .success(_):
                   
                    if responsed.response?.statusCode == 200 || responsed.response?.statusCode == 201 {
                        do {
                            
                            if let json = try JSONSerialization.jsonObject(with: responsed.data!, options:.allowFragments) as? [String: Any] { //[]
                                // try to read out a string array
                                print("Data = \(json)")
                                let value:Int = json["error"] as! Int
                                if  value != 0 {
                                    let message = json["message"] as! String
                                    failureBlock(message as AnyObject)
                                    break
                                }
                            }
                            
                            let obj = try JSONDecoder().decode(T.self , from: responsed.data!)
                            successBlock(obj)
                        }
                        catch {
                            failureBlock("API response not coming please try again" as AnyObject)
                        }
                    }
                    else
                    {
                        failureBlock("API response not coming please try again" as AnyObject)
                    }
                    break
                case .failure(let error):
                    debugPrint("getEvents error: \(error)")
                    
                    failureBlock(error.localizedDescription as AnyObject)
                    break
                @unknown default:
                    print("")
                }
            }
        }
        else {
             failureBlock("Please check your Internet Connection " as AnyObject)
        }
    }
    
   func uploadImagesfromURL<T:Decodable>(serviceName: String, andParams params: [String:Any],completionBlockSuccess aBlock: @escaping ((T) -> Void), andFailureBlock failBlock:@escaping ((AnyObject) -> Void)) {
       uploadWithParameters(serviceName, param: params, success: aBlock, failure: failBlock)
   }
   
   func uploadWithParameters<T:Decodable>(_ url: String, param: [String: Any], success successBlock: @escaping ((T) -> Void), failure failureBlock: @escaping ((AnyObject) -> Void)) {
       
       let checkInterNet:Bool = Connectivity.isConnectedToInternet()
       
       if checkInterNet == true {
           Alamofire.upload(multipartFormData: { (multipartFormData) in
               for (key, value) in param {
                   print("keys = \(key)")
                   if key == "imgupload" {
                       for objData in value as! [Data] {
                           multipartFormData.append(objData, withName: key, fileName: "image.jpeg",mimeType: "image/jpeg")
                       }
                   }
                   else if value is String {
                       multipartFormData.append( (value as! String).data(using: .utf8)!, withName: key)
                   }
               }
           }, usingThreshold: UInt64(), to: url, method: .post) { (encodingResult) in
               print("Encoding Result = \(encodingResult)")
               switch encodingResult {
               case .success(let upload,_,_):
                   upload.validate().responseJSON { (responsed) in
                       if responsed.result.isSuccess {
                           if responsed.response?.statusCode == 200 {
                               do {
                                   
                                   if let json = try JSONSerialization.jsonObject(with: responsed.data!, options:.allowFragments) as? [String: Any] {
                                       print("Response Data = \(json)")
                                       
                                       if let result = json["result"] as? Bool, result == false {
                                           if let message = json["msg"] as? String {
                                               failureBlock(message as AnyObject)
                                           } else {
                                               failureBlock("API response not coming please try again" as AnyObject)
                                           }
                                           return
                                       }
                                   }
                                   
                                   let obj = try JSONDecoder().decode(T.self , from: responsed.data!)
                                   successBlock(obj)
                               }
                               catch {
                                   failureBlock("API response not coming please try again" as AnyObject)
                               }
                           }
                           else
                           {
                               failureBlock("API response not coming please try again" as AnyObject)
                           }
                       } else if responsed.result.isFailure {
                           debugPrint("getEvents error: \(responsed.result.error.debugDescription)")
                           failureBlock(responsed.result.error?.localizedDescription as AnyObject)
                       }
                   }
                   
                   break
               case .failure(let encodingError):
                   print("Response object = \(encodingError.localizedDescription)")
                   //completion(nil, encodingError)
                   break
               }
           }
       }
       else {
           failureBlock("Please check your Internet Connection " as AnyObject)
       }
   }
}

