//
//  BagCompartmentItemView.swift
//  BagLocation
//
//  Created by Agus Budianto on 18/05/22.
//

import SwiftUI

struct BagCompartmentItemView: View {
    var body: some View {
        VStack{
            HStack{
                Rectangle()
                    .fill(.red)
                    .frame(width: .infinity, height: 384)
                    
    
            }.padding(.leading, 25)
            .padding(.trailing, 25)
            
            Spacer()
        }
        .navigationBarTitle(Text("Detail View"), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: AddItemCompartmentCancelButton(), trailing:  SaveItemCompartmentButton())
    }
}

struct BagCompartmentItemView_Previews: PreviewProvider {
    static var previews: some View {
        BagCompartmentItemView()
    }
}

struct AddItemCompartmentCancelButton: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Cancel").foregroundColor(.red)
        }
    }
}

struct SaveItemCompartmentButton: View {
    var body: some View {
        Button(action: {
        }) {
            Text("Save").foregroundColor(.red)
        }
    }
}
