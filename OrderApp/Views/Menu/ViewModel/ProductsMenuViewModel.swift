//
//  ProductsMenuViewModel.swift
//  OrderApp
//
//  Created by Esraa Gomaa on 4/9/24.
//

import Foundation
import Combine

class ProductsMenuViewModel: ObservableObject {
    
    var repository: MenuRepository
    var cancellables = Set<AnyCancellable>()
    
    @Published var productsList: [ProductModel] = []
    
    init() {
        self.repository = MenuRepository()
    }
    
    func loadProductsMenu() {
        productsList = ProductsDB().getAllProduct()
        print(productsList.count)
        if productsList.isEmpty {
            setAdminAuth()
        }
        
    }
    
    func LoadData() {
        repository.fetchMenu().sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print("Error => \(error)")
            }
        } receiveValue: { response in
            self.productsList = response ?? []
            ProductsDB().addListOfProducts(self.productsList)
        }.store(in: &cancellables)
    }
    
    /**
     - add the product to the order DB
     - Then send notification to refersh & update data
     */
    func addToOrder(_ product: ProductModel) {
        OrderDB().addProductToTheOrder(product)
        NotificationCenter.default.post(name: .refreshMenuNotification, object: nil)
    }
}

extension ProductsMenuViewModel {
    
    /**
     */
    func setAdminAuth() {
        repository.authAdmin().sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print("Error => \(error)")
            }
        } receiveValue: { authMode in
            print("auth done")
            self.LoadData()
        }.store(in: &cancellables)
    }
}
