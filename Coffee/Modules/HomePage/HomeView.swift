//
//  HomeView.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 30/10/23.
//
import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    @State var value:String = ""
//    @State private var selectedOption = 0
    let store : StoreOf<HomeFeature>
    
    var body: some View {
        
        WithViewStore(self.store, observe: {$0}) {viewStore in
            VStack{
                ZStack{
                    LinearGradient(colors: [Color("black1"),Color("black2")], startPoint: .topLeading, endPoint: .bottomTrailing)
                    
                    VStack{
                        HStack{
                            VStack(alignment: .leading){
                                Text("Location")
                                    .font(.caption)
                                HStack{
                                    Text("Bilzun, Thanjungbalai")
                                        .font(.title3)
                                    Image(systemName: "chevron.down")
                                }
                                
                            }
                            Spacer()
                            VStack{
                                Image("profile")
                                    .resizable()
                                    .frame(width: 70,height: 70)
                                    .cornerRadius(25)
                                    .onTapGesture {
                                        viewStore.send(.testing)
                                    }
                                
                            }
                            
                        }
                        .padding(.horizontal, 70)
                        .foregroundColor(.white)
                        HStack{
                            TextField("Search Coffee", text: $value)
                                .padding(15)
                                .padding(.leading, 35)
                                .background(RoundedRectangle(cornerRadius: 20).fill(Color("gray")))
                                .overlay(
                                    HStack {
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(.white)
                                            .padding(.leading, 10)
                                        Spacer()
                                        Image( systemName: "slider.horizontal.3")
                                            .foregroundColor(.white)
                                            .padding(.trailing, 10)
                                            .padding(15)
                                            .background(RoundedRectangle(cornerRadius: 20).fill(Color("primaryColor")))
                                        
                                    }
                                )
                                .foregroundColor(.gray)
                                .padding(.horizontal,60)
                                .padding(.leading, 10)
                        }
                        
                    }.padding(.top,-50)
                }.frame(width:500,height: 350)
                    .ignoresSafeArea(.all)
                ZStack{
                    VStack{
                        ScrollView(.horizontal,showsIndicators: false){
                            SegmentedPickerView1(store:store, titles:viewStore.coffeeCategoryList,font:.system(size: 15))
                        }.padding(.horizontal)
                        
                        ScrollView(.vertical){
                            VStack{
//                                Text("\(viewStore.coffeeCategoryList.count)")
                                LazyVGrid(columns: [GridItem(.flexible(minimum: 150, maximum: 200)), GridItem(.flexible(minimum: 150, maximum: 200))], spacing: 20) {
                                    ForEach(viewStore.filteredCoffeeList,id:\.id) { card in
                                        NavigationLink(
                                            state: HomeNavigationsFeature.HomePaths.State.coffeeDetail(CoffeeDetailsFeature.State(selectedCategoryIndex: 2, coffeeItem:card,updatedAmount:0.0, likedItems: [LikedItemsModel(likeId: "", coffeeId: "", userId: "")], isCoffeeLiked: false, currentLikedItemId: ""))
                                        ){
                                            Cards(card: card)
                                                
                                         }
                                        .foregroundColor(.black)
                                        
                                    }
                                }
                                .padding()
                            }
                        }
                        
                    }.background(Color("MildWhite"))
                }
            }
            .overlay(
                PromoCard()
                    .offset(x: 0, y: -110)
            )
            .onAppear{
                print("home view aapear")
                viewStore.send(.onHomeScreenAppear)
                viewStore.send(.fetchCoffees)
            }
            .onDisappear(){
                print("home view disappear")
//                viewStore.send(.toggleBottomBarVisibility)
                viewStore.send(.onHomeScreenDisappear)
            }
            .background(Color("MildWhite"))
            
        }
    }
}

#Preview {
    HomeView(store: Store(initialState: HomeFeature.State(cardsList: [CoffeeModel(title: "", description: "", image: "", id: "akndoka",subname: "",amount: 1.0,rating: 4.3,ratingCount: 120, category: "")])){
        HomeFeature()
       })
}



