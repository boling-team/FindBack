//
//  view.swift
//  BagLocation
//
//  Created by Agus Budianto on 20/05/22.
//

import SwiftUI

struct CompartmentView: View{
   @State private var showingSheet = false
   @Binding var item: Compartment
    
    var body: some View {
        Section{
            Button(action : {
                showingSheet.toggle()
            })
            {
                HStack{
                    Image("empty")
                        .resizable()
                        .cornerRadius(5)
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading){
                        Text(item.name)
                            .font(Font.system(.headline, design: .serif))
                            .foregroundColor(.black)
                            .padding(.leading, 5.0)
                        Text("\(item.itemsCount) Items")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 5.0)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            .padding(.all, 3.0)
            .sheet(isPresented: $showingSheet) {
                BagCompartmentItemSheet()
            }
        }
    }
}

