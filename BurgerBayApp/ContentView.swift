//
//  ContentView.swift
//  BurgerBayApp
//
//  Created by Neal Archival on 12/20/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            TabView {
                MenuView()
                    .tabItem {
                        Image(systemName: "menucard")
                        Text("Menu")
                    }
                
                CartView()
                    .tabItem {
                        Label("Cart", systemImage: "cart")
                    }
            } // TabView
            .tint(Color.vibrantLime)
        }
    } // body
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
