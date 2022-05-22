//
//  view.swift
//  BagLocation
//
//  Created by Agus Budianto on 20/05/22.
//

import SwiftUI

struct CompartmentView: View{
    // MARK: BINDING
    @Binding var compartment: TemporaryCompartment
    
    @State private var showingSheet = false
    var body: some View {
        Section{
            Button(action : {
                showingSheet.toggle()
            })
            {
                HStack{
                    Image(uiImage: compartment.compartmentImage ?? UIImage())
                        .resizable()
                        .cornerRadius(5)
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading){
                        TextField("Enter Compartment Name", text: $compartment.compartmentName)
                            .font(Font.system(.headline, design: .serif))
                            .foregroundColor(.black)
                            .padding(.leading, 5.0)
                        Text("\(compartment.items.count) Items")
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
                BagCompartmentItemSheet(bagCompartment: $compartment, tmpCompartment: compartment)
            }
        }
    }
}


