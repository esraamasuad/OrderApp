//
//  MennuRouter.swift
//  OrderApp
//
//  Created by Esraa Gomaa on 4/9/24.
//

import Foundation

enum MenuRouter: RequestBuilder {
    
    case authAdmin
    case fetchMenu
    
    var path: String {
        return switch self {
        case .authAdmin:
            "/web/session/authenticate"
        case .fetchMenu:
            "/web/dataset/call_kw"
        }
    }
    
    var bodyRequest: String {
        return switch self {
        case .authAdmin:
            "AuthBodyRequest"
        case .fetchMenu:
            "MenuBodyRequest"
        }
    }
    
}
