//
//  CartViewModel.swift
//  BurgerBayApp
//
//  Created by Neal Archival on 12/21/22.
//

import Foundation

@MainActor class CartViewModel: ObservableObject {
    @Published var cartItems: [CartItem]
    
    init() {
        cartItems = []
    }
}
