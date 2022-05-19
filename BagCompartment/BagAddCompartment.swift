//
//  AddCompartment.swift
//  BagLocation
//
//  Created by Agus Budianto on 19/05/22.
//

import SwiftUI

struct BagAddCompartment: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Label("Cancel", systemImage: "chevron.backward")
                    .foregroundColor(.blue)
                    .onTapGesture {
                        presentationMode.dismiss()
                    }
                
                Spacer()
                Text("Saku Kiri")
                Spacer()
                Button("Save"){
                    presentationMode.dismiss()
                }
            }.padding()
                .background(Color("AddItemSheetToolbar"))
            
            BagCompartmentDetailsView(photoActionButtonText: "Change Image")
                .ignoresSafeArea(.all, edges: .bottom)
            
        }
    }}

struct AddCompartment_Previews: PreviewProvider {
    static var previews: some View {
        BagAddCompartment()
    }
}