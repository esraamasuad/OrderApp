//
//  StoreDB.swift
//  OrderApp
//
//  Created by Esraa Gomaa on 4/8/24.
//

import Foundation
import SQLite

class ProductsDB {
    
    /// Sqlite instance
    private var db: Connection!
    
    /// Table instance
    private var products: Table!
    
    /// Instances of Table
    private var id: Expression<Int>!
    private var name: Expression<String>!
    private var image: Expression<String>!
    private var price: Expression<Double>!
    
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
            products = Table("products")
            
            // create instances of each column
            id = Expression<Int>("id")
            name = Expression<String>("name")
            image = Expression<String>("image")
            price = Expression<Double>("price")
            
            /// check if the user's table is already created // if not, then create the table
                try db.run(products.create(ifNotExists: true, block: { t in
                    t.column(id, primaryKey: true)
                    t.column (name)
                    t.column (image)
                    t.column (price)
                }))
            
        } catch {
            // show error message if any print (error.localizedDescription)
            print(error.localizedDescription)
        }
    }
    
    /**
     - Add Single Product to menu Table
     */
    public func addProduct(_ product: ProductModel) {
        do {
            try db.run(products.insert(id <- product.id,
                                       name <- product.display_name,
                                       image <- "",
                                       price <- product.lst_price))
        }catch {
            print(error.localizedDescription)
        }
    }
    
    /**
     - Add List of products to Menu Table
     */
    public func addListOfProducts(_ productsList: [ProductModel]) {
        
        do {
            var setter: [[Setter]] = []
            for product in productsList {
                setter.append([id <- product.id,
                               name <- product.display_name,
                               image <- "",
                               price <- product.lst_price])
            }
            let lastRowid = try db.run(products.insertMany(setter))
            print("last inserted id: \(lastRowid)")
        } catch {
            print("insertion failed: \(error)")
        }
    }
    
    /**
     
     */
    public func getAllProduct() -> [ProductModel] {
        var allProducts: [ProductModel] = []
        
        do {
            for pro_ in try db.prepare(products) {
                let productModel = ProductModel()
                productModel.id = pro_[id]
                productModel.display_name = pro_[name]
                productModel.lst_price = pro_[price]
                
                allProducts.append(productModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return allProducts
    }
    
}
