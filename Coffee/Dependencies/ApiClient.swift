//
//  ApiClient.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 31/10/23.
//

import Foundation
import ComposableArchitecture

struct ApiClient{
    var getCoffees:() async throws -> Result<[CoffeeModel],ApiError>
    var getLikedItems:() async throws -> Result<[LikedItemsModel],ApiError>
    var postLikedItems:(LikedItemsModel) async throws -> Result<String,ApiError>
    var deleteLikedItems:(String) async throws -> Result<String,ApiError>
}
enum ApiError:Error{
    case urlParseFailed
    case dataFetchFailed
    case dataParseFailed
}
extension ApiClient:DependencyKey{
    static let liveValue = ApiClient (
        getCoffees:  {
            print("entered getCoffes inside apiclient")
            guard let url = URL(string: "http://localhost:3000/coffees") else{
                return .failure(.urlParseFailed)
            }
            guard let (data,response) = try? await URLSession.shared.data(from: url) else{
                return .failure(.dataFetchFailed)
            }
            guard let coffees = try? JSONDecoder().decode([CoffeeModel].self, from: data) else{
                return .failure(.dataParseFailed)
            }
            return .success(coffees)
            
        },
        getLikedItems:  {
            print("entered getCoffes inside apiclient")
            guard let url = URL(string: "http://localhost:3000/likedItems") else{
                return .failure(.urlParseFailed)
            }
            guard let (data,response) = try? await URLSession.shared.data(from: url) else{
                return .failure(.dataFetchFailed)
            }
            guard let likedItems = try? JSONDecoder().decode([LikedItemsModel].self, from: data) else{
                return .failure(.dataParseFailed)
            }
            return .success(likedItems)
        },
        postLikedItems: { likedItemModel in
            
            guard let jsonData = try? JSONEncoder().encode(likedItemModel) else {
                return .failure(.dataParseFailed)
            }
            
            var request = URLRequest(url: URL(string: "http://localhost:3000/likedItems")!)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            guard let (data, response) = try? await URLSession.shared.data(for: request) else {
                return .failure(.dataFetchFailed)
            }
            
            if let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode != 200 {
                return .failure(.dataFetchFailed)
            }
            
            guard let responseLikedItem = try? JSONDecoder().decode(LikedItemsModel.self, from: data) else {
                return .failure(.dataParseFailed)
            }
            
            return .success("Posted Successfully")
        },
        deleteLikedItems: { likeId in
            guard let url = URL(string: "http://localhost:3000/likedItems/\(likeId)") else {
                return .failure(.urlParseFailed)
            }
            var request = URLRequest(url: URL(string: "http://localhost:3000/likedItems/\(likeId)")!)
            request.httpMethod = "DELETE"
            
            guard let (data, response) = try? await URLSession.shared.data(for: request) else {
                return .failure(.dataFetchFailed)
            }
            
            if let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode != 200 {
                return .failure(.dataFetchFailed)
            }
            return .success("Deleted Successfully")
        }
    )
}
extension DependencyValues{
    var apiClient:ApiClient{
        get {self[ApiClient.self]}
        set {self[ApiClient.self] = newValue}
    }
}
