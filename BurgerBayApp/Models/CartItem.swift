//
//  CartItem.swift
//  BurgerBayApp
//
//  Created by Neal Archival on 12/21/22.
//

import Foundation

class CartItem {
    private(set) var item: MenuItem
    private(set) var quantity: Int
    var price: Double {
        return Double(item.price) * Double(quantity)
    }
    
    
    init(item: MenuItem) {
        self.item = item
        quantity = 0
    }
    
    func incrementCount() {
        if quantity > 10 { // Max the number of items to 10
            return
        }
        quantity += 1
    }
    
    func decrementCount() {
        if quantity - 1 <= 0 { // Remove the item entirely
            return
        }
        quantity -= 1
    }
    
}
