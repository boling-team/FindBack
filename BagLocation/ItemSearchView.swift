//
//  ItemSearchView.swift
//  BagLocation
//
//  Created by Agus Budianto on 11/05/22.
//

import SwiftUI

struct ItemSearchView: View {
    @State var q: String = ""
    var items = ["aku", "test", "memanjat", "akun"]
    var body: some View {
        VStack(alignment: .center){
            SearchBar(text: $q)
            List{
                ForEach(items.filter{
                    if q.count < 3 {
                        return false
                    }
                    
                    return $0.lowercased()
                        .contains(q.lowercased())
                }, id: \.self){ item in
                    Text(item)
                }
            }
            Spacer()
        }.navigationBarHidden(true)
    }
}

struct ItemSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ItemSearchView()
    }
}


