//
//  AppFeature.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 30/10/23.
//

import Foundation
import ComposableArchitecture
struct AppFeature:Reducer{
    struct State:Equatable{
        var selectedTab: BottomTabBarFeature.Tabs = .homeTab
        var isBottomBarVisible = true
        var homeNavigation = HomeNavigationsFeature.State()
        var likedItems = LikedItemsFeature.State()
        var bottomTabBarState=BottomTabBarFeature.State()
        var filteredCoffeeList:IdentifiedArrayOf<CoffeeModel> = []
        
    }
    enum Action{
        
        case homeNavigation(HomeNavigationsFeature.Action)
        case likedItems(LikedItemsFeature.Action)
        case bottomTabBarAction(BottomTabBarFeature.Action)
        case likedItemsResponse([LikedItemsModel])
    }
    var body: some ReducerOf<Self>{
        Scope(state: \.homeNavigation, action: /Action.homeNavigation){
            HomeNavigationsFeature()
        }
        Scope(state: \.likedItems, action: /Action.likedItems){
            LikedItemsFeature()
        }
        Scope(state: \.bottomTabBarState, action: /Action.bottomTabBarAction){
            BottomTabBarFeature()
        }
        @Dependency(\.apiClient) var apiClient
        Reduce{state, action in
            switch action{
            case .homeNavigation(.homeFeature(.delegate(.testing))):
                print("-------------Testing----------------")
                print(state.homeNavigation.homeFeature.cardsList)
                return .none
            case let .bottomTabBarAction(.delegate(.setTabIndex(tabItem))):
                print(".setTabIindex in AppFeature(parent)")
                state.selectedTab = tabItem
                return .none
            case .likedItems(.delegate(.fetchLikedItems)):
                return .run { send in
                    let apiResponse = try await apiClient.getLikedItems()
                    switch apiResponse {
                    case .success(let myLikedItemsList):
                        return await send(.likedItemsResponse(myLikedItemsList))
                    case .failure(_):
                        print("Liked items fetch failed")
                    }
                }
            case .bottomTabBarAction(_):
                return .none
            case .homeNavigation(_):
                return .none
            case .likedItems(_):
                return .none
            case let .likedItemsResponse(myLikedItemsList):
                state.likedItems.likedItemsList = IdentifiedArray(uniqueElements: myLikedItemsList)
                
                // Filter the coffee list to include only liked coffee items
                state.filteredCoffeeList = state.homeNavigation.homeFeature.cardsList.filter { coffee in
                    // Check if coffee's ID is in likedItems
                    return state.likedItems.likedItemsList.contains { likedItem in
                        return likedItem.coffeeId == coffee.id
                    }
                }
                state.likedItems.likedCoffeeList = state.filteredCoffeeList
                return .none
            }
        }
    }
}
