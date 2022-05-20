//
//  BagCompartmentDetailsView.swift
//  BagLocation
//
//  Created by Agus Budianto on 19/05/22.
//

import SwiftUI

struct BagCompartmentDetailsView: View {
    
    init(photoActionButtonText: String){
        self.photoActionButtonText = photoActionButtonText
        UITableView.appearance().contentInset.top = 0
        
        
    }
    var photoActionButtonText: String
    @State var model = Model(rows: (1...5).map({ Model.Row(textContent:"Row \($0)") }))
    @State var showCaptureImageView: Bool = false
    @State var image: Image? = nil
    
    var body: some View {
        ZStack{
        VStack{
            ImagePlaceholder(compartmentImage: image)
            Button(action : {
                showCaptureImageView.toggle()
            }){
                HStack{
                    Text(photoActionButtonText)
                    Spacer()
                }
                
            }.padding(.leading, 25)
            Divider()
            HStack{
                Text("Compartment Items")
                    .font(.system(size: 22, design: .serif).bold())
                    .padding()
                Spacer()
            }
            Divider()
            ElementList(model: self.$model).safeAreaInset(edge: .bottom) {
                AddMoreItem(model: self.$model)
            }
        }
            if (showCaptureImageView) {
              CaptureImageView(isShown: $showCaptureImageView, image: $image)
            }
        }
    }
}






struct BagCompartmentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BagCompartmentDetailsView(photoActionButtonText: "Add Image")
    }
}




