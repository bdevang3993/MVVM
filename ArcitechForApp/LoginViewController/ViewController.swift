//
//  ViewController.swift
//  ArcitechForApp
//
//  Created by devang bhavsar on 27/12/19.
//  Copyright © 2019 devang bhavsar. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController,UITextFieldDelegate {
    //ModelView Object
    var userViewModel = UserViewModel()
  
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var headerViewXib:CommanView?
    
    
    //Local Notification
    let userNotificationCenter = UNUserNotificationCenter.current()
    let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.userNotificationCenter.delegate = self
        self.requestNotificationAuthorization()
        self.sendNotification()
        self.setHeaderView()
        self.setTextfield()
    }
    //MARK:- HeaderView
    func setHeaderView() {
         headerViewXib = setCommanHeaderView()
        headerView.frame = headerViewXib!.frame
        headerViewXib?.btnBack.isHidden = true
               headerViewXib!.lblTitle.text = "Login Screen"
               headerViewXib?.btnHeader.addTarget(self, action: #selector(leftClicked), for: .touchUpInside)
        headerView.addSubview(headerViewXib!)
    }
  
    //MARK:- TextfieldSetUp
    func setTextfield() {
        self.txtEmail.delegate = self
        self.txtEmail = setCustomTextField(self: self.txtEmail, placeHolder: "Email Id")
        self.txtPassword.delegate = self
        self.txtPassword = setCustomTextField(self: self.txtPassword, placeHolder: "Password")
    }
//MARK:- Custom Methods
    @objc func leftClicked() {
        print("Left Clicked")
        let objSignUp:SignUpViewController = self.storyboard?.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        //MARK:- callback Method
        objSignUp.objTaSignUpModel = { [weak self] value in
            self?.userViewModel.signUpModel = value
        }
        self.present(objSignUp, animated: true, completion: nil)
    }
    func moveToNextView() {
        print("Move to next view")
      
        let objInformation = self.storyboard?.instantiateViewController(identifier: "InformationViewController") as! InformationViewController
        self.navigationController?.pushViewController(objInformation, animated: true)
    }
    
    //MARK:-Local Notification Request
      func requestNotificationAuthorization() {
          // Code here
          let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
          self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
              if let error = error {
                  print("Error: ", error)
              }
          }
      }

      func sendNotification() {
          // Code here
          let notificationContent = UNMutableNotificationContent()
             notificationContent.title = "Test"
             notificationContent.body = "Test body"
             notificationContent.badge = NSNumber(value: 3)
             
             if let url = Bundle.main.url(forResource: "dune",
                                         withExtension: "png") {
                 if let attachment = try? UNNotificationAttachment(identifier: "dune",
                                                                 url: url,
                                                                 options: nil) {
                     notificationContent.attachments = [attachment]
                 }
             }
             
             let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
                                                             repeats: false)
             let request = UNNotificationRequest(identifier: "testNotification",
                                                 content: notificationContent,
                                                 trigger: trigger)
             
             userNotificationCenter.add(request) { (error) in
                 if let error = error {
                     print("Notification Error: ", error)
                 }
             }
      }
    
    
    
    
    
    @IBAction func btnSubmitClicked(_ sender: Any) {
        txtEmail.text = removeWhiteSpace(strData: txtEmail.text!)
        userViewModel.email = txtEmail.text!
        txtPassword.text = removeWhiteSpace(strData: txtPassword.text!)
        userViewModel.password = txtPassword.text!
        self.moveToNextView()
//        userViewModel.userModel.email = txtEmail.text!
//        userViewModel.userModel.password = txtPassword.text!
//        do {
//            let value = try userViewModel.validationOfData()//validationOfData()
//            if value {
//                self.moveToNextView()
//            }
//        }
//        catch LoginValidation.emailEmpty {
//            Alert().showAlert(message: LoginValidation.emailEmpty.loginValidationDescription(), viewController: self)
//        }
//        catch LoginValidation.passwordEmpty {
//            Alert().showAlert(message: LoginValidation.passwordEmpty.loginValidationDescription(), viewController: self)
//        }
//        catch LoginValidation.emailIdnotmatch {
//            Alert().showAlert(message: LoginValidation.emailIdnotmatch.loginValidationDescription(), viewController: self)
//        }
//        catch {
//             Alert().showAlert(message: LoginValidation.emailIdnotmatch.loginValidationDescription(), viewController: self)
//        }
    }
    @IBAction func bntDatabaseDemoClicked(_ sender: Any) {
        let objDatabase  = self.storyboard?.instantiateViewController(identifier: "DatbaseViewController") as! DatbaseViewController
        self.navigationController?.pushViewController(objDatabase, animated: true)
    }
    
    @IBAction func CollectionViewClicked(_ sender: Any) {
        let objData = self.storyboard?.instantiateViewController(identifier: "CartViewController") as! CartViewController
        self.navigationController?.pushViewController(objData, animated: true)
    }
}
extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}
