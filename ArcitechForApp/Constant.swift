//
//  Constant.swift
//  ArcitechForApp
//
//  Created by devang bhavsar on 27/12/19.
//  Copyright © 2019 devang bhavsar. All rights reserved.
//

import UIKit
//MARK:- Screen Resolution
let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
//MARK:- Constant API URL
let baseURL =  "https://newsapi.org/v2/"
let otherURL = "sources?apiKey=0cf790498275413a9247f8b94b3843fd"

//MARK:- Constant Struct
struct AppMessage {
    var internetIssue:String = "Please check the internet connection"
}
struct CustomFontName {
    var textfieldFontName:String = "Helvetica Neue"
    var buttonFontName:String = "Helvetica Neue"
}
struct CustomFontSize {
    var textfieldFontSize:CGFloat = 12.0 * (screenWidth/320.0)
    var buttonFontSize:CGFloat = 14.0 * (screenWidth/320.0)
}

struct Alert {
    func showAlert(message:String,viewController:UIViewController) {
        let alert = UIAlertController(title: "Comman Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}

func setCommanHeaderView() -> CommanView {
    let headerViewXib:CommanView = CommanView().instanceFromNib()
    headerViewXib.frame = CGRect(x: 0, y: 0, width: screenWidth, height: (screenHeight * 0.1))
    return headerViewXib
}
