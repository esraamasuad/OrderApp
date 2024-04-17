//
//  OrderView.swift
//  OrderApp
//
//  Created by Esraa Gomaa on 4/9/24.
//

import SwiftUI
import CoreData

struct OrderView: View {
    
    @StateObject private var viewModel: OrderViewModel = OrderViewModel()
    
    var body: some View {
        ZStack {
            if !viewModel.orderList.isEmpty {
                VStack {
                    List {
                        ForEach(viewModel.orderList) { product in
                            HStack {
                                Text("\(product.quantity ?? 0)")
                                Text(product.display_name)
                                Spacer()
                                Text("\(product.lst_price) RAS")
                            }.onTapGesture(count: 4) {
                                print("done!")
                            }
                        }
                        .onDelete { index in
                            self.viewModel.deleteItem(at: index)
                        }
                    }
                    .listStyle(.insetGrouped)
                    VStack {
                        Spacer()
                            .frame(height: 10)
                        HStack {
                            Text("Sub-Total \n (\(viewModel.orderList.count) items)")
                            Spacer()
                            Text("\(viewModel.subTotalPrice) RAS")
                        }
                        .padding()
                        Spacer()
                            .frame(height: 5)
                        HStack {
                            Text("Vat")
                            Spacer()
                            Text("0.65 RAS")
                        }
                        .padding()
                        .padding(.bottom, 20)

                        Button {
                            
                        } label: {
                            HStack {
                                Text("Pay Now!")
                                    .foregroundStyle(Color.white)
                                Spacer()
                                Text("\(viewModel.totalPrice) RAS")
                                    .foregroundStyle(Color.white)
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                        }
                        .frame(minHeight: 40)
                        .background(Color.blue)
                    }
                }
            }
            else {
                Text("Empty Order List!")
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .refreshMenuNotification), perform: { _ in
            self.viewModel.loadOrder()
        })
        .navigationTitle("Order List")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.navigationStack)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                NavigationLink {
                    ProductsMenuView()
                } label: {
                    Text("Menu")
                }
            }
        }
        .onAppear {
            self.viewModel.loadOrder()
        }
    }
}

//
//#Preview {
//        OrderView()
//}
