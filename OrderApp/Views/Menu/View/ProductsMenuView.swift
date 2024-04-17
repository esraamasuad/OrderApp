//
//  ProductsMenuView.swift
//  OrderApp
//
//  Created by Esraa Gomaa on 4/9/24.
//

import SwiftUI

struct ProductsMenuView: View {
    
    let colums: [GridItem] = [
        GridItem(.adaptive(minimum: 200, maximum: 250), spacing: nil, alignment: nil)
    ]
    
    @StateObject private var viewModel: ProductsMenuViewModel = ProductsMenuViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: colums, alignment: .center, spacing: nil, pinnedViews: [], content: {
                    ForEach(viewModel.productsList) { product in
                        ZStack {
                            VStack {
                                Text(product.display_name)
                                Text("\(product.lst_price) RAS")
                            }
                        }
                        .frame(width: 200, height: 200)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(4)
                        .onTapGesture {
                            print("taped \(product.id)")
                            self.viewModel.addToOrder(product)
                        }
                    }
                })
            }
            .navigationTitle("Products List")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.gray.opacity(0.2))
            .onAppear {
                self.viewModel.loadProductsMenu()
            }
        }
    }
    
}


//
//#Preview {
//    ProductsMenuView()
//}
