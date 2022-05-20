//
//  BagCompartmentDetailsView.swift
//  BagLocation
//
//  Created by Agus Budianto on 19/05/22.
//

import SwiftUI

struct BagCompartmentDetailsView: View {
    
    init(photoActionButtonText: String, tmpModel: Binding<TemporaryCompartment>){
        self.photoActionButtonText = photoActionButtonText
        self._tmpModel = tmpModel

        UITableView.appearance().contentInset.top = 0
        
        
    }
    var photoActionButtonText: String
    @Binding var tmpModel: TemporaryCompartment
    
    @State var showCaptureImageView: Bool = false
    
    var body: some View {
        ZStack{
        VStack{
            ImagePlaceholder(compartmentImage: tmpModel.compartmentImage ?? nil)
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
            ElementList(model: self.$tmpModel).safeAreaInset(edge: .bottom) {
                AddMoreItem(model: self.$tmpModel)
            }
        }
            if (showCaptureImageView) {
                CaptureImageView(isShown: $showCaptureImageView, image: $tmpModel.compartmentImage)
            }
        }
    }
}






//struct BagCompartmentDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        BagCompartmentDetailsView(photoActionButtonText: "Add Image")
//    }
//}




