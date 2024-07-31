//
//  HomeNavigationsFeature.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 01/11/23.
//

import SwiftUI
import ComposableArchitecture

struct HomeNavigationsView: View {
    let store:StoreOf<HomeNavigationsFeature>
    var body: some View {
        NavigationStackStore(self.store.scope(state: \.homePaths, action: {.homePaths($0)})) {
            WithViewStore(store, observe: {$0}) { viewStore in
                
                HomeView(store: store.scope(state: \.homeFeature, action: {.homeFeature($0)}))
                    
            }
        } destination: { state in
            
            switch state {
            case .coffeeDetail(_):
                CaseLet(/HomeNavigationsFeature.HomePaths.State.coffeeDetail, action: HomeNavigationsFeature.HomePaths.Action.coffeeDetail) { store in
                    CoffeeDetailsView(store:store)
                }
                
            case .coffeeOrder(_):
                CaseLet(/HomeNavigationsFeature.HomePaths.State.coffeeOrder, action: HomeNavigationsFeature.HomePaths.Action.coffeeOrder) { store in
                    CoffeeOrdersView(store:store)
                }
            case .deliveryMap(_):
                CaseLet(/HomeNavigationsFeature.HomePaths.State.deliveryMap,action: HomeNavigationsFeature.HomePaths.Action.deliveryMap){store in
                    DeliveryMapView(store:store)
                }
            }
        }
    }

}

#Preview {
    HomeNavigationsView(store: Store(initialState: HomeNavigationsFeature.State(), reducer: {
        HomeNavigationsFeature()
    }))
}
