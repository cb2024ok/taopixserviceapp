//
//  BasketVM.swift
//  TaopixServiceApp
//
//  Created by baby Enjhon on 2020/07/29.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import Foundation
import Combine

class BasketVM: ObservableObject {
    //@Published private (set) var state = State()
    
    private var subscriptions = Set<AnyCancellable>()
    
    let objectWillChange = ObservableObjectPublisher()
   
    @Published var basket: [Basket] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    
    //
    // fetchBasketAPI => projref: 프로젝트 참조 리퍼런스, token: 사용자 인증토큰
    //
    func fetchBasketAPI(_ projref : String, _token: String) {
        print("Fecth Basket API Call")
        print("PROJ REF: \(projref), TOKEN: \(_token)")
        BasketAPI.searchBasket(projref: projref , token: _token)
        .sink(receiveCompletion: onReceive(_:), receiveValue: onReceive(_:))
        .store(in: &subscriptions)
    }
    
    //
    // 임시 장바구니 삭제
    //
    func deleteBasketAPI(_ projref: String, _token: String) {
        
        BasketAPI.deleteBasket(projectref: projref, token: _token)
        .sink(receiveCompletion: onReceive(_:), receiveValue: onRecvData(_:))
        .store(in: &subscriptions)
    }
    
    private func onReceive(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(_):
            break
        }
    }
    
    private func onReceive(_ batch:[Basket]) {
        print("배치코드 >> \(batch)")
        
        self.basket = batch
        
        //self.state.basket = batch
    }
    
    private func onRecvData(_ batch: ResultCode) {
        print("받은데이터: \(batch.message)")
    }
}
