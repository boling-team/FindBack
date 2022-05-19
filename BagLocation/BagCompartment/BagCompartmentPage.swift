//
//  BagCompartmentItemView.swift
//  BagLocation
//
//  Created by Agus Budianto on 19/05/22.
//

import SwiftUI

struct BagCompartmentItemView: View {
    var body: some View {
        BagCompartmentDetailsView(photoActionButtonText: "Add Image")
        .navigationBarTitle(Text("Detail View"), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: AddItemCompartmentCancelButton(), trailing:  SaveItemCompartmentButton())
        .ignoresSafeArea(.all, edges: .bottom)
        
        
    }
}

struct BagCompartmentItemView_Previews: PreviewProvider {
    static var previews: some View {
        BagCompartmentItemView()
    }
}


