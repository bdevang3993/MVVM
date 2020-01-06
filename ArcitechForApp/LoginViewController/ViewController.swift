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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setHeaderView()
        self.setTextfield()
    }
    //MARK:- HeaderView
    func setHeaderView() {
         headerViewXib = setCommanHeaderView()
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
    @IBAction func btnSubmitClicked(_ sender: Any) {
        txtEmail.text = removeWhiteSpace(strData: txtEmail.text!)
        txtPassword.text = removeWhiteSpace(strData: txtPassword.text!)
        userViewModel.userModel.email = txtEmail.text!
        userViewModel.userModel.password = txtPassword.text!
        do {
            let value = try userViewModel.validationOfData()//validationOfData()
            if value {
                self.moveToNextView()
            }
        }
        catch LoginValidation.emailEmpty {
            Alert().showAlert(message: LoginValidation.emailEmpty.loginValidationDescription(), viewController: self)
        }
        catch LoginValidation.passwordEmpty {
            Alert().showAlert(message: LoginValidation.passwordEmpty.loginValidationDescription(), viewController: self)
        }
        catch LoginValidation.emailIdnotmatch {
            Alert().showAlert(message: LoginValidation.emailIdnotmatch.loginValidationDescription(), viewController: self)
        }
        catch {
             Alert().showAlert(message: LoginValidation.emailIdnotmatch.loginValidationDescription(), viewController: self)
        }
    }
}

