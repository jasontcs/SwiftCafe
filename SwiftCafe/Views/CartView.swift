//
//  CartView.swift
//  SwiftCafe
//
//  Created by Jason Tse on 23/6/2023.
//

import SwiftUI

struct CartView: View {
    @StateObject private var vm = CartViewModel()
    
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            if vm.cartItems.count > 0 {
                List {
                    ForEach(vm.cartItems) {
                        CartItemView(vm: vm, cartItem: $0)
                    }
                }
                .listStyle(.plain)
                
            } else {
                Spacer()
                Text("No Item")
                Spacer()
            }
            Button(action: {
                showingAlert = true
            }, label: {
                HStack {
                    Image(systemName: "cart")
                    Text("Check Out")
                }
            })
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Alert"),
                    message: Text("Not Yet Implemented!"),
                    dismissButton: .default(Text("Dismiss"))
                )
            }
            .disabled(vm.cartItems.count == 0)
            .padding()
            .frame(maxWidth: .infinity)
            .background(vm.cartItems.count > 0 ? Color("CafeThemeColor") : .gray)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding()
        }
        .navigationTitle(Text("Cart"))
    }
}

struct CartItemView: View {
    @ObservedObject var vm: CartViewModel
    
    let cartItem: CartItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(cartItem.product.title)
                    .font(.headline)
                    .lineLimit(1)
            }
            Spacer()
            Text("\(cartItem.product.price.formatted(.currency(code: "AUD"))) x \(cartItem.amount)")
                .font(.title3)
            Button(action: {
                vm.removeOnTap(cartItem)
            }, label: {
                Image(systemName: "minus.circle.fill")
            })
            .foregroundColor(.red)
        }
    }
}


struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
