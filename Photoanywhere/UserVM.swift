//
//  UserVM.swift
//  TaopixServiceApp
//
//  Created by baby Enjhon on 2020/08/17.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import Foundation
import Combine

class UserVM: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    let uservmWillChange = ObservableObjectPublisher()
    // 수정된 코드..
    let resultpublisher = PassthroughSubject<String, Never>()
 
    @Published var vUser: User? {
        didSet {
            uservmWillChange.send()
        }
    }
    
    @Published var vResult:String {
        willSet {
            uservmWillChange.send()
        }
        didSet {
            resultpublisher.send(vResult)
            //uservmWillChange.send()
        }
    }
    
    init() {
        self.vResult = ""
    }
    
    deinit {
        self.subscriptions.removeAll()
    }
    
    /*
     init() {
        self.vResult.result = ""
    }
    */
    
    
    // calluserinfo - 사용자 상세정보 로드
    func calluserinfo(vToken: String) {
        UserAPI.getUserInfo(token: vToken)
            .sink(receiveCompletion: { (_ completion: Subscribers.Completion<Error>) in
                
                switch completion {
                    
                case .finished:
                    break
                case .failure(_):
                    break
                }
                
            }) { (_user) in
                self.vUser = _user
        }
    .store(in: &subscriptions)
    }
    
    // callupdateuserinfo - 사용자 정보 업데이트 처리
    func callupdateuserinfo(token: String) {
        UserAPI.setupdateuser(token: token, vUser!)
            .sink(receiveCompletion: { (_ completion:Subscribers.Completion<Error>) in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    break
                }
            
            }) { (result) in
                print("API CALL RESULT:", result.result)
                self.vResult = result.result
        }
    .store(in: &subscriptions)
    }
    
}
