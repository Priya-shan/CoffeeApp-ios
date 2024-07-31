//
//  CoffeeApp.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 17/10/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct CoffeeApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
            AppView(store: Store(initialState: AppFeature.State(), reducer: {
                AppFeature()
            }))
//            BottomTabBar(store: Store(initialState: BottomTabBarFeature.State(), reducer:{ BottomTabBarFeature()}))
//            HomeView(store: Store(initialState: HomeFeature.State(cardsList: [CoffeeModel(title: "", description: "", image: "", id: "dknkns",subname: "",amount: 1.0,rating: 4.3,ratingCount: 120, category: "")])){
//                    HomeFeature()
//                })
        }
    }
}
