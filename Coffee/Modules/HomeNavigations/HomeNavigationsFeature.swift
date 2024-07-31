//
//  HomeNavigationsView.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 01/11/23.
//

import Foundation
import ComposableArchitecture

struct HomeNavigationsFeature:Reducer{

    struct State :Equatable {
      
        var homePaths = StackState<HomePaths.State>()
        var homeFeature = HomeFeature.State()
    }
    enum Action:Equatable{
        case homePaths(StackAction<HomePaths.State,HomePaths.Action>)
       
        case homeFeature(HomeFeature.Action)
    }
    struct HomePaths:Reducer{
        enum State:Equatable{
            case coffeeDetail(CoffeeDetailsFeature.State)
            case coffeeOrder(CoffeeOrderFeature.State)
            case deliveryMap(DeliveryMapFeature.State)
        }
        enum Action:Equatable{
            case coffeeDetail(CoffeeDetailsFeature.Action)
            case coffeeOrder(CoffeeOrderFeature.Action)
            case deliveryMap(DeliveryMapFeature.Action)
        }
        var body: some ReducerOf<Self>{
            Scope(state: /State.coffeeDetail, action: /Action.coffeeDetail){
                CoffeeDetailsFeature()
            }
            Scope(state: /State.coffeeOrder, action: /Action.coffeeOrder){
                CoffeeOrderFeature()
            }
        }
    }
    var body: some ReducerOf<Self>{
        //root
        Scope(state: \.homeFeature, action: /Action.homeFeature){
            HomeFeature()
        }
        Reduce{ state, action in
            switch action{
          
            case .homePaths(_):
                return .none
            case .homeFeature(.delegate(.hideBottomBar)):
                print(".homeFeature(.delegate(.hideBottomBar))")
                return .none
            case .homeFeature(.delegate(.showBottomBar)):
                print(".homeFeature(.delegate(.showBottomBar))")
                return .none
            case .homeFeature(.delegate(.testing)):
                return .none
            case .homeFeature(_):
                print(".homeFeature (Home nav feature)")
                return .none
            }
        }
        .forEach(\.homePaths, action: /Action.homePaths){
            HomePaths()
        }
    }
}
