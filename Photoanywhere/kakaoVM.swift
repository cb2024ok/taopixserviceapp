//
//  kakaoVM.swift
//  TaopixServiceApp
//
//  Created by baby Enjhon on 2020/08/12.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import Foundation
import Combine

class KakaoVM: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    let objectWillChange =  ObservableObjectPublisher()
    
    @Published var kakaoConnection:kakao = kakao(appurl: "", mobileurl: "", pcurl: "", tid: "") {
        didSet {
            objectWillChange.send()
        }
    }
    
    init() {
        ConnectKakao()
    }
    
    // Combine 기능을 최대한 활용하여 KAKAOAPI와 연결처리
    func ConnectKakao() {
        print("=== Connection KakaoPay API ===")
        
        KakaoApiService.connectKakao()
        .sink(receiveCompletion: onRecieve(_:), receiveValue: onReceive(_:))
        .store(in: &subscriptions)
    }
    
    private func onRecieve(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(_):
            break
        }
    }
    
    private func onReceive(_ batch: kakao) {
        print("KAKAO Connection ==> \(batch)")
        self.kakaoConnection = batch
    }
    
}
