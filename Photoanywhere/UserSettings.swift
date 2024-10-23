//
//  UserSettings.swift
//  TaopixServiceApp
//
//  Created by baby Enjhon on 2020/07/15.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    @Published var loggedIn: Bool = false   // 로그인 여부 확인
    @Published var Usertoken: String = ""   // 사용자 로그인 토큰
    @Published var UserID: String = ""      // 사용자 ID
}
