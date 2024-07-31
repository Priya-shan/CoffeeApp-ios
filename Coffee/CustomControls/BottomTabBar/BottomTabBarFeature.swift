//
//  BottomTabBarFeature.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 31/10/23.
//

import Foundation
import ComposableArchitecture

struct BottomTabBarFeature:Reducer{
    struct State:Equatable{
        var selectedTab: Tabs = .homeTab
        var isBottomBarVisible = true

        var homeNavigation = HomeNavigationsFeature.State()
        var likedItems = LikedItemsFeature.State()
        
    }
    enum Action{
        case setTabIndex(Tabs)
        case delegate(Delegate)
        enum Delegate{
            case setTabIndex(Tabs)
        }
        case homeNavigation(HomeNavigationsFeature.Action)
        case likedItems(LikedItemsFeature.Action)
//        case testing
    }
    
    var body:some ReducerOf<Self>{

//        Scope(state: \.homeNavigation, action: /Action.homeNavigation){
//            HomeNavigationsFeature()
//        }
//        Scope(state: \.likedItems, action: /Action.likedItems){
//            LikedItemsFeature()
//        }
        Reduce{state, action in
            switch action{
                
            case let .setTabIndex(tab):
//                state.selectedTab = tab
                print(".setTabIindex in bottomTabBar(child)")
                return .send(.delegate(.setTabIndex(tab)))
            case .homeNavigation(.homeFeature(.delegate(.testing))):
                print("-------------Testing----------------")
                print(state.homeNavigation.homeFeature.cardsList)
                return .none
            case .homeNavigation(.homeFeature(.delegate(.showBottomBar))):
                state.isBottomBarVisible=true
                return .none
            case .homeNavigation(.homeFeature(.delegate(.hideBottomBar))):
                state.isBottomBarVisible=false
                return .none

            case .homeNavigation(_):
                print(".homeNavigation")
                return .none
            case .likedItems(_):
                return .none
            case .delegate(_):
                return .none
            }
        }
    }
    
    enum Tabs{
        case homeTab
        case notificationsTab
        case likedItemsTab
        case ordersTab
    }

}
