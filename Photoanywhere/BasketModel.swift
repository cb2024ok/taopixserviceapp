//
//  BasketModel.swift
//  TaopixServiceApp
//
//  Created by baby Enjhon on 2020/07/29.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import Foundation
 
// MARK: -- 주문 Basket Model을 정의
struct Basket: Codable, Identifiable, Equatable {
    let id = UUID()
    let idx: Int
    let title: String
    let image: String
    let productcode: String
    let buyidx: Int
    let projectreference: String
    let sessioncode: String
    let price: Int
    
}

struct BasketResult<T: Codable>: Codable {
    let items: [T]
}

// 결과처리 모델
struct ResultCode: Codable,Identifiable {
    let id = UUID()
    let message: String
}

extension Basket {
    static func == (lhs: Basket, rhs: Basket) -> Bool {
        lhs.idx == rhs.idx
    }
}
