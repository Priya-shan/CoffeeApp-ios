//
//  AsyncImageFeature.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 31/10/23.
//

import Foundation
import ComposableArchitecture
struct AsyncImageFeature:Reducer{
    struct State : Equatable{
        var imageUrl:String
    }
    enum Action{
        
    }
    var body: some ReducerOf<Self>{
        Reduce{ state, action in
            switch action{
                
            }
        }
    }
}
