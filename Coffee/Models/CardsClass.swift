//
//  CardsClass.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 18/10/23.
//

import Foundation

class CardsClass:Equatable,Decodable{
    static func == (lhs: CardsClass, rhs: CardsClass) -> Bool {
            // Implement your custom comparison logic here
            // You can compare properties of CardsClass to determine equality
            return lhs.name == rhs.name &&
                lhs.subName == rhs.subName &&
                lhs.amount == rhs.amount &&
                lhs.imageName == rhs.imageName &&
                lhs.rating == rhs.rating
        }
    var name:String = ""
    var subName:String = ""
    var amount:String = ""
    var imageName:String = ""
    var rating:String = ""
    init(name: String, subName: String, amount: String, imageName: String, rating: String) {
        self.name = name
        self.subName = subName
        self.amount = amount
        self.imageName = imageName
        self.rating = rating
    }
    
}
extension CardsClass {
    static let mockData: [CardsClass] = [
        CardsClass(name: "Cappuccino", subName: "With Chocolate", amount: "$4.53", imageName: "coffee1", rating: "4.8"),
        CardsClass(name: "Cappuccino", subName: "With Oat Milk", amount: "$3.90", imageName: "coffee2", rating: "4.3"),
        CardsClass(name: "Cappuccino", subName: "With Chocolate", amount: "$4.53", imageName: "coffee3", rating: "4.5"),
        CardsClass(name: "Cappuccino", subName: "With Oat Milk", amount: "$3.90", imageName: "coffee4", rating: "4.2")
    ]
}
