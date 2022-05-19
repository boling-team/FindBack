//
//  AddBag.swift
//  BagLocation
//
//  Created by Malik A. Aziz Lubis on 11/05/22.
//

import SwiftUI

struct Bag{
    var bagName: String = ""
    //    var image: String = ""
    var imageReady: Bool = false
    var pocket: String = ""
}

struct isiPocket{
    var items:Int
}

struct AddBag: View {
    @State var image: Image? = nil
    @State var showCaptureImageView: Bool = false
    @State var bag: Bag = Bag()
    @State private var showingSheet = false
    
    init() {
//        UIToolbar.appearance().barTintColor = UIColor(Color("TabViewColor"))
//        UITableView.appearance().backgroundColor = .clear
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
//                                            self.showCaptureImageView.toggle()
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
                                        .sheet(isPresented: $showingSheet) {
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
                                    
                                    
                                    //                                    if (image==nil){
                                    //
                                    //                                    }else{
                                    //                                        Button(action: {
                                    //                                            self.showCaptureImageView.toggle()
                                    //                                        }) {
                                    //                                            Text("Change photo")
                                    //                                        }
                                    //                                    }
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
                        
                        ForEach((1...9).reversed(), id: \.self) { i in
                            CompartmentView()
                            
                        }
                        
                        
                        .listRowBackground(Color("IjoMuda"))
                        
                        
                    }
                    .listStyle(.insetGrouped)
                    //                    .safeAreaInset(edge: .bottom) {
                    //
                    //                        HStack{
                    //                            Spacer()
                    //                            Button(action : {
                    //                                print("Pressed")
                    //                            })
                    //                            {
                    //                                Label("Add Compartment", systemImage: "plus.circle.fill")
                    //                                    .font(Font.custom("Serif",size: 22))
                    //                                    .padding()
                    //                                    .foregroundColor(Color("IjoTua"))
                    //                            }
                    //                            .padding()
                    //
                    //
                    //                            Spacer()
                    //                        }
                    //                        .padding(.leading)
                    //                        .background(Color("TabViewColor"))
                    //                        .frame(height: 70)
                    //
                    //                    }.ignoresSafeArea(.all, edges: .bottom)
                }
            .navigationTitle("Add Bag")
//                .foregroundColor(Color(red: 0.1, green: 0.5, blue: 0.9))
                .navigationBarTitleDisplayMode(.inline)
//                .navigationBarItems(
//                    leading:
//                       ,
//                    trailing:
//
//                )
//                .background(.white)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action:{
                            print("Button Cancel Pressed")
                        }){
                            //                            Image(systemName: "chevron.backward")
                            //                                .foregroundColor(Color("IjoTua"))
                            //                                .renderingMode(.original)
                            //                                .font(.system(size: 20))
                            Text("Cancel")
                                .foregroundColor(Color("IjoTua"))
                                .bold()
                            
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action:{
                            print("Button Save Pressed")
                        }){
                            Text("Save")
                                .foregroundColor(Color("IjoTua"))
                                .bold()
                        }
                    }
                    
                    ToolbarItemGroup(placement: .bottomBar) {
                        
                        HStack {
                            Button(action : {
                                print("Pressed")
                            })
                            {
                                Label("Add Compartment", systemImage:"plus.circle.fill")
                                    .font(.system(size: 23))
                                    .foregroundColor(Color("IjoTua"))
                                
                                Text("Add Compartment")
                                    .foregroundColor(Color("IjoTua"))
                                    .bold()
                                    .font(.system(size: 22))
                            }
                        }
                        Spacer()
                    }
                }
        }
    }
}

struct CompartmentView: View{
    @State private var showingSheet = false
    var body: some View {
        Section{
            Button(action : {
                showingSheet.toggle()
            })
            {
                HStack{
                    Image("empty")
                        .resizable()
                        .cornerRadius(5)
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading){
                        Text("Main Pocket")
                            .font(Font.system(.headline, design: .serif))
                            .foregroundColor(.black)
                            .padding(.leading, 5.0)
                        Text("15 Items")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 5.0)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            .padding(.all, 3.0)
            .sheet(isPresented: $showingSheet) {
                AddPocket()
            }
        }
    }
}

struct AddBag_Previews: PreviewProvider {
    static var previews: some View {
        AddBag()
    }
}
