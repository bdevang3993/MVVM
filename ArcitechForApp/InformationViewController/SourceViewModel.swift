//
//  SourceViewModel.swift
//  MVVMDemo
//
//  Created by Devang.bhavsar on 10/19/18.
//  Copyright © 2018 Collabera. All rights reserved.
//

import Foundation
class SourceViewModel: NSObject {
    var arrSoureceData:[Source] = []
    var apiResponse:TaAPICallBack?
    var arrSectionName = ["Section1","Section2","Section3"]
    
    
    func fetchData()  {
        var message:String = "success"
             do
             {
                 let getInfo = baseURL + otherURL
                   DispatchQueue.global(qos: .userInitiated).sync {
                    APIRequest.shared.getAPIRequest(serviceName: getInfo, completionBlockSuccess: { (js:JSonData) in
                        self.arrSoureceData = js.source
                        self.apiResponse!(message)
                    }) { (value) in
                         message = value as! String
                        self.apiResponse!(message)
                    }
                   }
             }
             catch
             {
                 //Alert().showAlert(message: AppMessage().internetIssue, viewController: self)
                message = AppMessage().internetIssue
                self.apiResponse!(message)
             }
         }
    
    //MARK:- TableView Call Methods
    func numberofSectionInTable() -> Int {
        return arrSectionName.count
    }
    func sectionTitleData(index:Int) -> String {
        return arrSectionName[index]
    }
    
}
