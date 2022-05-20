//
//  CardView.swift
//  BagLocation
//
//  Created by Jonathan Lee on 11/05/22.
//

import SwiftUI

struct CardView: View {
    var bag: BagsEntity
    
    var body: some View {
        NavigationLink {
            
        } label: {
            HStack {
                Image("EmptyBag")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipped()
                    .padding(10)
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

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            CardView()
//        }
////            .preferredColorScheme(.dark)
//    }
//}
