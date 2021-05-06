//
//  AuthPresenter.swift
//  TestApp
//
//  Created by mac on 03.05.2021.
//

import Foundation


protocol AuthPresentationLogic {
    
    func showMask(mask: String)
    
    func showCode(code: Int)
    func showKeychain(phone: String, password: String)
    
}


class AuthPresenter {
    
    weak var viewController: AuthDisplayLogic?
    
    
    // MARK: - Formatted input mask to InputMask format
    
    private func formattedToMask(number: String) -> String {

            let masks = number
            var result = ""
            var yes = false
    
            for ch in masks  {
                
            if ch == "Х" {
                if yes == false {
                result.append("[")
                    yes = !yes
                }
                    result.append("0")
                } else {
                    if yes == true {
                        result.append("]")
                        yes = !yes
                    }
                    result.append(ch)
            }
            }
            return result + "]"
}
    
}


extension AuthPresenter: AuthPresentationLogic {
    func showKeychain(phone: String, password: String) {
        viewController?.updateTF(phone: phone, password: password)
    }
    
    func showCode(code: Int) {
        viewController?.displayCode(code: code)
    }
    
    
    func showMask(mask: String) {
            let trueMask = self.formattedToMask(number: mask)
            viewController?.displayData(mask: trueMask)
        
    }

}
