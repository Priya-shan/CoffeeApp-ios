//
//  LikedItemsView.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 18/10/23.
//

import SwiftUI
import ComposableArchitecture

struct LikedItemsView: View {
    let store : StoreOf<LikedItemsFeature>
    let likedItemyDummy:LikedItemsModel = LikedItemsModel(likeId: "7", coffeeId: "7", userId: "user1")
    let likeId:String = "3"
    var body: some View {
        WithViewStore(self.store, observe: {$0}){ viewStore in
            VStack{
                ScrollView{
                    Text("Liked Items")
                    ForEach(viewStore.likedItemsList){ item in
                        Text("\(item.coffeeId)")
                        Text("\(item.id)")
                        Text("\(item.userId)")
                    }
                    ForEach(viewStore.likedCoffeeList){
                        item in
                        Cards(card: item)
                    }
                    //                Button("get"){
                    //                    viewStore.send(.getItems)
                    //                }
                    Button("post"){
                        viewStore.send(.addLikedItem(likedItemyDummy))
                    }
                    Button("Delete"){
                        viewStore.send(.removeLikedItem(likeId))
                    }
                    Button("test"){
                        viewStore.send(.generatelikedItemsList)
                    }
                    Spacer()
                }.onAppear(){
                    print("liked view page appeared")
                    viewStore.send(.fetchLikedItems)
                }}
        }
        
    }
}

#Preview {
    LikedItemsView(store: Store(initialState: LikedItemsFeature.State(), reducer: {
        LikedItemsFeature()
    }))
}
