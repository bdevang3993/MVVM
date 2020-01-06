//
//  CustomEnums.swift
//  ArcitechForApp
//
//  Created by devang bhavsar on 27/12/19.
//  Copyright © 2019 devang bhavsar. All rights reserved.
//

import Foundation

enum LoginValidation:Error {
    case emailEmpty,emailValidation,emailIdnotmatch,passwordEmpty,confirmPassword,passwordNotMatch,nameEmpty
    
    func loginValidationDescription() -> String {
        switch self {
        case .emailEmpty:
            return "Please provide EmailId"
        case .emailValidation:
            return "Please provide valide EmailId"
        case .emailIdnotmatch:
            return "Emailid or password is wrong"
        case .passwordEmpty:
            return "Please provide password"
        case .confirmPassword:
            return "Please provide confirm password"
        case .passwordNotMatch:
            return "Password does not match"
        case .nameEmpty:
            return "Please provide your name"
        }
    }
}
