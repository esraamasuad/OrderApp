//
//  ContentView.swift
//  OrderApp
//
//  Created by Esraa Gomaa on 4/8/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var visibility: NavigationSplitViewVisibility = .detailOnly
    @State private var preferredColumn = NavigationSplitViewColumn.detail
    
    @State var products: [ProductModel] = []
    
    var body: some View {
        //        NavigationSplitView(columnVisibility: $visibility) {
        NavigationSplitView(preferredCompactColumn: $preferredColumn) {
            OrderView()
                .navigationSplitViewColumnWidth(min: 300, ideal: 350, max: 400)
        } detail: {
            ProductsMenuView()
        }
        //        .navigationSplitViewStyle(.prominentDetail)
    }
}

#Preview {
    ContentView()
}
