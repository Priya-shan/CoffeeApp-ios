//
//  SegmentedPickerView2.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 01/11/23.
//

import SwiftUI
import ComposableArchitecture

struct SegmentedPickerView2: View {
        let store : StoreOf<CoffeeDetailsFeature>
        let titles: [String]
        let font: Font
        var body: some View {
            WithViewStore(self.store, observe: {$0}){ viewStore in
                HStack {
                    //                Text("hello")
                    //                Text("\(viewStore.coffeeCategoryList.count)")
                    //                Text("\(titles.count)")
                    //                Text("ind \(viewStore.selectedCategoryIndex)")
                    ForEach(0..<titles.count, id: \.self) { index in
                        Button(action: {
                            print("button clicked")
                            viewStore.send(.setSelecetdIndex(index))
                            //selectedIndex = index
                        })
                        {
                            Text(titles[index])
                                .padding()
                                .frame(width: 100, height: 50)
                                .background(viewStore.selectedCategoryIndex == index ? Color("mildOrange") : Color.white)
                                .foregroundColor(viewStore.selectedCategoryIndex == index ? Color("primaryColor") : Color.black)
                                .font(font).bold()
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(viewStore.selectedCategoryIndex == index ? Color("primaryColor"): Color.gray, lineWidth: 1)
                                )
                        }
                        Spacer()
                        
                    }
                }
            }
    }
}
#Preview {
    SegmentedPickerView2(store:Store(initialState: CoffeeDetailsFeature.State(selectedCategoryIndex:0, coffeeItem:CoffeeModel(title: "", description: "", image: "", id: "", subname: "", amount: 3.0, rating: 4.3, ratingCount: 230, category: ""),updatedAmount: 0.0, likedItems: [LikedItemsModel(likeId: "", coffeeId: "", userId: "")], isCoffeeLiked: false, currentLikedItemId: ""), reducer: {CoffeeDetailsFeature()}), titles: ["S","M","L"],font:.system(size: 15))
    
}
