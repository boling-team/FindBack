//
//  SwiftUIView.swift
//  BagLocation
//
//  Created by Agus Budianto on 19/05/22.
//

import SwiftUI



struct AddMoreItem: View {
    @Binding var model: TemporaryCompartment

    var body: some View {
        HStack{
            Button(action : {
                if(model.items.last?.itemName != "") {
                    model.items.append(TemporaryItem())
                }
            })
            {
                Label("Add More Item", systemImage: "plus.circle")
                    .padding()
                    .foregroundColor(.white)
            }
            Spacer()
        }.background(Color("IjoTua"))
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
                    .fill(Color("IjoTua"))
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
    @Binding var showCaptureImageView: Bool
    var body: some View {
        Button(action: {
            showCaptureImageView.toggle()
        }) {
            Text("Save").foregroundColor(.red)
        }
    }
}
