//
//  CoffeeOrdersView.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 01/11/23.
//

import SwiftUI
import ComposableArchitecture

struct CoffeeOrdersView: View {
    let store : StoreOf<CoffeeOrderFeature>
    var body: some View {
        WithViewStore(self.store, observe: {$0}){ viewStore in
            VStack{
                Spacer()
                SegmentPickerView3(store: store, titles: ["Deliver","Pick Up"], font: .system(size: 15))
                Spacer()
                VStack(alignment:.leading,spacing: 10){
                    Text("Delivery Address").font(.title3).bold()
                    Text("Jl. Kpg Sutoyo").bold()
                    Text("Kpg. Sutoyo No. 620, Bilzen, Tanjungbalai.")
                        .foregroundStyle(.gray)
                    HStack{
                        Button{
                            
                        }label: {
                            HStack{
                                Image(systemName: "square.and.pencil.circle")
                                Text("Edit Address")
                            }
                        }
                        .foregroundColor(.black)
                        .font(.caption)
                        .padding(7)
                        .background(RoundedRectangle(cornerRadius: 20).stroke(.gray))
                        Button(){
                            
                        }label: {
                            HStack{
                                Image(systemName: "list.clipboard")
                                Text("Add Note")
                            }
                        }
                        .foregroundColor(.black)
                        .font(.caption)
                        .padding(5)
                        .background(RoundedRectangle(cornerRadius: 20).stroke(.gray))
                        
                    }
                }
                Divider().padding(.vertical,5)
                VStack{
                    HStack{
                        AsyncImageView(store: Store(initialState: AsyncImageFeature.State(imageUrl:"\(viewStore.coffeeItem.image)"), reducer: {
                            AsyncImageFeature()
                        }))
                        .cornerRadius(20)
                        .frame(width:90,height: 80)
                        Spacer()
                        VStack(alignment: .leading){
                            Text("Cappucinno").bold()
                            Text("With Chocolate")
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                        Image(systemName: "minus.circle")
                            .font(.system(size: 25))
                            .foregroundColor(.gray)
                            .onTapGesture {
                                viewStore.send(.setQuantity(viewStore.quantity - 1))
                            }
                        Text("\(viewStore.quantity)")
                        Image(systemName: "plus.circle")
                            .font(.system(size: 25))
                            .foregroundColor(.gray)
                            .onTapGesture {
                                viewStore.send(.setQuantity(viewStore.quantity + 1))
                            }
                        
                    }
                }
                Divider().padding(.vertical,5)
                Button{
                    
                }label: {
                    HStack{
                        Image("icon-discount").resizable().frame(width: 30,height: 30)
                        Text("1 Discount is applied")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.black)
                    .bold()
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).stroke(.gray))
                }
                Spacer()
                VStack(alignment: .leading,spacing: 10){
                    Text("Payment Summary")
                        .font(.title3).bold()
                    HStack{
                        Text("Price")
                        Spacer()
                        Text("$ \(String(format: "%.2f", viewStore.finalAmount))")
                    }
                    if(viewStore.selectedCategoryIndex != 1){
                        HStack{
                            Text("Delivery Fee")
                            Spacer()
                            Text("$ 2.00")
                        }
                    }
                    Divider().padding(.vertical,10)
                    HStack{
                        Text("Total Payment")
                        Spacer()
                        Text("$ \(String(format: "%.2f", viewStore.finalAmount + viewStore.deliveryFee))")
                    }
                }
                Spacer()
                VStack{
                    HStack{
                        Image("icon-money")
                            .resizable()
                            .frame(width: 30,height: 30)
                        HStack{
                            Text("Cash")
                                .font(.caption)
                                .bold()
                                .padding(6)
                                .padding(.horizontal,15)
                                .background(Color("primaryColor"))
                                .cornerRadius(20)
                                .foregroundColor(.white)
                            
                            Text("$5.53")
                                .font(.caption)
                                .padding(6)
                                .padding(.horizontal,15)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(20)
                                .offset(x: -20)
                        }
                        //                    Picker(selection: , label: Text("Picker")) {
                        //                        Text("Cash").tag(1)
                        //                        Text("$5.53").tag(2)}
                        //                    .pickerStyle(.segmented)
                        //                    .frame(width: 150)
                        //                    .background(Color("primaryColor"))
                        //                    .tint(Color("primaryColor"))
                        //                    .accentColor(.blue)
                        //                    .cornerRadius(20)
                        Spacer()
                        Image("icon-more")
                            .resizable()
                            .frame(width: 30,height: 30)
                    }
                }
                Spacer()
                NavigationLink(state: HomeNavigationsFeature.HomePaths.State.deliveryMap(DeliveryMapFeature.State())){
                    Button("Order") {}
                        .font(.title3).bold()
                        .frame(width: 280, height: 15)
                        .padding(20)
                        .background(Color("primaryColor"))
                        .cornerRadius(20)
                        .foregroundColor(.white)
                }
                .navigationTitle("Order")
                
            }.padding(.horizontal,30)
        }
        
    }
}

#Preview {
    CoffeeOrdersView(store: Store(initialState: CoffeeOrderFeature.State(selectedCategoryIndex: 0, coffeeItem: CoffeeModel(title: "", description: "", image: "https://upload.wikimedia.org/wikipedia/commons/1/16/Caf%C3%A9Cortado%28Tallat%29.jpg", id: "", subname: "", amount: 3.0, rating: 4.3, ratingCount: 230, category: ""), quantity: 1, finalAmount: 4.3, deliveryFee: 2.00), reducer: {
        CoffeeOrderFeature()
    }))
}
