//
//  ItemSearchView.swift
//  BagLocation
//
//  Created by Agus Budianto on 11/05/22.
//

import SwiftUI

struct ItemSearchView: View {
    @State var q: String = ""
    
    var body: some View {
        VStack(alignment: .center){
            SearchBar(text: $q)
            
            Spacer()
        }
    }
}

struct ItemSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ItemSearchView()
    }
}


