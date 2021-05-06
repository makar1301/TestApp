//
//  DevExamRouter.swift
//  TestApp
//
//  Created by mac on 03.05.2021.
//

import Foundation
import UIKit


protocol DevExamRoutingLogic {
    func navigateToDevExamDetail(id: News)
}



class DevExamRouter {
    
    weak var viewController: UIViewController?
    
}


extension DevExamRouter: DevExamRoutingLogic {
    func navigateToDevExamDetail(id: News) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let devVC = storyboard.instantiateViewController(identifier: "DevExamDetailViewController") as? DevExamDetailViewController else { return }
        devVC.router?.dataStore?.detailId = id
        viewController?.navigationController?.pushViewController(devVC, animated: true)
    }
    
    
}
