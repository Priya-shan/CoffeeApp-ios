//
//  AppView.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 30/10/23.
//

import SwiftUI
import ComposableArchitecture
struct AppView: View {
    let store : StoreOf<AppFeature>
    var body: some View {
        WithViewStore(self.store, observe: {$0}){ viewStore in
        VStack(spacing: 0) {
                switch viewStore.selectedTab {
                case .homeTab:
                    HomeNavigationsView(store: self.store.scope(state: \.homeNavigation, action: {.homeNavigation($0)}))
                case .likedItemsTab:
                    LikedItemsView(store: self.store.scope(state: \.likedItems, action: {.likedItems($0)}))
                case .ordersTab:
                    OrdersView()
                case .notificationsTab:
                    NotificationsView()
                }
                //                if(viewStore.isBottomBarVisible){
                HStack {
                    BottomTabBarView(store: self.store.scope(state: \.bottomTabBarState, action: {.bottomTabBarAction($0)}))
                }
                .frame(maxHeight: 50, alignment: .bottom)
                .background(Color("MildWhite"))
                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 30, topTrailingRadius: 30))
            }
            //                }
            .onAppear(){
                //                viewStore.send(.testing)
            }
            .background(Color("MildWhite"))
        }
    }
}

#Preview {
    AppView(store: Store(initialState: AppFeature.State(), reducer: {
        AppFeature()
    }))
}
