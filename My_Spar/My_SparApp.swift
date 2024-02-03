//
//  My_SparApp.swift
//  My_Spar
//
//  Created by Yaroslav Zagumennikov on 03.02.2024.
//

import SwiftUI

@main
struct My_SparApp: App {
    
    @StateObject var pvm = ProductViewModel()
    @State var selectedTab : Int = 0
    var body: some Scene {
        WindowGroup {
            
            TabView(selection: $selectedTab,
                    content:  {
                ProductView()
                    .environmentObject(pvm)
                    .tabItem {
                        Image(systemName: "tree.circle")
                        Text("Главная")
                    }.tag(1)
                
                Color.white
                    .tabItem {
                        Image(systemName: "app")
                        Text("Каталог")
                    }.tag(2)
                
                Color.white
                    .tabItem {
                        Image(systemName: "cart")
                        Text("Корзина")
                    }.tag(3)
                
                Color.white
                    .tabItem {
                        Image(systemName: "person")
                        Text("Профиль")
                    }.tag(4)
            })
            .tint(Color.green)
            
        }
    }
}
