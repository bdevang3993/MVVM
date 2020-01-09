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
    
    func uploadImagesfromURL<T:Decodable>(serviceName: String, withImage method: UIImage,fileDataString: String, andParams params: [String:Any],completionBlockSuccess aBlock: @escaping ((T) -> Void), andFailureBlock failBlock:@escaping ((AnyObject) -> Void)) {
        
        uploadImages(serviceName: serviceName, withImage: method,fileDataString: fileDataString ,andParams: params, success: aBlock, failure: failBlock)
    }
    
    func uploadImages<T:Decodable>(serviceName: String, withImage selectedImage:UIImage ,fileDataString: String, andParams params: [String:Any], success successBlock: @escaping ((T) -> Void), failure failureBlock: @escaping ((AnyObject) -> Void))
    {
        let strAccessToken = ""
          let headers = [
            "Authorization": "Bearer \(strAccessToken)",
                    "Content-type": "multipart/form-data", //"application/x-www-form-urlencoded",//"multipart/form-data",
                    "Content-Disposition" : "form-data"
                ]
         var parameter = [String:Any]()
        
        if selectedImage != nil {
            let imageBase64String = selectedImage.pngData()?.base64EncodedString()
                 
                  parameter = params
                  var arrNewData = [String]()
                  arrNewData.append(imageBase64String!)
                  parameter["photo"] = arrNewData//imageBase64String
        }
        if fileDataString != nil && fileDataString != "" {
            parameter = params
            var arrNewData = [String]()
            arrNewData.append(fileDataString)
            parameter["resume"] = arrNewData//imageBase64String
        }
        
        self.uploadWithParameters(serviceName, param: parameter, headers: headers as! [String : String],success : successBlock ,failure : failureBlock)
        
        
//        //Header HERE
//        let headers = [
//            "token" : strdeviceToken,
//            "Content-type": "multipart/form-data", //"application/x-www-form-urlencoded",//"multipart/form-data",
//            "Content-Disposition" : "form-data"
//        ]
//
//        Alamofire.upload(multipartFormData: { (multipartFormData) in
//            for (key, value) in params {
//                if value is String {
//                    multipartFormData.append( (value as! String).data(using: .utf8)!, withName: key)
//                }
//            }
//
//            //let imageBase64String = selectedImage.jpegData(compressionQuality: 0.0)?.base64EncodedString() //JPEG compression
//            let imageBase64String = selectedImage.pngData()?.base64EncodedString() //PNG Compression
//            let imgData = Data(base64Encoded: imageBase64String ?? "", options: .ignoreUnknownCharacters)!
//            multipartFormData.append(imgData, withName: "photo", fileName: "image.png",mimeType: "image/png")
//
//            /*let fileName = "Test1232"
//             let dir = try? FileManager.default.url(for: .documentDirectory,
//             in: .userDomainMask, appropriateFor: nil, create: true)
//
//             // If the directory was found, we write a file to it and read it back
//             if let fileURL = dir?.appendingPathComponent(fileName).appendingPathExtension("txt") {
//
//             // Write to the file named Test
//             //let outString = "Write this text to the file"
//             do {
//             try multipartFormData.encode().write(to: fileURL)
//             } catch {
//             print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
//             }
//
//             // Then reading it back from the file
//             var inString = ""
//             do {
//             inString = try String(contentsOf: fileURL)
//             } catch {
//             print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
//             }
//             print("Read from the file: \(inString)")
//             }*/
//            //print(multipartFormData)
//        }, usingThreshold: UInt64(), to: serviceName, method: .post, headers: headers as! HTTPHeaders) { (encodingResult) in
//            switch encodingResult {
//            case .success(let upload,_,_):
//                upload.validate().responseJSON { response in
//                    switch response.result {
//                    case .success(let responseObj):
//                        print("Response GET:\(responseObj)")
//                        //                        if self.checkAccessToken(responseObj) == true {
//                        //                            completion(nil, self.accessExpireError())
//                        //                        }
//                        //                        else if self.checkSignatureMatched(responseObj) == true {
//                        //                            completion(nil, self.signatureNotMatchError())
//                        //                        }
//                        //                        else {
//                        //                            completion(responseObj, nil)
//                        //                        }
//                        break
//                    case .failure(let error):
//                        print("Error = \(error.localizedDescription)")
//                        //completion(nil, error)
//                        break
//                    }
//                }
//                break
//            case .failure(let encodingError):
//                print("Error = \(encodingError.localizedDescription)")
//                //completion(nil, encodingError)
//                break
//            }
//        }
    }
    
    
    
    
    func uploadWithParameters<T:Decodable>(_ url: String, param: [String: Any], headers: [String: String], success successBlock: @escaping ((T) -> Void), failure failureBlock: @escaping ((AnyObject) -> Void)) {
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in param {
                print("keys = \(key)")
                if key == "photo" {
                    let listOfDataValue = value as? [String]
                    listOfDataValue!.forEach { (singleData) in
                        let data = Data(base64Encoded: singleData, options: .ignoreUnknownCharacters)!
                        print("Image Data = \(data)")
                        multipartFormData.append(data, withName: key, fileName: "image.png",mimeType: "image/png")
                    }
                }
                else if key == "resume" {
                    let listOfDataValue = value as? [String]
                    listOfDataValue!.forEach { (singleData) in
                        let data = Data(base64Encoded: singleData, options: .ignoreUnknownCharacters)!
                        print("resume Data = \(data)")
                        multipartFormData.append(data, withName: key, fileName: "cv.pdf",mimeType: "pdf")
                    }
                }
                else if value is String {
                    multipartFormData.append( (value as! String).data(using: .utf8)!, withName: key)
                }
//                else if let listOfDataValue = value as? [String] {
//                    listOfDataValue.forEach { (singleData) in
//                        let data = Data(base64Encoded: singleData, options: .ignoreUnknownCharacters)!
//                        print("Image Data = \(data)")
//                        multipartFormData.append(data, withName: key, fileName: "image.png",mimeType: "image/png")
//                    }
//                }
            }
        }, usingThreshold: UInt64(), to: url, method: .post, headers: headers) { (encodingResult) in
            print("Encoding Result = \(encodingResult)")
            switch encodingResult {
            case .success(let upload,_,_):
                upload.validate().responseJSON { (responsed) in
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

                break
            case .failure(let encodingError):
                print("Response object = \(encodingError.localizedDescription)")
                //completion(nil, encodingError)
                break
            }
        }
    }
}

