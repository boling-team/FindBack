//
//  CardView.swift
//  BagLocation
//
//  Created by Jonathan Lee on 11/05/22.
//

import SwiftUI
import UIKit

struct CardView: View {
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
                    .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(bag.wrappedBagName)
                        .lineLimit(1)
                        .font(Font.system(.headline, design: .serif))
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
