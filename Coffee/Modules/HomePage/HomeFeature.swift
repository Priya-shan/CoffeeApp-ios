//
//  HomeFeature.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 30/10/23.
//

import Foundation
import ComposableArchitecture

struct HomeFeature:Reducer{
    struct State :Equatable{
        var cardsList = IdentifiedArrayOf<CoffeeModel>()
        var coffeeCategoryList:[String] = []
        var selectedCategoryIndex:Int = 0
        var selectedCategory:String = ""
        var filteredCoffeeList : [CoffeeModel] = []
//        var bottomBarVisibility = BottomTabBarFeature.State()
    }
    enum Action:Equatable{
        case fetchCoffees
        case coffeesResponse([CoffeeModel],[String])
        case setCoffeeCategoryList
        case setSelecetdIndex(Int)
        case testing
//        case bottomBarVisibility(BottomTabBarFeature.Action)
//        case toggleBottomBarVisibility
        case delegate(Delegate)
        enum Delegate{
            case hideBottomBar
            case showBottomBar
            case testing
        }
        case onHomeScreenDisappear
        case onHomeScreenAppear
    }
    
    @Dependency(\.apiClient) var apiClient
    var body: some ReducerOf<Self>{
        
        Reduce{ state, action in
            switch action{
                
            case .fetchCoffees:
                return .run{ send in
                    let apiResponse = try await apiClient.getCoffees()
                    switch apiResponse{
                    case .success( let myCardsList):
                        let uniqueCategories = Set(myCardsList.map { $0.category })
                        let uniqueCategoryList = Array(uniqueCategories)
                        return await send(.coffeesResponse(myCardsList,uniqueCategoryList))
                    case .failure(_):
                        print("COffees fetch failed ")
                    }
                }
            case let .coffeesResponse(myCardsList,uniqueCategoryList):
                state.cardsList = IdentifiedArray(uniqueElements: myCardsList)
                state.coffeeCategoryList = uniqueCategoryList
                print(state.coffeeCategoryList)
                print(state.coffeeCategoryList.count)
                let categoryName = state.coffeeCategoryList[0]
                state.filteredCoffeeList = state.cardsList.filter({$0.category == categoryName})
                return .none
            case .setCoffeeCategoryList:
                return .none
            case let .setSelecetdIndex(index):
                state.selectedCategoryIndex = index
                let categoryName = state.coffeeCategoryList[index]
                let filteredCoffeeList = state.cardsList.filter({$0.category == categoryName})
                state.filteredCoffeeList = filteredCoffeeList.elements
                return .none
            case .testing:
                return .send(.delegate(.testing))
            case .delegate(_):
                print(".delegate (in home feature)")
                return .none
            case .onHomeScreenDisappear:
                print(".onHomeScreenDisappear")
                return .send(.delegate(.hideBottomBar))
            case .onHomeScreenAppear:
                print(".onHomeScreenAppear")
                return .send(.delegate(.showBottomBar))
            }
        
        
        }
    }
}
