//
//  CoffeeClass.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 31/10/23.
//

import Foundation
struct CoffeeModel:Equatable,Identifiable,Codable{
    var title:String
    var description:String
//    var ingredients:[String]
    var image:String
    var id:String
    var subname:String
    var amount:Float
    var rating:Double
    var ratingCount:Int
    var category:String
    
    init(title:String, description:String,image:String,id:String,subname:String,amount:Float,rating:Double,ratingCount:Int,category:String) {
        self.title = title
        self.description = description
        self.image = image
        self.id = id
        self.amount = amount
        self.subname = subname
        self.rating = rating
        self.ratingCount = ratingCount
        self.category = category
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.image = try container.decode(String.self, forKey: .image)
        self.id = try container.decode(String.self, forKey: .id)
        self.subname = try container.decode(String.self, forKey: .subname)
        self.amount = try container.decode(Float.self, forKey: .amount)
        self.rating = try container.decode(Double.self, forKey: .rating)
        self.ratingCount = try container.decode(Int.self, forKey: .ratingCount)
        self.category = try container.decode(String.self, forKey: .category)
    }
    
  
}
