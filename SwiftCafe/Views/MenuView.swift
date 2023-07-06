//
//  MenuView.swift
//  SwiftCafe
//
//  Created by Jason Tse on 23/6/2023.
//

import SwiftUI

struct MenuView: View {
    @StateObject private var vm = MenuViewModel()
    
    var body: some View {
        NavigationView {
            List {
                if let products = vm.products {
                    ForEach(products) {
                        ProductsItemView(vm: vm, product: $0)
                    }
                } else {
                    Text("No Products")
                }
            }
            .navigationTitle(Text("Menu"))
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: CartView(), label: {
                        HStack {
                            Text(vm.cartCount.flatMap { String($0)} ?? "")
                            Image(systemName: "cart")
                        }
                    })
                }
            }
        }
        .onAppear {
            Task {
                await vm.fetchProducts()
            }
        }
    }
}

struct ProductsItemView: View {
    @ObservedObject var vm: MenuViewModel
    
    let product: Product
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.headline)
                    .lineLimit(1)
                Text(product.description)
                    .font(.caption)
                    .lineLimit(2)
            }
            Spacer()
            VStack {
                Text("$\(product.price)")
                    .font(.title3)
            }
            Image(systemName: "cart.badge.plus")
        }
        .onTapGesture {
            vm.addToCart(product)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
