//
//  BagScreen.swift
//  BagLocation
//
//  Created by Malik A. Aziz Lubis on 20/05/22.
//

import SwiftUI

struct BagScreen: View {
    @State var image: Image? = nil
    @State var showCaptureImageView: Bool = false
    @State var bag: Bag = Bag()
    @State private var showingSheet = false
    @Environment(\.dismiss) var dismiss
    
    init() {
        UITableView.appearance().sectionHeaderHeight = 3
        UITableView.appearance().sectionFooterHeight = 3
        
    }
    
    var body: some View {
        NavigationView{
                VStack {
                    List{
                       
                        Section(header:  Text("Bag Detail")
                            .font(Font.system(.title2, design: .serif))
                            .foregroundColor(.black)
                            .bold()
                            .padding(.leading, -12.0)){
                            
                                HStack{
                                    if (image==nil){
                                        Button(action: {
                                            showingSheet.toggle()
                                        }, label: {
                                            ZStack{
                                                Rectangle()
                                                    .fill(Color("IjoTua"))
                                                    .cornerRadius(5)
                                                    .frame(width: 100, height: 100)
                                                
                                                Image(systemName: "camera")
                                                    .renderingMode(.original)
                                                    .font(Font.custom("Serif",size: 30))
                                                    .foregroundColor(.white)
                                                
                                            }
                                            
                                        })
                                        .fullScreenCover(isPresented: $showingSheet) {
                                            AddBagImage()
                                        }
                                        
                                    }else{
                                        ZStack {
                                            image?.resizable()
                                                .clipped()
                                                .frame(width: 100, height: 100)
                                                .cornerRadius(5)
                                                .padding(.all, 0.0)
                                        }
                                    }
                                    VStack(alignment: .leading){
                                        Text("Bag Name")
                                            .font(Font.system(.headline, design: .serif))
                                            .foregroundColor(.black)
                                        TextField("E. g. Green Bag", text: $bag.bagName)
                                            .foregroundColor(.black)
                                    }.textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(.leading, 5.0)
                                }
                                .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        }
                            .listRowBackground(Color("IjoMuda"))
                            .textCase(nil)
                        
                        Section(header: Text("Compartment List")
                                .font(Font.system(.title2, design: .serif))
                                .foregroundColor(.black)
                                .bold()
                                .padding(.leading, -12.0)){
                                }
                                .padding(.top, 5.0)
                                
                        
                        ForEach((1...9).reversed(), id: \.self) { i in
                            CompartmentView()
                        }.listRowBackground(Color("IjoMuda"))
                    }.listStyle(.insetGrouped)
                }
            .navigationTitle("Bag")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action:{
                            print("Button Cancel Pressed")
                            dismiss()
                        }){
                            //                            Image(systemName: "chevron.backward")
                            //                                .foregroundColor(Color("IjoTua"))
                            //                                .renderingMode(.original)
                            //                                .font(.system(size: 20))
                            Text("Back")
                                .foregroundColor(Color("IjoTua"))
                                .bold()
                            
                        }
                    }
                    
                }
        }
    }
}



struct BagScreen_Previews: PreviewProvider {
    static var previews: some View {
        BagScreen()
    }
}
