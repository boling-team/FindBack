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
        NavigationView {
            ZStack{
                BagCompartmentDetailsView(
                    photoActionButtonText: tmpCompartment.compartmentImage == nil ? "Add Image" : "Change Image",
                    tmpModel: $tmpCompartment,
                    showCaptureImageView: $showCaptureImageView
                )
                .ignoresSafeArea(.all, edges: .bottom)
            }
            .navigationTitle(bagCompartment.compartmentName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.dismiss()
                    }
                    .foregroundColor(Color("IjoTua"))
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save"){
                        bagCompartment.items = tmpCompartment.items
                        bagCompartment.compartmentImage = tmpCompartment.compartmentImage
                        bagCompartment.compartmentName = tmpCompartment.compartmentName
                        presentationMode.dismiss()
                    }
                    .foregroundColor(Color("IjoTua"))
                }
            }
            .fullScreenCover(isPresented: $showCaptureImageView) {
                CaptureImageView(isShown: $showCaptureImageView, image: $tmpCompartment.compartmentImage)
                    .ignoresSafeArea(.all, edges: .all)
            }
        }
    }
}
