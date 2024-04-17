//
//  ProductModel.swift
//  OrderApp
//
//  Created by Esraa Gomaa on 4/8/24.
//

import Foundation

class ProductModel: Codable, Identifiable {
    public var id: Int = 0
    public var display_name: String = ""
    public var lst_price: Double = 0
//    public var image_small: String = "" ///
    public var quantity: Int?
}
