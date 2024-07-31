//
//  LikedItemsView.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 30/10/23.
//

import Foundation
import ComposableArchitecture
struct LikedItemsFeature:Reducer{
    struct State:Equatable{
        var likedItemsList:IdentifiedArrayOf<LikedItemsModel> = []
        var likedCoffeeList:IdentifiedArrayOf<CoffeeModel> = []
        var homeFeatureState=HomeFeature.State()
        
    }
    enum Action:Equatable{
        case fetchLikedItems
        case likedItemsResponse([LikedItemsModel])
        case addLikedItem(LikedItemsModel)
        case removeLikedItem(String)
        case generatelikedItemsList
        case homeFeatureAction(HomeFeature.Action)
        case delegate(Delegate)
        enum Delegate{
            case fetchLikedItems
            case showBottomBar
            case testing
        }
        case getItems
    }
    @Dependency(\.apiClient) var apiClient
    var body: some ReducerOf<Self>{
        Scope(state: \.homeFeatureState, action: /Action.homeFeatureAction){
            HomeFeature()
        }
        Reduce{ state, action in
            switch action{
                
            case .fetchLikedItems:
//                print("******-----calling fetching action----******")
//                print(state.homeFeatureState.cardsList)
//                return .none
                return .send(.delegate(.fetchLikedItems))
//                return .run{ send in
//                    let apiResponse = try await apiClient.getLikedItems()
//                    switch apiResponse{
//                    case .success( let myLikedItemsList):
//                        return await send(.likedItemsResponse(myLikedItemsList))
//                    case .failure(_):
//                        print("COffees fetch failed ")
//                    }
//                }
            case let .likedItemsResponse(myLikedItemsList):
                state.likedItemsList = IdentifiedArray(uniqueElements: myLikedItemsList)
                return .none
                
            case let .addLikedItem(likedItem):
                return .run{ send in
                    let apiResponse = try await apiClient.postLikedItems(likedItem)
                    switch apiResponse{
                    case .success( _):
                        print("Added Successfully")
                        return
                    case let .failure(error):
                        print("Adding liked items failed miserably \(error)")
                    }
                }
            case let .removeLikedItem(likeId):
                return .run{ send in
                    let apiResponse = try await apiClient.deleteLikedItems(likeId)
                    switch apiResponse{
                    case .success( _):
                        print("Added Successfully")
                        return
                    case let .failure(error):
                        print("Adding liked items failed miserably \(error)")
                    }
                }
            case .generatelikedItemsList:
                print("-----generated value-----")
                print(state.homeFeatureState.cardsList)
                print(state.likedItemsList)
//                let likedCoffeeList = state.coffeeList.filter { coffee in
//                    // Check if coffee's id is in likedItems
//                    return state.likedItemsList.contains { likedItem in
//                        return likedItem.coffeeId == coffee.id
//                    }
//                }
                return .none
                
            case .homeFeatureAction(_):
                return .none
            case .delegate(_):
                return  .none
            case .getItems:
                print("------------final get---------------")
                print(state.likedCoffeeList)
                print("------------final get---------------")
                return .none
            }
        }
    }
}
