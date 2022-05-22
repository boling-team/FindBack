//
//  BagCompartmentItemView.swift
//  BagLocation
//
//  Created by Agus Budianto on 19/05/22.
//

import SwiftUI

struct BagCompartmentItemView: View {
    @State var showCaptureImageView: Bool = false
    @State var image: UIImage? = nil
    
    var body: some View {
        ZStack{
//            if (showCaptureImageView) {
//              CaptureImageView(isShown: $showCaptureImageView, image: $image)
//            }
//            
//        BagCompartmentDetailsView(photoActionButtonText: "Add Image")
//        .navigationBarTitle(Text("Detail View"), displayMode: .inline)
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: AddItemCompartmentCancelButton(), trailing:  SaveItemCompartmentButton(showCaptureImageView: $showCaptureImageView))
//        .ignoresSafeArea(.all, edges: .bottom)
        }
        
    }
}

struct BagCompartmentItemView_Previews: PreviewProvider {
    static var previews: some View {
        BagCompartmentItemView()
    }
}


