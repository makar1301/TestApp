//
//  DevExamDetailRouter.swift
//  TestApp
//
//  Created by mac on 04.05.2021.
//

import Foundation


protocol DevExamDetailRoutingLogic {
    
}

protocol DevExamDetailDataPassingProtocol {
    var dataStore: DevExamDetailStoreProtocol? { get }
}
    
class DevExamDetailRouter: DevExamDetailDataPassingProtocol {
    
    weak var dataStore: DevExamDetailStoreProtocol?
    
    
}

extension DevExamDetailRouter: DevExamDetailRoutingLogic {
    
}
