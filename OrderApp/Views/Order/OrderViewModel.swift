//
//  OrderViewModel.swift
//  OrderApp
//
//  Created by Esraa Gomaa on 4/9/24.
//

import Foundation

extension Notification.Name {
    static let refreshMenuNotification = Notification.Name("RefreshMenuNotification")
}

class OrderViewModel: ObservableObject {
    
    @Published var orderList: [ProductModel] = []
    @Published var subTotalPrice: Double = 0
    @Published var totalPrice: Double = 0

    /**
     - delete item
     */
    func deleteItem(at indexSet: IndexSet) {
        let id = indexSet.map { self.orderList[$0].id }.first
        if let id = id {
            let delete = OrderDB().delete(id: id)
            if delete {
                loadOrder()
            }
        }
    }
    
    /**
     - loading all the items
     */
    func loadOrder() {
        self.orderList = OrderDB().getOrderList()
        subTotalPrice = self.orderList.reduce(0, {$0 + (Double($1.quantity!) * $1.lst_price)})
        totalPrice = subTotalPrice + 0.65
    }
}
