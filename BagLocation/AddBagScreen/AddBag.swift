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
                                Button {
                                    showingSheet.toggle()
                                } label: {
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
                                    } else {
                                        Image(uiImage: bag.bagImage!)
                                            .resizable()
                                            .clipped()
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(5)
                                            .padding(.all, 0.0)
                                    }
                                }
                                .fullScreenCover(isPresented: $showingSheet) {
                                    AddBagImage(image: $bag.bagImage)
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
                    
                   Section(header:  Text("Compartment List")
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
                            .bold()
                        
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
                            .bold()
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
    // MARK: BINDING
    @Binding var compartment: TemporaryCompartment
    
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
                        TextField("Enter Compartment Name", text: $compartment.compartmentName)
                            .font(Font.system(.headline, design: .serif))
                            .foregroundColor(.black)
                            .padding(.leading, 5.0)
                        Text("\(compartment.items.count) Items")
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


struct TemporaryCompartment: Equatable {
    var compartmentID: UUID = UUID()
    var compartmentName: String = ""
    var compartmentImage: UIImage = UIImage(systemName: "camera")!
    
    var items: [TemporaryItem] = []
}

struct TemporaryItem: Equatable {
    var itemID: UUID = UUID()
    var itemName: String = ""
}

struct TemporaryBag: Equatable {
    var bagID: UUID = UUID()
    var bagName: String
    var bagImage: UIImage? = UIImage(systemName: "camera") ?? UIImage()
    
    var compartments: [TemporaryCompartment] = [TemporaryCompartment()]
}
