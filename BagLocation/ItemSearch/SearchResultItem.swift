//
//  SearchResultItem.swift
//  BagLocation
//
//  Created by Agus Budianto on 19/05/22.
//

import SwiftUI

struct SearchResultItem: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//struct SearchResultItem_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultItemCard()
//    }
//}

struct ResultItemCard: View {
    var resultItem: SearchResult
    
    var body: some View {
        HStack {
            Image(uiImage: resultItem.bag.wrappedBagImage)
                .resizable()
                .scaledToFit()
                .cornerRadius(6)
                .frame(width: 120, height: 120)
                .padding()
            VStack(alignment: .trailing){
                Text(resultItem.item.itemName!).frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                    .font(.system(size: 18, design: .serif))
                Text(resultItem.compartment.compartmentName!).frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)
                    .opacity(0.7)
                   
                Spacer()
                Text(resultItem.bag.wrappedBagName)
                    .padding(.bottom, 30)
                    .font(.body)
                    .opacity(0.7)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }.frame(width: 390, height: 140)
    }
}
