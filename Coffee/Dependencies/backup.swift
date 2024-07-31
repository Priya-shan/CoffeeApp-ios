////
////  backup.swift
////  Coffee
////
////  Created by Shanmuga Priya M on 02/11/23.
////
//
//import Foundation
//
//getCoffees: do {
//    print("entered getCoffes inside apiclient")
//    guard let url = URL(string: "http://localhost:3000/coffees") else{
//        return .failure(.urlParseFailed)
//    }
//    guard let (data,response) = try? await URLSession.shared.data(from: url) else{
//        return .failure(.dataFetchFailed)
//    }
//    guard let coffees = try? JSONDecoder().decode([CoffeeModel].self, from: data) else{
//        return .failure(.dataParseFailed)
//    }
//    return .success(coffees)
//    
//}
//getLikedItems: do {
//    print("entered getCoffes inside apiclient")
//    guard let url = URL(string: "http://localhost:3000/likedItems") else{
//        return .failure(.urlParseFailed)
//    }
//    guard let (data,response) = try? await URLSession.shared.data(from: url) else{
//        return .failure(.dataFetchFailed)
//    }
//    guard let coffees = try? JSONDecoder().decode([LikedItemsModel].self, from: data) else{
//        return .failure(.dataParseFailed)
//    }
//    return .success(coffees)
