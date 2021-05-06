//
//  DevExamDetailInteractor.swift
//  TestApp
//
//  Created by mac on 03.05.2021.
//

import Foundation
import UIKit

protocol DevExamDetailBusinessLogic {
    func fetchDetails()
}

protocol DevExamDetailStoreProtocol: class {
    var detailId: News {get set}
}

class DevExamDetailInteractor: DevExamDetailStoreProtocol {
    static let shared = DevExamDetailInteractor()
    
    var detailId = News(id: "", title: "", text: "", image: "", sort: 0, date: Date())
    
    
    var imageCached = NSCache<NSString, UIImage>()
    var presenter: DevExamDetailPresentationLogic?
  
    
    
    
}


extension DevExamDetailInteractor: DevExamDetailBusinessLogic {
    func fetchDetails() {
//        print(detailId)
        presenter?.present(data: detailId)
    }
    
    
}
