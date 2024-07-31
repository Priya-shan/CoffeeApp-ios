//
//  AsyncImageView.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 31/10/23.
//

import SwiftUI
import ComposableArchitecture

struct AsyncImageView: View {
    let store : StoreOf<AsyncImageFeature>
    var body: some View {
        WithViewStore(self.store, observe: {$0}){ viewStore in
            AsyncImage(url: URL(string: viewStore.imageUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView() 
                case .success(let image):
                    image
                        .resizable()
                case .failure:
                    Image(systemName: "exclamationmark.triangle")
                @unknown default:
                    EmptyView()
                }
            }
        }
    }}

#Preview {
    AsyncImageView(store: Store(initialState: AsyncImageFeature.State(imageUrl:"https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Latte_at_Doppio_Ristretto_Chiang_Mai_01.jpg/509px-Latte_at_Doppio_Ristretto_Chiang_Mai_01.jpg"), reducer: {
        AsyncImageFeature()
    }))
}
