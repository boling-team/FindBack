//
//  AddBag.swift
//  BagLocation
//
//  Created by Malik A. Aziz Lubis on 11/05/22.
//

import SwiftUI

struct AddBag: View {
    // MARK: ENVIRONMENT
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    // MARK: STATE
    @State var image: UIImage? = nil
    @State var showCaptureImageView: Bool = false
    @State private var showingSheet = false
    
    @State var bag: TemporaryBag = TemporaryBag(bagName: "")
    
    init() {
        UITableView.appearance().sectionHeaderHeight = 3
        UITableView.appearance().sectionFooterHeight = 3
    }
    
    var body: some View {
        NavigationView{
            VStack {
                List{
                    Section(header: Text("Bag Detail")
                        .font(Font.system(.title2, design: .serif))
                        .foregroundColor(.black)
                        .bold()
                        .padding(.leading, -12.0)){
                            
                            HStack{
//                                Button {
//                                    showingSheet.toggle()
//                                } label: {
                                    if(bag.bagImage == nil) {
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
                                        .onTapGesture {
                                            showingSheet.toggle()
                                        }
                                    } else {
                                        Image(uiImage: bag.bagImage!)
                                            .resizable()
                                            .clipped()
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(5)
                                            .padding(.all, 0.0)
                                            .onTapGesture {
                                                showingSheet.toggle()
                                            }
                                    }
//                                }
                                
                                VStack(alignment: .leading){
                                    Text("Bag Name")
                                        .font(Font.system(.headline, design: .serif))
                                        .foregroundColor(.black)
                                    TextField("E. g. Green Bag", text: $bag.bagName)
                                        .foregroundColor(.black)
//                                        .modifier(TextClearField(text: $bag.bagName))
                                }.textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.leading, 5.0)
                            }
                            .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .fullScreenCover(isPresented: $showingSheet) {
                                AddBagImage(image: $bag.bagImage)
                            }
                        }
                        .listRowBackground(Color("IjoMuda"))
                        .textCase(nil)
                    
                    Section(header: Text("Compartment List")
                        .font(Font.system(.title2, design: .serif))
                        .foregroundColor(.black)
                        .bold()
                        .padding(.leading, -12.0)) {

                        }
                        .textCase(nil)
                    
                    ForEach($bag.compartments, id: \.compartmentID) {
                        $compartment in
                        CompartmentView(compartment: $compartment)
                    }
                    .listRowBackground(Color("IjoMuda"))
                    
                }.listStyle(.insetGrouped)
                
            }
            .navigationTitle("Add Bag")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action:{
                        print("Button Cancel Pressed")
                        dismiss()
                    }){
                        Text("Cancel")
                            .foregroundColor(Color("IjoTua"))
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action:{
                        print("Button Save Pressed")
                        guard self.bag.bagName != "" else {return}
                        guard !self.bag.compartments.last!.compartmentName.isEmpty else {return}
                        
                        let newBag = BagsEntity(context: viewContext)
                        newBag.bagID = bag.bagID
                        newBag.bagName = bag.bagName
                        newBag.bagImage = bag.bagImage?.jpegData(compressionQuality: 1.0)
                        
                        for compartment in bag.compartments {
                            let newCompartment = CompartmentsEntity(context: viewContext)
                            newCompartment.compartmentName = compartment.compartmentName
                            newCompartment.compartmentID = compartment.compartmentID
                            newCompartment.bag = newBag
                            // TODO: UBAH FOTO JADI BINARY
                            newCompartment.compartmentImage = compartment.compartmentImage?.jpegData(compressionQuality: 1.0)

                            for item in compartment.items {
                                let newItem = ItemsEntity(context: viewContext)
                                newItem.itemName = item.itemName
                                newItem.itemID = item.itemID
                                newItem.compartment = newCompartment
                            }
                        }
                        
                        do {
                            try viewContext.save()
                            
                            dismiss()
                        } catch let error {
                            print(error.localizedDescription)
                        }
                        
                    }){
                        Text("Save")
                            .foregroundColor(Color("IjoTua"))
                    }
                }
                
                ToolbarItemGroup(placement: .bottomBar) {
                    HStack {
                        Button(action : {
                            print("Pressed")
                            
                            bag.compartments.append(TemporaryCompartment())
                        })
                        {
                            Label("Add Compartment", systemImage:"plus.circle.fill")
//                                .font(.system(size: 23))
                                .foregroundColor(Color("IjoTua"))
                            
                            Text("Add Compartment")
                                .foregroundColor(Color("IjoTua"))
                                .bold()
//                                .font(.system(size: 22))
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}


struct AddBag_Previews: PreviewProvider {
    static var previews: some View {
        AddBag()
    }
}

struct TemporaryCompartment: Equatable {
    var compartmentID: UUID = UUID()
    var compartmentName: String = ""
    var compartmentImage: UIImage? = nil
    
    var items: [TemporaryItem] = []
}

struct TemporaryItem: Equatable {
    var itemID: UUID = UUID()
    var itemName: String = ""
}

struct TemporaryBag: Equatable {
    var bagID: UUID = UUID()
    var bagName: String
    var bagImage: UIImage? = nil
    
    var compartments: [TemporaryCompartment] = [TemporaryCompartment()]
}
