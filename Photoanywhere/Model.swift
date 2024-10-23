//
//  Model.swift
//
//  Created by baby Enjhon on 2020/07/17.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import Foundation


// MARK: -- TAOPIX Service Model을 정의 --
struct LinkModel: Codable {
    var totalPage: Int
    var Recordstotal: Int
    var data: [SData]
    var Offset: Int
    var Limit: Int
    var Page: Int
    var Prevpage: Int
    var Nextpage: Int
    
    
    enum CodingKeys: String, CodingKey {
        case totalPage = "total_page"
        case Recordstotal = "recordsTotal"
        case Offset = "offset"
        case Limit = "limit"
        case Page = "page"
        case Prevpage = "prev_page"
        case Nextpage = "next_page"
        case data = "data"
    }
}

// MARK: -- 상세 데이터를 정의 --
struct SData: Codable, Identifiable, Equatable  {
    var id = UUID()
    var Idx: String
    var Servicetype: String
    var Tag: String
    var Title: String
    var Contents: String
    var Image: String
    var Openlink: String
    var Created: String
    
    enum CodingKeys: String, CodingKey {
            case Idx = "idx"
            case Servicetype = "type"
            case Tag = "tag"
            case Title = "title"
            case Contents = "contents"
            case Image = "image"
            case Openlink = "openlink"
            case Created = "created"
    }
}

// 카테고리를 정의 합니다.
enum Categories {
    case photobook
    case panorama
    case diy
    case gift
}

// MARK: -- Data에 대한 Equitable Protocol을 정의
extension SData {
    static func == (lhs: SData, rhs: SData) -> Bool {
        lhs.Idx == rhs.Idx
    }
}
