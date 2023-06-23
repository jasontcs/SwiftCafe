//
//  MainView.swift
//  SwiftCafe
//
//  Created by Jason Tse on 23/6/2023.
//

import SwiftUI

struct MainView: View {
    @StateObject private var vm = MainViewModel()
    
    var body: some View {
        if (vm.user == nil) {
            LoginView()
        } else {
            MenuView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
