//
//  CoffeeDetailsView.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 01/11/23.
//

import SwiftUI
import ComposableArchitecture

struct CoffeeDetailsView: View {
    let store :StoreOf<CoffeeDetailsFeature>
    var body: some View {
        WithViewStore(self.store, observe: {$0}){ viewStore in
            VStack{
                VStack{
                    AsyncImageView(store: Store(initialState: AsyncImageFeature.State(imageUrl:"\(viewStore.coffeeItem.image)"), reducer: {
                        AsyncImageFeature()
                    }))
                }
                .cornerRadius(30)
                .frame(width: .infinity,height: 250)
                Spacer()
                VStack{
                    Spacer()
                    VStack(alignment:.leading){
                        Text("\(viewStore.coffeeItem.title)").font(.title).bold().foregroundStyle(.black)
                        Text("\(viewStore.coffeeItem.subname)")
                        
                    }
                    .frame(maxWidth:.infinity, alignment: .leading)
                    HStack{
                        Image(systemName: "star.fill").foregroundColor(.yellow)
                        Text("\(viewStore.coffeeItem.rating.formatted())").bold()
                        Text("(\(viewStore.coffeeItem.ratingCount))")
                        Spacer()
                        Image("icon-bean")
                            .resizable()
                            .frame(width: 25,height: 25)
                            .padding(9)
                            .background(Color.mildWhite)
                            .cornerRadius(10)
                        Image("icon-milk")
                            .resizable()
                            .frame(width: 25,height: 25)
                            .padding(9)
                            .background(Color.mildWhite)
                            .cornerRadius(10)
                    }
                    Divider()
                    Spacer()
                    VStack(alignment:.leading){
                        Text("Description").font(.title2).bold()
                        VStack{
                            Text(String(viewStore.coffeeItem.description.prefix(100)+"..."))
                                .foregroundColor(.gray) +
                            Text(" Read More")
                                .foregroundColor(.orange)
                        }
                        .onTapGesture {
                            
                        }
                    }
                    Spacer()
                    VStack(alignment:.leading){
                        Text("Size").font(.title2).bold()
                        SegmentedPickerView2(store: store, titles: ["S","M","L"], font:.system(size: 15))
                    }.frame(maxWidth:.infinity, alignment: .leading)
                    Spacer()
                    VStack{
                        HStack{
                            VStack(alignment: .leading){
                                Text("Price")
                                    .foregroundColor(.gray)
                                Text("$ \(String(format: "%.2f", viewStore.updatedAmount))").font(.title2).bold()
                                    .foregroundStyle(Color("primaryColor"))
                            }
                            Spacer()
                            NavigationLink(
                                state: HomeNavigationsFeature.HomePaths.State.coffeeOrder(CoffeeOrderFeature.State(selectedCategoryIndex: 0, coffeeItem: viewStore.coffeeItem, quantity: 1, finalAmount: 4.3, deliveryFee: 2.00))
                            )
                            {
                                Button("Buy Now") {}
                                    .font(.title3).bold()
                                    .frame(width: 150, height: 30)
                                    .padding(20)
                                    .background(Color("primaryColor"))
                                    .cornerRadius(20)
                            }.navigationTitle("Display")
                                
                        }
                        .padding()
                        
                    }.background(Color("mildWhite"))
                        .background(UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 20,bottomLeading: 10,bottomTrailing: 10,topTrailing: 20)))
                        .foregroundColor(.white)
                }.padding(.horizontal,15)
            }
            .onAppear(){
                viewStore.send(.onAppearCase(viewStore.coffeeItem.id))
            }
            .toolbar{
                ToolbarItem{
                    Image(systemName: viewStore.isCoffeeLiked ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                        .onTapGesture(){
                            viewStore.isCoffeeLiked ?
                            viewStore.send(.addCoffeeToLikedItems(LikedItemsModel(likeId: UUID().uuidString, coffeeId: viewStore.coffeeItem.id, userId: "user1")))
                            :
                            viewStore.send(.removeCoffeeFromLikedItems)
                        }
                }
            }
            .padding()
            
        }}
}

#Preview {
    CoffeeDetailsView(store: Store(initialState: CoffeeDetailsFeature.State(selectedCategoryIndex: 0, coffeeItem: CoffeeModel(title: "Black", description: "Black coffee is as simple as it gets with ground coffee beans steeped in hot water, served warm. And if you want to sound fancy, you can call black coffee by its proper name: cafe noir.", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Hokitika_Cheese_and_Deli%2C_Hokitika_%283526706594%29.jpg/1280px-Hokitika_Cheese_and_Deli%2C_Hokitika_%283526706594%29.jpg", id: "1", subname: "With Chocolate", amount: 4.53, rating: 4.3, ratingCount: 230, category: "cappuccino"),updatedAmount: 0.0, likedItems:[ LikedItemsModel(likeId: "", coffeeId: "", userId: "")], isCoffeeLiked: false, currentLikedItemId: ""), reducer: {
        CoffeeDetailsFeature()
    }))
}
