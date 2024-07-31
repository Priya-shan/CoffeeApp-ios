//
//  CoffeeOrderFeature.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 01/11/23.
//
import Foundation
import ComposableArchitecture

struct CoffeeOrderFeature:Reducer{
    struct State:Equatable{
        var selectedCategoryIndex:Int = 0
        var coffeeItem:CoffeeModel
        var quantity:Int = 1
        var finalAmount:Float = 0.0
        var deliveryFee:Float = 2.00
        
        init(selectedCategoryIndex: Int, coffeeItem: CoffeeModel, quantity: Int, finalAmount: Float,deliveryFee:Float) {
            self.selectedCategoryIndex = selectedCategoryIndex
            self.coffeeItem = coffeeItem
            self.quantity = quantity
            self.finalAmount = coffeeItem.amount
            self.deliveryFee = deliveryFee
        }
    }
    enum Action:Equatable{
        case setSelecetdIndex(Int)
        case setQuantity(Int)
    }
    var body: some ReducerOf<Self>{
        Reduce{state,  action in
            switch action{
            case let .setSelecetdIndex(index):
                print("setSelecetdIndex button triggereed")
                state.selectedCategoryIndex = index
                if(index == 1){
                    state.deliveryFee = 0.00
                }
                return .none
            case let .setQuantity(quantity):
                if(quantity>0){
                    state.quantity = quantity
                    state.finalAmount = state.coffeeItem.amount * Float(quantity)
                }
                return.none
            }
        
            }
        }
    }

