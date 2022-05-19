//
//  AddItemSheetView.swift
//  BagLocation
//
//  Created by Agus Budianto on 12/05/22.
//

import SwiftUI

struct AddItemSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var model = Model(rows: (1...20).map({ Model.Row(textContent:"Row \($0)") }))
    
    
    var body: some View {
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
                    presentationMode.dismiss()
                }
            }.padding()
                .background(Color("AddItemSheetToolbar"))
            
            ElementList(model: $model)

            
        }
        
        
    }
}

struct AddItemSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemSheetView()
    }
}











