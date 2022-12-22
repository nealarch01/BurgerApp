//
//  MenuItem.swift
//  BurgerBayApp
//
//  Created by Neal Archival on 12/20/22.
//

import Foundation

class MenuItem: Decodable {
    private(set) var name: String
    private(set) var description: String
    private(set) var calories: Int
    private(set) var price: Double
    private(set) var category: String
    private(set) var vegan: Bool
    private(set) var image_url: String
}
