//
//  BagCompartmentItemSheet.swift
//  BagLocation
//
//  Created by Agus Budianto on 19/05/22.
//

import SwiftUI

struct BagCompartmentItemSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @State var showCaptureImageView: Bool = false
    @State var image: Image? = nil
    
    var body: some View {
        ZStack{
            if (showCaptureImageView) {
                CaptureImageView(isShown: $showCaptureImageView, image: $image)
            }
            
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
                        showCaptureImageView.toggle()
                    }
                }.padding()
                
                BagCompartmentDetailsView(photoActionButtonText: image == nil ? "Add Image" : "Change Image")
                    .ignoresSafeArea(.all, edges: .bottom)
                
            }
        }
    }
}

struct BagCompartmentItemSheet_Previews: PreviewProvider {
    static var previews: some View {
        BagCompartmentItemSheet()
    }
}
