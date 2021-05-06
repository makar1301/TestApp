//
//  AuthInteractor.swift
//  TestApp
//
//  Created by mac on 03.05.2021.
//

import Foundation
import UIKit
import Alamofire
import KeychainAccess

protocol AuthBusinessLogic {
    func fetchMask()
    func fetchRequest(phone: String, password: String)
    func saveData(phone: String, password: String)
    func loadFromKeychain()
}

struct Mask: Decodable {
    let phoneMask: String
}



class AuthInteractor {
    
    var presenter: AuthPresentationLogic?
    
    
    
    private func getMask() {
        var mask = ""
        
        AF.request("http://dev-exam.l-tech.ru/api/v1/phone_masks").responseData { response in

            if let objects = try? response.result.get() {

            do {
                let masks = try JSONDecoder().decode(Mask.self, from: objects)
                        DispatchQueue.main.async {
                            mask = masks.phoneMask
                            self.presenter?.showMask(mask: mask)
                        }
            } catch let error {
                print(error)
            }
        }
        }
        
    }
    
    private func formattedToRequest(number: String) -> String {
            var masks = number
            masks.removeFirst()
            var result = ""
            for ch in masks  {
            if ch != " " {
                if ch != "-" {
                    if ch != "("{
                        if ch != ")" {
                    result.append(ch)
                        }
                    }
                }
            }
        }
    return result
}
    
    
    private func getRequest(phone: String, password: String) {
        var normPhone = ""
        if phone != "" {
        normPhone = formattedToRequest(number: phone)
        }
        let parameters = [ "phone" : normPhone, "password" : password]
        
         AF.request("http://dev-exam.l-tech.ru/api/v1/auth",
                   method: .post,
                   parameters: parameters)
                         .response { response in
                            
                            let statusCode = response.response?.statusCode
                            
                            self.presenter?.showCode(code: statusCode!)
                         
        }
    
    }
    
}



extension AuthInteractor: AuthBusinessLogic {
    func loadFromKeychain() {
        let keychain = Keychain(service: "karma.TestApp")
        let phone = keychain["phone"]
        let password = keychain["password"]
        presenter?.showKeychain(phone: phone ?? "", password: password ?? "")
    }
    
    func saveData(phone: String, password: String) {
        let keychain = Keychain(service: "karma.TestApp")
        keychain["phone"] = phone
        keychain["password"] = password
    }
    
    func fetchRequest(phone: String, password: String){
        getRequest(phone: phone, password: password)
    }

    func fetchMask() {
        getMask()
    }
}
