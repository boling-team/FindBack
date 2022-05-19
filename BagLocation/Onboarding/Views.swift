//
//  Views.swift
//  BagLocation
//
//  Created by Agus Budianto on 18/05/22.
//

import SwiftUI


struct OnboardItemView: View {
    var model: OnboarModel
    var page: Int
    var body: some View {
        if page == model.page {
            VStack{
                Image(model.image)
                    .resizable()
                    .frame(width: .infinity, height: 300)
                
                Text(model.title)
                    .fontWeight(.bold)
                    .font(Font.system(.title, design: .serif))
                    .padding()
                
                Text(model.description)
                    .fontWeight(.bold)
                    .lineSpacing(10)
                    .font(Font.system(.headline, design: .serif))
                    .multilineTextAlignment(.center)
                    .padding(.trailing, 25)
                    .padding(.leading, 25)
                
            }
        }
    }
}



