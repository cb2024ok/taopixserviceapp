//
//  Kakao.swift
//  TaopixServiceApp
//
//  Created by baby Enjhon on 2020/08/12.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import Foundation

struct kakao: Codable {
    var appurl: String
    var mobileurl: String
    var pcurl: String
    var tid: String
}

struct KakaoResult<T: Codable>: Codable {
    var kakaopay: T
}
