//
//  DewExamInteractor.swift
//  TestApp
//
//  Created by mac on 03.05.2021.
//

import Foundation
import UIKit
import Alamofire

protocol DevExamBusinessLogic {
    func fetchNews()
    func sendIndex(index: Int, data: [News])
}

class DevExamInteractor {
    
    static let shared = DevExamInteractor()
 
//    MARK: - External vars
    var presenter: DevExamPresentationLogic?
    
//    MARK: - Internal vars
    var imageCached = NSCache<NSString, UIImage>()
    var news: [News] = []
    var firstLoad: Bool = true
    
   
    
    func getNews() {
        
        AF.request("http://dev-exam.l-tech.ru/api/v1/posts").responseData { response in
            
            if let objects = try? response.result.get() {
        
            do {
                let formatter = DateFormatter()
            
                formatter.dateStyle = .long
                let decoder =  JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let message = try decoder.decode(Main.self, from: objects)
                
                if self.firstLoad == true {
                    self.firstLoad = !self.firstLoad
                for item in message {
                        self.news.append(item)
                }
            } else {
                    var newMess: [News] = []
                        var remIndex: [Int] = []
                        
// Поиск среди новых новостей уникальных
                        for item in message {
                            var rep = false
                        for mess in self.news {
                            if item.date == mess.date {
                                rep = true
                            }
                        }
                            if rep == false {
                                newMess.append(item)
                            }
                        }
                        
// Поиск новостей, которые были удалены
                        for (index, mess) in self.news.enumerated() {
                            var rep = false
                        for item in message {
        
                            if mess.date == item.date {
                                rep = true
                            }
                        }
                            if rep == false {
                                remIndex.append(index)
                            }
                        }
                        let remIn = remIndex.sorted(by: >)

// Удаление удаленных новостей
                        for i in remIn {
                            self.news.remove(at: i)
                        }
                        
// Добавление новых
                        self.news.append(contentsOf: newMess)
                }
                
                DispatchQueue.main.async {
                    self.presenter?.present(data: self.news)
                }
            }
            catch let error {
                print(error)
                
            }
            }
        }
    }
}

    
// MARK: - Business Logic
extension DevExamInteractor: DevExamBusinessLogic {
    
    func sendIndex(index: Int, data: [News]) {
        presenter?.sorting(index: index, data: data)
    }
    
    func fetchNews() {
        getNews()
    }
}
