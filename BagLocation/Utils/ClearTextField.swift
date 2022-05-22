//
//  ClearTextField.swift
//  BagLocation
//
//  Created by Jonathan Lee on 11/05/22.
//

import SwiftUI

struct TextClearField: ViewModifier
{
    @Binding var text: String
    @Environment(\.editMode) var isEdit
    
    public func body(content: Content) -> some View
    {
        HStack()
        {
            content
            Spacer()
            // isEdit?.wrappedValue == .active
            if !text.isEmpty
            {
                Button(action:
                        {
                    self.text = ""
                })
                {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}
