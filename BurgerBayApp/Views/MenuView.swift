//
//  MenuView.swift
//  BurgerBayApp
//
//  Created by Neal Archival on 12/20/22.
//

import SwiftUI

struct MenuItemView: View {
    var data: MenuItem
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("\(data.name)")
                        .font(.system(size: 22, weight: .semibold))
                        .minimumScaleFactor(0.3)
                        .padding([.leading], 10)
                        .padding([.top], 5)
                        .frame(maxWidth: 200, maxHeight: 40)
                    Spacer()
                }
                AsyncImage(url: URL(string: data.image_url)) { phase in
                    switch phase {
                    case .empty:
                        Image(systemName: "photo")
                            .frame(width: 120, height: 120)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                    case .failure:
                        Image(systemName: "photo")
                            .frame(width: 120, height: 120)
                    @unknown default:
                        Image(systemName: "photo")
                            .frame(width: 120, height: 120)
                    } // switch
                } // AsyncImage
                Spacer()
                    HStack {
                        Text("\(displayPrice(data.price))")
                            .font(.system(size: 22, weight: .medium))
                            .padding([.top], 26)
                            .padding([.leading])
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Rectangle()
                                .fill(Color.green)
                                .cornerRadius(12)
                                .overlay(alignment: .bottomLeading) {
                                    Rectangle()
                                        .fill(Color.green)
                                        .frame(width: 10, height: 10)
                                }
                                .overlay(alignment: .topTrailing) {
                                    Rectangle()
                                        .fill(Color.green)
                                        .frame(width: 10, height: 10)
                                }
                                .overlay(alignment: .center) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(Color.white)
                                } // Overlay
                        } // Button
                        .buttonStyle(.plain)
                        .padding([.leading], 25)
                        .padding([.top], 10)
                    } // HStack
            } // VStack
        } // ZStack
        .frame(height: 240)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.gray, radius: 3, x: 2, y: 2)
    }
    
    func displayPrice(_ price: Double) -> String {
        let roundedValue = round(price * 100) / 100.0
        return "$\(roundedValue)"
    }
}

struct SearchBar: View {
    @State private var searchInput: String = ""
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                HStack {
                    Text(Image(systemName: "magnifyingglass"))
                        .frame(width: 50, height: 60)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.offWhite)
                        .background(Color.green)
                    TextField("Search item", text: $searchInput)
                        .padding([.leading], 5)
                } // HStack
                .frame(width: geometry.size.width * 0.95, height: 60)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 3, x: 0, y: 5)
                .frame(width: geometry.size.width) // Center in the middle
            } // GeometryReader
            .frame(height: 60)
        } // ZStack
    }
}

struct MenuView: View {
    @StateObject var viewModel = ViewModel()
    @State var searchInput: String = ""
    @State var scrollPosition: CGFloat = 0
    @State var selectedCategory: String = "burgers"
    
    let columns = [
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.offWhite
                    .ignoresSafeArea([.all])
                VStack {
                    ScrollView(.vertical, showsIndicators: true) {
                        HStack {
                            Text("Welcome back!")
                                .font(.system(size: 32, weight: .bold))
                            Spacer()
                            Button(action: {}) {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 50, height: 50)
                                    .shadow(color: Color.gray, radius: 2)
                                    .overlay {
                                        Image(systemName: "person")
                                            .foregroundColor(Color.gray)
                                    }
                            }
                        }
                        .padding([.leading, .trailing])
                        categorySlider()
                            .padding([.bottom], 35)
                        LazyVGrid(columns: columns, spacing: 20, pinnedViews: [.sectionHeaders]) {
                            Section(header: PageHeader()) {
                                ForEach(Array(viewModel.menuCategories[viewModel.selectedCategory]!.enumerated()), id: \.offset) { index, element in
                                    MenuItemView(data: element)
                                }
                            } // Section
                        } // LazyVGrid
                        .padding()
                    } // ScrollView
                    .clipped()
                } // VStack
                
            } // ZStack
        }
    }

    @ViewBuilder
    func PageHeader() -> some View {
        VStack(spacing: 2) {
            SearchBar()
                .padding([.bottom], 10)
        } // VStack
    } // PageHeader
    
    @ViewBuilder
    func categorySlider() -> some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Array(viewModel.categoryKeys.enumerated()), id: \.offset) { index, element in
                        Button(action: {
                            withAnimation(.easeInOut) {
                                viewModel.selectedCategory = element
                            }
                        }) {
                            if viewModel.selectedCategory == element {
                                Text(element.capitalized)
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(Color.white)
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(12)
                            } else {
                                Text(element.capitalized)
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(Color.black)
                                    .padding()
                            }
                        }
                    }
                } // HStack
            } // ScrollView
            .frame(width: geometry.size.width * 0.95, height: 60)
            .background(Color.offWhite)
            .frame(width: geometry.size.width)
        } // GeometryReader
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
