//
//  SignUpViewController.swift
//  ArcitechForApp
//
//  Created by devang bhavsar on 03/01/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtCnfPassword: UITextField!
    var objSignUpViewModel = SignUpViewModel()
    //Type Define Variable
    var objTaSignUpModel:TaSignUpModel?
    var headerViewXib:CommanView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setHeaderView()
        self.settextfield()
        
    }
    //MARK:- HeaderView
       func setHeaderView() {
            headerViewXib = setCommanHeaderView()
            headerViewXib!.lblTitle.text = "SignUp"
        headerViewXib!.btnHeader.isHidden = true
           headerView.addSubview(headerViewXib!)
       }
    
    //MARK:- Set TextField
    func settextfield() {
        txtName.delegate = self
        txtName = setCustomTextField(self: txtName, placeHolder: "Name")
        txtEmail.delegate = self
        txtEmail = setCustomTextField(self: txtEmail, placeHolder: "Email")
        txtPassword.delegate = self
        txtPassword = setCustomTextField(self: txtPassword, placeHolder: "Password")
        txtPassword.isSecureTextEntry = true
        txtCnfPassword.delegate = self
        txtCnfPassword = setCustomTextField(self: txtCnfPassword, placeHolder: "Confirm password")
        txtCnfPassword.isSecureTextEntry = true
    }
    @IBAction func btnSubmitClicked(_ sender: Any) {
        self.resignAllTextField()
        self.setAllData()
        do {
            let value = try objSignUpViewModel.validationOfData()
            if value {
                self.dismissSignUp()
            }
        }
        catch LoginValidation.nameEmpty {
            Alert().showAlert(message: LoginValidation.nameEmpty.loginValidationDescription(), viewController: self)
        }
        catch LoginValidation.emailEmpty {
            Alert().showAlert(message: LoginValidation.emailEmpty.loginValidationDescription(), viewController: self)
        }
        catch LoginValidation.emailValidation {
            Alert().showAlert(message: LoginValidation.emailValidation.loginValidationDescription(), viewController: self)
        }
        catch LoginValidation.passwordEmpty {
            Alert().showAlert(message: LoginValidation.passwordEmpty.loginValidationDescription(), viewController: self)
        }
        catch LoginValidation.confirmPassword {
            Alert().showAlert(message: LoginValidation.confirmPassword.loginValidationDescription(), viewController: self)
        }
        catch LoginValidation.passwordNotMatch {
            Alert().showAlert(message: LoginValidation.passwordNotMatch.loginValidationDescription(), viewController: self)
        }
        catch {
            
        }
    }
    
    func setAllData() {
        objSignUpViewModel.signUpModel.name = txtName.text!
        objSignUpViewModel.signUpModel.email = txtEmail.text!
        objSignUpViewModel.signUpModel.password = txtPassword.text!
        objSignUpViewModel.signUpModel.cnfPassword = txtCnfPassword.text!
    }
    
    func resignAllTextField() {
        self.txtName.resignFirstResponder()
        self.txtEmail.resignFirstResponder()
        self.txtPassword.resignFirstResponder()
        self.txtCnfPassword.resignFirstResponder()
    }
    
    func dismissSignUp()  {
        objTaSignUpModel!(objSignUpViewModel.signUpModel)
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
