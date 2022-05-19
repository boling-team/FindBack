//
//  SwiftUIView.swift
//  BagLocation
//
//  Created by Agus Budianto on 19/05/22.
//

import SwiftUI



struct AddMoreItem: View {
    @Binding var model: Model

    var body: some View {
        HStack{
            Button(action : {
                model.rows.append(Model.Row(textContent: "new items"))
            })
            {
                Label("Add More Item", systemImage: "plus.circle")
                    .padding()
                    .foregroundColor(.white)
            }
            Spacer()
        }.background(.red)
            .frame(height: 82)
    }
}


struct ImagePlaceholder: View {
    var compartmentImage: UIImage?

    var body: some View {
        ZStack(alignment: .center){
            if (compartmentImage != nil) {
                Image(uiImage: compartmentImage!)
                    .resizable()
                    .scaledToFit()
                    .background(Rectangle().strokeBorder())
            } else{
                Rectangle()
                    .fill(.red)
                    .cornerRadius(12)
                
                Image(systemName: "photo")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 60, height: 41)
            }
        }
        .frame(width: 338, height: 213)
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
