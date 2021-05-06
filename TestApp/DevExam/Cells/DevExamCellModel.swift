//
//  DevExamCellModel.swift
//  TestApp
//
//  Created by mac on 04.05.2021.
//

import Foundation


struct News: Decodable {
    let id, title, text, image: String
    let sort: Int
    var date: Date
    
}
typealias Main = [News]
