//
//  ProductsMenuView.swift
//  OrderApp
//
//  Created by Esraa Gomaa on 4/9/24.
//

import SwiftUI

struct ProductsMenuView: View {
    
//    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
//    @Environment(\.Produc)
    // (minimum: 100, maximum: 200)
    let colums: [GridItem] = [
        GridItem(.adaptive(minimum: 200, maximum: 250), spacing: nil, alignment: nil)
    ]
    
    @State var products: [ProductModel] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: colums, alignment: .center, spacing: 5, pinnedViews: [], content: {
                    ForEach(self.products) { product in
                        NavigationLink {
//                            OrderView(orderList: [ProductModel()])
                        } label: {
                            ZStack {
                                //                            Image(systemName: "globe")
                                //                                .imageScale(.large)
                                //                                .foregroundStyle(.tint)
                                VStack {
                                    Text(product.display_name)
                                    Text("\(product.lst_price) RAS")
                                }
                            }
                            .frame(width: 200, height: 200)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .onTapGesture {
                                print("taped \(product.id)")
                                self.addToOrder(product)
                            }
                        }
                        
                    }
                })
            }
            .navigationTitle("Products List")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.gray.opacity(0.2))
            .onAppear {
                self.loadProductsMenu()
            }
        }
    }
    
    
    func addToOrder(_ product: ProductModel) {
        OrderDB().addProductToTheOrder(product)
        //        self.mode.wrappedValue.dismiss()
    }
    
    func loadProductsMenu() {
        products = ProductsDB().getAllProduct()
        print(products.count)
        if products.isEmpty {
            NetworkUrlSession.shared.getProductsMenuRequest { result in
                products = result.result ?? []
                ProductsDB().addListOfProducts(products)
            }
        }
        
    }
}

#Preview {
    ContentView()
}
