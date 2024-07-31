//
//  LikedItemsModel.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 02/11/23.
//

import Foundation

struct LikedItemsModel:Equatable,Identifiable,Encodable,Decodable{
    var id:String
    var coffeeId:String
    var userId:String
    
    init(likeId: String, coffeeId: String, userId: String) {
        self.id = likeId
        self.coffeeId = coffeeId
        self.userId = userId
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.coffeeId = try container.decode(String.self, forKey: .coffeeId)
        self.userId = try container.decode(String.self, forKey: .userId)
    }
    
}
