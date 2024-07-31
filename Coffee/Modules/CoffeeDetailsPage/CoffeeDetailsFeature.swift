//
//  CoffeeDetailsFeature.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 01/11/23.
//

import Foundation
import ComposableArchitecture

struct CoffeeDetailsFeature:Reducer{
    
 
    
    struct State:Equatable{
        var selectedCategoryIndex:Int = 2
//        var isLiked:Bool = false
        var coffeeItem : CoffeeModel = CoffeeModel(title: "", description: "", image: "", id: "", subname: "", amount: 3.0, rating: 4.3, ratingCount: 230, category: "")
        var updatedAmount:Float = 0.0
        var coffeeListFromHomeFeature = HomeFeature.State()
        var likedItems : IdentifiedArrayOf<LikedItemsModel>
        var currentlikedItemId:String?
        var isCoffeeLiked : Bool
        init(selectedCategoryIndex: Int, coffeeItem: CoffeeModel, updatedAmount: Float, likedItems:IdentifiedArrayOf<LikedItemsModel>, isCoffeeLiked:Bool, currentLikedItemId:String) {
            self.selectedCategoryIndex = selectedCategoryIndex
            self.coffeeItem = coffeeItem
            self.updatedAmount = coffeeItem.amount
            self.likedItems = likedItems
            self.isCoffeeLiked = isCoffeeLiked
            self.currentlikedItemId = currentLikedItemId
//            self.isLiked = isLiked
        }
        
    }
    enum Action:Equatable{
        case setSelecetdIndex(Int)
        case addCoffeeToLikedItems(LikedItemsModel)
        case coffeeListFromHomeFeature(HomeFeature.Action)
        case onAppearCase(String)
        case setIsCoffeeLiked(Bool)
        case removeCoffeeFromLikedItems
        case setCurretLikeId(String)
    }
    @Dependency(\.apiClient) var apiClient
    var body: some ReducerOf<Self>{
//        Scope(state: \.coffeeListFromHomeFeature, action: /Action.coffeeListFromHomeFeature){
//            HomeFeature()
//        }
        
        Reduce{state,  action in
            
            // Function to check if the item is liked by the user
            func checkLikedItem(id: String,state: inout State) async -> Bool {
                   print("inside function  \(id)")
                do{
                    let apiResponse = try await apiClient.getLikedItems()
                    switch apiResponse {
                    case .success(let myLikedItemsList):
                        print("entered success")
                        // Check if any liked item matches the given criteria
//                        let isLiked = myLikedItemsList.contains { likedItem in
//                            return likedItem.coffeeId == id && likedItem.userId == "user1"
//                        }
//                        return isLiked
                        if let likedItem = myLikedItemsList.first(where: { $0.coffeeId == id && $0.userId == "user1" }) {
                            state.currentlikedItemId = likedItem.id
                            print("liked item id \(likedItem.id)")
//                            await send(.setCurretLikeId(likedItem.id))
                            return true
                        } else {
                            return false
                        }
                    case .failure(let error):
                        print("entered failure")
                        print("Liked items fetch failed with error: \(error)")
                        // Handle failure case if needed
                        return false
                    }
                    
                }
                catch{
                    print("Error fetching liked items: \(error)")
                }
                return false
               }
            
            switch action{
            case let .setSelecetdIndex(index):
                print("setSelecetdIndex button triggereed")
                state.selectedCategoryIndex = index
                switch index{
                case 0:
                    state.updatedAmount = state.coffeeItem.amount/3
                case 1:
                    state.updatedAmount = state.coffeeItem.amount/2
                default:
                    state.updatedAmount = state.coffeeItem.amount
                }
                return .none
            case let .addCoffeeToLikedItems(likedItemModel):
                return .run{ send in
                    let apiResponse = try await apiClient.postLikedItems(likedItemModel)
                    switch apiResponse{
                    case .success( _):
                        print("Added Successfully")
                        return
                    case let .failure(error):
                        print("Adding liked` items failed miserably \(error)")
                    }
                }
            case let .onAppearCase(id):
                return .run { send in
//                    let currentState = state // Create a local copy of the state
                    
//                    async {
//                        do {
//                            let isLiked = try await checkLikedItem(id: id, state: &currentState)
//                            if isLiked {
//                                send(.setIsCoffeeLiked(true))
//                            } else {
//                                send(.setIsCoffeeLiked(false))
//                            }
//                        } catch {
//                            // Handle the error if necessary
//                        }
//                    }
                }

            case let .setIsCoffeeLiked(value):
                state.isCoffeeLiked = value
                return .none
            case .coffeeListFromHomeFeature(_):
                return .none
            case .removeCoffeeFromLikedItems:
                return .none
            case let .setCurretLikeId(id):
                state.currentlikedItemId = id
                return .none
            }
        }
    }
}
//= CoffeeModel(title: "", description: "", image: "", id: "", subname: "", amount: 3.0, rating: 4.3, ratingCount: 230, category: "")
