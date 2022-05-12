//
//  HomePageView.swift
//  BagLocation
//
//  Created by Agus Budianto on 12/05/22.
//

import SwiftUI

struct HomePageView: View {
    @State var isSheetPresented = false
    var body: some View {
        NavigationView{
            List{
                NavigationLink(destination: ItemSearchView()) {
                    Text("Hello, World!")
                }
                
                Text("add item to tags")
                    .onTapGesture {
                        isSheetPresented.toggle()
                    }
            }
        }.sheet(isPresented: $isSheetPresented){
            
            AddItemSheetView()
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}


