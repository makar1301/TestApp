//
//  DevExamPresentor.swift
//  TestApp
//
//  Created by mac on 03.05.2021.
//

import Foundation
import UIKit
protocol DevExamPresentationLogic {
    func present(data: [News])
    func sorting(index: Int, data: [News])
}



class DevExamPresenter {
    
    // MARK: - External vars
    weak var viewController: DevExamDisplayLogic?
    
    
}

// MARK: - Presentation Logic
extension DevExamPresenter: DevExamPresentationLogic {
    func sorting(index: Int, data: [News]) {
        switch index {
        case 0: let sortedData = data.sorted { $0.sort < $1.sort }
            viewController?.displayData(data: sortedData)
        case 1: let sortedData = data.sorted { $0.date > $1.date }
            viewController?.displayData(data: sortedData)
        default:
            break
        }

    }
    
   
    
    func present(data: [News]) {
        let sortedData = data.sorted { $0.sort < $1.sort }
        viewController?.displayData(data: sortedData)
        
        
    }
    
    
    
    
}
