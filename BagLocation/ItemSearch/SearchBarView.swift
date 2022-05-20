//
//  SearchBarView.swift
//  BagLocation
//
//  Created by Agus Budianto on 11/05/22.
//

import SwiftUI
import SwiftUIX

struct SearchBar: View {
    @Binding var text: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var isEditing = true
 
    var body: some View {
        HStack {
 
            CocoaTextField("Search ...", text: $text)
                .isFirstResponder(true)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                 
                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
                .onChange(of: /*@START_MENU_TOKEN@*/"Value"/*@END_MENU_TOKEN@*/) { value in
                    self.text = value
                }
            
            if isEditing {
                Button(action: {
                    self.text = ""
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
            }
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
            SearchBar(text: .constant(""))
        }
}
