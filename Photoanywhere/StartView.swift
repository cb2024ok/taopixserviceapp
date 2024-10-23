//
//  StartView.swift
//  TaopixServiceApp
//
//  Created by baby Enjhon on 2020/07/15.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import SwiftUI

struct StartView: View {
    
    // 환경 셋팅에 따른 로그인 인증구현
    @EnvironmentObject var settings: UserSettings
    // Coredata Framework 연동을 위한 추가코드
    @Environment(\.managedObjectContext) var context;
    
    // for Testing
    // let recvnotipub = NotificationCenter.default.publisher(for: Notification.Name("EventDetail")).eraseToAnyPublisher()
    
    var body: some View {
        
        if settings.loggedIn {
            return AnyView(MainView())
        } else {
            return AnyView(LoginView(settings: _settings, errorReason: ""))
        }
        
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
