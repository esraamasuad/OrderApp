//
//  MenuRepositry.swift
//  OrderApp
//
//  Created by Esraa Gomaa on 4/9/24.
//

import Foundation
import Combine

protocol MenuRepositoryProtocol {
    func authAdmin() -> AnyPublisher<AuthModel?, APIError>
    func fetchMenu() -> AnyPublisher<[ProductModel]?, APIError>
}

class MenuRepository: MenuRepositoryProtocol {
    func authAdmin() -> AnyPublisher<AuthModel?, APIError> {
        MenuRouter.authAdmin.fetch()
    }
    
    func fetchMenu() -> AnyPublisher<[ProductModel]?, APIError> {
        return MenuRouter.fetchMenu.fetch()
    }
}
