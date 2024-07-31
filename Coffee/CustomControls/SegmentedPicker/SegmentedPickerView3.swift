//
//  SegmentPickerView3.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 01/11/23.
//

import SwiftUI
import ComposableArchitecture
struct SegmentPickerView3: View {
    let store : StoreOf<CoffeeOrderFeature>
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
//                        selectedIndex = index
                    }) {
                        Text(titles[index])
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(viewStore.selectedCategoryIndex == index ? Color("primaryColor") : Color.white)
                            .foregroundColor(viewStore.selectedCategoryIndex == index ? Color.white : Color.black)
                            .font(font)
                            .bold()
                            .cornerRadius(15)
                    }
                }
            }
        }
    }
}

#Preview {
    SegmentPickerView3(store: Store(
        initialState: CoffeeOrderFeature.State(selectedCategoryIndex: 0, coffeeItem: CoffeeModel(title: "", description: "", image: "", id: "", subname: "", amount: 3.0, rating: 4.3, ratingCount: 230, category: ""), quantity: 1, finalAmount: 4.3, deliveryFee: 2.00),
        reducer: {
            CoffeeOrderFeature()
        }
    ), titles: ["Deliver", "Pick Up"], font: .system(size: 15))
}
