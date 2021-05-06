//
//  AuthRouter.swift
//  TestApp
//
//  Created by mac on 03.05.2021.
//

import Foundation
import UIKit


protocol AuthRoutingLogic {
    func navigateToDevExam()
}



class AuthRouter {
    
    weak var viewController: UIViewController?
    
}


extension AuthRouter: AuthRoutingLogic {
    
    func navigateToDevExam() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let devExamVC = storyboard.instantiateViewController(identifier: "DevExamViewController")
        devExamVC.modalPresentationStyle = .fullScreen
//        viewController?.present(devExamVC, animated: true, completion: nil)
        viewController?.show(devExamVC, sender: nil)
        
        
        
        
    }
    
    
}
