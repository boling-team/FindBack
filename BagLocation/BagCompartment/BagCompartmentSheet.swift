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
    @Binding var bagCompartment: TemporaryCompartment
    @State var tmpCompartment: TemporaryCompartment
    
    var body: some View {
        ZStack{
            if (showCaptureImageView) {
                CaptureImageView(isShown: $showCaptureImageView, image: $tmpCompartment.compartmentImage)
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
                        bagCompartment.items = tmpCompartment.items
                        bagCompartment.compartmentImage = tmpCompartment.compartmentImage
                        bagCompartment.compartmentName = tmpCompartment.compartmentName
                        presentationMode.dismiss()
                    }
                }.padding()
                
                BagCompartmentDetailsView(photoActionButtonText: tmpCompartment.compartmentImage == nil ? "Add Image" : "Change Image", tmpModel: $tmpCompartment)
                    .ignoresSafeArea(.all, edges: .bottom)
                
            }
        }
    }
}
//
//struct BagCompartmentItemSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        BagCompartmentItemSheet()
//    }
//}
