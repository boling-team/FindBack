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
                
                NavigationLink(destination: BagCompartmentItemView()) {
                    Text("add item to bag compartment")
                }
                
                Text("add item to bag compartment (sheet version)")
                    .onTapGesture {
                        isSheetPresented.toggle()
                    }
            }
        }.sheet(isPresented: $isSheetPresented){
            
            BagCompartmentItemSheet()
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}


