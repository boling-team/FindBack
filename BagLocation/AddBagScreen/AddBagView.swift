//
//  AddBagView.swift
//  BagLocation
//
//  Created by Malik A. Aziz Lubis on 18/05/22.
//

import SwiftUI

struct AddBagView: View {
//    init(){
//        UITabBar.appearance().backgroundColor = UIColor(Color("TabviewColor"))
//    }
    var body: some View {
        TabView{
            AddBag()
                .tabItem {
                    Button{
                        print("Pressed")
                    }
                    label: {
                        HStack{
                            Label("Add", systemImage: "plus")
                        }
                    }
                }
        }.background(.red)
    }
}

struct AddBagView_Previews: PreviewProvider {
    static var previews: some View {
        AddBagView()
    }
}
