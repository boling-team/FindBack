//
//  list.swift
//  BagLocation
//
//  Created by Agus Budianto on 19/05/22.
//

import SwiftUI

struct Model {
    struct Row : Identifiable {
        var textContent = ""
        let id = UUID()
    }
    var rows: [Row]
}


struct ElementCell: View {
    @Binding var row: Model.Row
    var body: some View {
        VStack(alignment: .leading){
            Spacer()
            Text(row.textContent).padding(.leading)
            Spacer()
            Divider()
        }.listRowSeparator(.hidden)
        .listRowInsets(.init())
           
    }
}


struct ElementList: View {
    @Binding var model: Model
    var body: some View {
            List {
                ForEach($model.rows) {
                    item in
                    ElementCell(row:item)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init())
                        .swipeActions {
                            Button(action: {
                                model.rows = model.rows.filter{
                                    $0.id != item.id
                                }
                            }) {
                                Text("Delete").foregroundColor(.red).background(.black)
                            }.tint(.red)
                            
                        }
                }
            }.listStyle(PlainListStyle())
    }
}
