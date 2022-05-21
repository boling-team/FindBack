//
//  list.swift
//  BagLocation
//
//  Created by Agus Budianto on 19/05/22.
//

import SwiftUI




struct ElementCell: View {
    @Binding var row: TemporaryItem
    var body: some View {
        VStack(alignment: .leading){
            Spacer()
            TextField("type item name...", text: $row.itemName).padding(.leading)
            Spacer()
            Divider()
        }.listRowSeparator(.hidden)
        .listRowInsets(.init())
    }
}


struct ElementList: View {
    @Binding var model: TemporaryCompartment
    var body: some View {
        List {
            ForEach($model.items, id: \.itemID) {
                item in
                ElementCell(row:item)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init())
                    .swipeActions {
                        Button(action: {
                            model.items = model.items.filter{
                                $0.itemID != item.itemID.wrappedValue
                            }
                        }) {
                            Text("Delete").foregroundColor(.red).background(.black)
                        }.tint(.red)
                        
                    }
            }
        }.listStyle(PlainListStyle())
    }
}
