//
//  ResponseModel.swift
//  OrderApp
//
//  Created by Esraa Gomaa on 4/8/24.
//

import Foundation


public struct ResourceResponsee<T: Decodable>: Decodable {
    public var result: T?
}
