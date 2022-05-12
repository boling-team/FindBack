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

struct ElementCell: View {
    @Binding var row: Model.Row
    var body: some View {
        TextField("Field",text: $row.textContent)
    }
}

struct ButtonElementCell: View {
    @Binding var row: Model.Row
    var body: some View {
        TextField("Field",text: $row.textContent)
    }
}

struct Model {
    struct Row : Identifiable {
        var textContent = ""
        let id = UUID()
    }
    var rows: [Row]
}

struct ElementList: View {
    @Binding var model: Model
    var body: some View {
        ScrollViewReader { scrollProxy in
            
            List {
                ForEach($model.rows) {
                    ElementCell(row:$0).swipeActions {
                        Button("Delete") {
                        }
                        .tint(.red)
                    }
                }
                
                Button("Add More Item") {
                    let lastIdx = model.rows.count
                    model.rows.append(Model.Row())
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                        scrollProxy.scrollTo(model.rows[lastIdx].id)
                  }
                }.foregroundColor(.blue)
                    .padding(.bottom, 50)
                    .listRowSeparator(.hidden)
            }.listStyle(.plain)
                
        }
        
    }
}





