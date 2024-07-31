//
//  SegmentPickerView.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 01/11/23.
//

import SwiftUI
import ComposableArchitecture

struct SegmentedPickerView1: View {
    let store : StoreOf<HomeFeature>
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
                            .padding()
                            .background(viewStore.selectedCategoryIndex == index ? Color("primaryColor") : Color.white)
                            .foregroundColor(viewStore.selectedCategoryIndex == index ? Color.white : Color.black)
                            .font(font)
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}


//#Preview {
//    SegmentedPickerView1()
//}
