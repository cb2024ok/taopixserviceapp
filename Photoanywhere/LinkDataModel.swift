//
//  LinkDataModel.swift
//  TESTUI
//
//  Created by baby Enjhon on 2020/07/21.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import Foundation

// MARK: -- TAOPIX 서비스 모델정의 --
struct LinkDataModel: Codable {
    var data: LinkData
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct LinkData: Codable {
    var id = UUID()
    var brandcode: String
    var collectioncode: String
    var collectionname: String
    var designurl: String
    var groupcode: String
    var groupdata: String
    var layoutname: String
    var productcode: String
    var projectname: String
    var projectref: String
    var result: Int
    var resultmessage: String
    var userdata: String
    
    enum CodingKeys: String,CodingKey {
        case brandcode = "brandcode"
        case collectioncode = "collectioncode"
        case collectionname = "collectionname"
        case designurl = "designurl"
        case groupcode = "groupcode"
        case groupdata = "groupdata"
        case layoutname = "layoutname"
        case productcode = "productcode"
        case projectname = "projectname"
        case projectref = "projectref"
        case result = "result"
        case resultmessage = "resultmessage"
        case userdata = "userdata"
    }
}
