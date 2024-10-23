//
//  LoginResult.swift
//  TaopixServiceApp
//
//  Created by baby Enjhon on 2020/07/13.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import Foundation


// MARK: -- Login 결과 정의
struct LoginResult: Codable {
    let Code: Int
    let Expire: String
    let Token: String
    
    
    enum CodingKeys: String, CodingKey {
        case Code = "code"
        case Expire = "expire"
        case Token = "token"
    }
}

// Server Error 이벤트 정의
enum ServerError: Error {
    case InvalidSeverResponse
}

// MARK: -- User 데이터 정의
struct User: Codable {
    let userid:String
    let userpassword: String
    let username: String
    let userhp: String
    let userpost: String
    let useraddress1: String
    let useraddress2: String
    // 배송 대상 사용자 정보
    let recvusername: String
    let recvuserhp: String
    let recvuserpost: String
    let recvuseraddress1: String
    let recvuseraddress2: String
    // 디바이스 토큰 정보
    let ostype: String
    let devicetoken: String
}

struct UserResult<T: Codable>: Codable {
    let data: T
}

// 사용자 정보 최종 업데이트 결과 기록
struct UserInfoResult: Codable {
    var result: String
    
    enum CodingKeys:String,CodingKey {
        case result = "RESULT"
    }
    
}

// 주문 상태정보 구조선언
struct OrderStatus: Codable {
    let status: String
}

// 사용자 회원결과 선언
struct AccountResult: Codable {
    var message: String
}
