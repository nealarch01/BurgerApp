//
//  MenuViewModel.swift
//  BurgerBayApp
//
//  Created by Neal Archival on 12/20/22.
//

import Foundation

extension MenuView {
    @MainActor final class ViewModel: ObservableObject {
        @Published var menuItems: [MenuItem]
        @Published var searchInput: String
        @Published var selectedCategory: String
        private(set) var menuCategories: [String:[MenuItem]]
        private(set) var categoryKeys: [String]
        
        init() {
            menuItems = []
            searchInput = ""
            selectedCategory = "all"
            menuCategories = [:]
            categoryKeys = []
            if !readMenuFile() {
                return
            }
            createCategories()
            categoryKeys = Array(menuCategories.keys).sorted { $0 < $1 }
            menuItems = menuCategories["all"]!
        }
        
        private func readMenuFile() -> Bool {
            guard let fileURL = Bundle.main.url(forResource: "menu", withExtension: "json") else {
                print("Failed to open menu.json")
                return false
            }
            
            guard let fileData = try? Data(contentsOf: fileURL) else {
                print("Failed to read menu.json")
                return false
            }
            guard let decodedData = try? JSONDecoder().decode([MenuItem].self, from: fileData) else {
                print("Failed to decode menu.json")
                return false
            }
            print("Successfully read menu items")
            menuItems = decodedData
            return true
        }
        
        private func createCategories() {
            menuCategories["all"] = []
            for menuItem in menuItems {
                if menuCategories[menuItem.category] == nil { // First encounter
                    menuCategories[menuItem.category] = []
                }
                menuCategories[menuItem.category]!.append(menuItem)
                menuCategories["all"]!.append(menuItem)
            }
        }
        
    }
}
