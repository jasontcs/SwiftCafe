//
//  LoginView.swift
//  SwiftCafe
//
//  Created by Jason Tse on 23/6/2023.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var vm = LoginViewModel()
    
    var body: some View {
        GeometryReader {
            geo in
            VStack {
                ZStack {
                    Color("CafeThemeColor").ignoresSafeArea()
                    VStack {
                        Image(systemName: "cup.and.saucer")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 220, height: 220)
                        
                        Spacer().frame(height: 30)
                        Text("Swift Cafe")
                            .font(.largeTitle)
                            .bold()
                            .fontWeight(.bold)
                        Text("Ordering System")
                            .font(.headline)
                    }
                }.frame(height: geo.size.height * 2 / 3)
                    .foregroundColor(.white)
                Form {
                    TextField("Email", text: $vm.username)
                    SecureField("Password", text: $vm.password)
                    Button("Login") {
                        Task {
                            await vm.onLoginButtonTapped()
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(Color("CafeThemeColor"))
                    .cornerRadius(10)
                }
            }
        }
        .onAppear {
            vm.username = "emilys"
            vm.password = "emilyspass"
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
