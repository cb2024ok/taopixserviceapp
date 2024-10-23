//
//  OrderDataModel.swift
//  TaopixServiceApp
//
//  Created by baby Enjhon on 2020/08/24.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import Foundation
import Combine

struct OrderDataModel<T: Codable>:  Codable {
    var data: [T]
    enum CodingKeys: String,CodingKey {
        case data = "data"
    }
}

struct OrderData: Codable, Identifiable {
    let id = UUID()
    let idx: Int
    let userid: String
    let tid: String
    let prodname: String
    let prodprice: Int
    let buyidx: Int
    let ordernumber: String
    let username: String
    let sessioncode: String
    let userhp: String
    let userpost: String
    let useraddress1: String
    let useraddress2: String
    let recvusername: String
    let recvuserhp: String
    let recvuserpost: String
    let recvuseraddress1: String
    let recvuseraddress2: String
    let status: String
    let created: String
    // Delivery Tracking Message를 추가
    let deliveryid: String
    let deliveryname: String
    let deliverytel: String
    let deliveryno: String
    
}
