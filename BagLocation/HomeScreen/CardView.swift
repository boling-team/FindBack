//
//  CardView.swift
//  BagLocation
//
//  Created by Jonathan Lee on 11/05/22.
//

import SwiftUI
import UIKit

struct CardView: View {
//    @State var bagDetailSheet: Bool = false
    
    var bag: BagsEntity
    
    var body: some View {
        NavigationLink {
            BagScreen(bag: bag)
        } label: {
            HStack {
                Image(uiImage: bag.wrappedBagImage)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipped()
//                    .padding(10)
                    .cornerRadius(8)
                    .border(.gray, width: 1)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(bag.wrappedBagName)
                        .lineLimit(1)
                    Text("\(bag.compartmentList.count) Compartments")
                        .lineLimit(1)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)

    }
}
