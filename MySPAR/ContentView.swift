//
//  ContentView.swift
//  MySPAR
//
//  Created by Никита Сигал on 31.01.2024.
//

import SwiftUI

struct ContentView: View {
    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        if #available(iOS 15.0, *) {
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        }
    }

    var body: some View {
        TabView {
            ProductView()
                .tabItem {
                    Label("Главная", systemImage: "tree.circle")
                }
            Text("Catalogue placeholder")
                .tabItem {
                    Label("Каталог", systemImage: "square.grid.2x2")
                }
            Text("Cart placeholder")
                .tabItem {
                    Label("Корзина", systemImage: "cart")
                }
            Text("Profile placeholder")
                .tabItem {
                    Label("Профиль", systemImage: "person")
                }
        }
    }
}

#Preview {
    ContentView()
}
