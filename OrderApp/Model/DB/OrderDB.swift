//
//  OrderDB.swift
//  OrderApp
//
//  Created by Esraa Gomaa on 4/8/24.
//

import Foundation
import SQLite

class OrderDB {
    
    /// Sqlite instance
    private var db: Connection!
    
    /// Table instance
    private var order: Table!
    
    /// Instances of Table
    private var id: Expression<Int>!
    private var name: Expression<String>!
    private var price: Expression<Double>!
    private var quantity: Expression<Int>!
    
    /// Constructor
    init() {
        // exception handling
        do {
            // path of document directory let path: String =
            //            let path: String = NSSearchPathForDirectoriesInDomains.documentDirectory, userDomainMask, true).first ?? ""
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            // creating database connection
            db = try Connection("\(path)/order_app.sqliteV1")
            
            // creating table object
            order = Table("order")
            
            // create instances of each column
            id = Expression<Int>("id")
            name = Expression<String>("name")
            price = Expression<Double>("price")
            quantity = Expression<Int>("quantity")
            
            /// check if the user's table is already created if (!UserDefaults.standard.bool(forKey: "is_db_created"))
            try db.run(order.create(ifNotExists: true, block: { t in
                t.column(id, primaryKey: true)
                t.column (name)
                t.column (price)
                t.column (quantity)
            }))
            
        } catch {
            // show error message if any print (error.localizedDescription)
            print(error.localizedDescription)
        }
    }
    
    
    /**
     
     */
    public func addProductToTheOrder(_ product: ProductModel) {
        do {
            try db.run(order.insert(id <- product.id,
                                    name <- product.display_name,
                                    quantity <- 1, //product.quantity,
                                    price <- product.lst_price))
        }catch {
            print(error.localizedDescription)
        }
    }
    
    /**
     
     */
    public func getOrderList() -> [ProductModel] {
        var allProducts: [ProductModel] = []
        
        do {
            for pro_ in try db.prepare(order) {
                let productModel = ProductModel()
                productModel.id = pro_[id]
                productModel.display_name = pro_[name]
                productModel.lst_price = pro_[price]
                productModel.quantity = pro_[quantity]
                
                allProducts.append(productModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return allProducts
    }
    
}
