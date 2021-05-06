//
//  DevExamDetailPresenter.swift
//  TestApp
//
//  Created by mac on 04.05.2021.
//

import Foundation
import UIKit
protocol DevExamDetailPresentationLogic {
    func present(data: News)
}



class DevExamDetailPresenter {
    
    // MARK: - External vars
    weak var viewController: DevExamDetailDisplayLogic?
    
    public func getImage (from string: String) -> UIImage? {

        guard let url = URL(string: string)
            else {
                print("Unable to create URL")
                return nil
        }
        if let cachedImage = DevExamDetailInteractor.shared.imageCached.object(forKey: url.absoluteString as NSString) {
            return cachedImage
        }
        var image: UIImage? = nil
        do {
            let data = try Data(contentsOf: url, options: [])

            image = UIImage(data: data)

            if let image = image {
                DevExamDetailInteractor.shared.imageCached.setObject(image, forKey: url.absoluteString as NSString)
            }
             else {return nil}
        }
        catch {
            print(error.localizedDescription)
        }
        return image
    }


}

// MARK: - Presentation Logic
extension DevExamDetailPresenter: DevExamDetailPresentationLogic {
    func present(data: News) {
        DispatchQueue.main.async {
        let string = "http://dev-exam.l-tech.ru\(data.image)"
            guard  let image = self.getImage(from: string) else { return }
            
            self.viewController?.displayDetail(data: data, image: image)
      
        }
        
    }
    
    
    
    
}
