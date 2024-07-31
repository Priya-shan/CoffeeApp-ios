//
//  PromoCard.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 17/10/23.
//

import SwiftUI

struct PromoCard: View {
    var body: some View {
        ZStack(alignment: .leading){
            Image("PromoImg")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 315,height: 145)
                .cornerRadius(16)
            
            VStack(alignment: .leading, spacing: 0){
                Text("Promo")
                    .padding(7)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .fontWeight(.bold)
                    .padding(.bottom,10)
                
                Text("Buy one get")
                    .font(.system(size: 35) )
                    .frame(width: 203)
                    .padding(.top, -16)
                    .padding(.bottom, 8)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.bottom,10)
                
                Text("one FREE")
                   
                    .font(.system(size: 35) )
                    .frame(width: 203)
                    .padding(.top, -16)
                    .padding(.bottom, 8)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    
            }.padding(.horizontal, 10)
            
        }
    }
}

#Preview {
    PromoCard()
}
