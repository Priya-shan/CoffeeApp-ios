//
//  ContentView.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 17/10/23.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        ZStack{
            
            Color(.black)
            VStack{
                Image("splashImg")
                    .resizable()
                    .frame(height: 600)
                    .padding(.top,0)
                    .ignoresSafeArea()
                Spacer()
                
            }
            VStack{
                Spacer()
                Text("Coffee so good,your taste buds will love it.")
                .font(.system(size: 40))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                Text("The best grain, the finest roast, the powerful flavor")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(5)
                
                Button("Get Started"){
                    
                }
                .padding(EdgeInsets(top: 15,leading: 109,bottom: 15,trailing: 109))
                .background(Color("primaryColor"))
                .cornerRadius(16)
                .foregroundColor(.white)
                .frame(width: 315,height: 62)
             
                
            }
            .padding()
            
           
        }
        .frame(width: .infinity,height: .infinity)
        .ignoresSafeArea()
    }
}

#Preview {
    LandingView()
}
