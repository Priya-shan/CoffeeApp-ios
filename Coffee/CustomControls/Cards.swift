//
//  Cards.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 17/10/23.
//

import SwiftUI
import ComposableArchitecture

struct Cards: View {
    var card:CoffeeModel
    var body: some View {
            VStack(alignment: .leading){
//                Image(card.imageName)
//                    .resizable()
//                    .frame(width: 150,height: 130)
//                    .scaledToFit()
//                    .cornerRadius(20)
                AsyncImageView(store: Store(initialState: AsyncImageFeature.State(imageUrl:"\(card.image)"), reducer: {
                    AsyncImageFeature()
                }))
                .frame(width: 150, height: 125)
                Text(card.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.leading,10)
                Text("with \(card.subname)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.leading,10)
                HStack{
                    Text("$\(String(format: "%.2f", card.amount))")
                        .font(.system(size: 22))
                        .foregroundColor(Color("darkGreen"))
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName: "plus")
                        .padding(10)
                        .background(Color("primaryColor"))
                        .cornerRadius(15)
                        .foregroundColor(.white)
                }.padding(.leading,10)
                
            }
            .overlay(
                UnevenRoundedRectangle(topLeadingRadius: 20,bottomTrailingRadius: 20)
                    .background(Color.gray).opacity(0.4)
                    .overlay(
                        HStack{
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("\(card.rating)")
                                .foregroundColor(.white)
                        }
                        
                    )
                    .frame(width: 70,height: 35)
                    .offset(x:-40,y:-95)
                    
            )
            .frame(width: 150)
                .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
                .padding()
                
    }
}
//
#Preview {
    Cards(card: CoffeeModel(title: "cpffee", description: "bl bla", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Latte_at_Doppio_Ristretto_Chiang_Mai_01.jpg/509px-Latte_at_Doppio_Ristretto_Chiang_Mai_01.jpg", id: "", subname: " choco", amount: 3.0, rating: 4.3, ratingCount: 230, category: ""))
}
