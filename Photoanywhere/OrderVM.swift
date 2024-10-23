//
//  OrderVM.swift
//  TaopixServiceApp
//
//  Created by baby Enjhon on 2020/08/24.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import Foundation
import Combine

class OrderVM: ObservableObject {
    var ovmsubscriptions = Set<AnyCancellable>()
    
    var objectWillChange = ObservableObjectPublisher()
    
    @Published var orders:[OrderData] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    
    func fetchOrders(vUserID: String, vToken: String) {
        OrderServiceAPI.OrderSearch(vUserID: vUserID, token: vToken)
            .sink(receiveCompletion: { (_ completion: Subscribers.Completion<Error>) in
                switch completion {
                case .finished:
                    print("Order Lists Finished >>")
                    break
                case .failure(let error):
                    print("Order Error >> \(error)")
                }
            }) { orderdata in
                //print(orderdata)
                self.orders = orderdata
        }
    .store(in: &ovmsubscriptions)
    }
    
}
