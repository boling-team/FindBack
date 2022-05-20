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
    
    var body: some View {
        VStack{
            ImagePlaceholder()
            Button(action : {
                
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
    }
}






struct BagCompartmentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BagCompartmentDetailsView(photoActionButtonText: "Add Image")
    }
}




