//
//  ReadBagCompartment.swift
//  BagLocation
//
//  Created by Agus Budianto on 21/05/22.
//

import SwiftUI

struct ReadBagCompartment: View {
    // MARK: ENVIRONMENT
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    
    // MARK: BINDING
    @ObservedObject var compartment: CompartmentsEntity
    @State var itemList: [ItemsEntity]
    @State var showCaptureImageView: Bool = false
    @State var image: UIImage?
    
    @State var isEditing: Bool = false
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
//                HStack{
//
//
//                    Spacer()
//                    Text()
//                    Spacer()
//
//                }.padding()
//
                ReadBagCompartmentDetailsView(
                    photoActionButtonText: compartment.compartmentImage == nil ? "Add Image" : "Change Image",
                    tmpModel: compartment,
                    itemList: $itemList,
                    image: $image,
                    isEditing: $isEditing,
                    showCaptureImageView: $showCaptureImageView
                )
                .ignoresSafeArea(.all, edges: .bottom)
                
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(Color("IjoTua"))
                    }

                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    if(isEditing){
                        Button("Save"){
                            compartment.items = NSSet(array: itemList.filter{$0.itemName != nil})
                            compartment.compartmentImage = image?.jpegData(compressionQuality: 1.0) ?? compartment.compartmentImage
                            isEditing.toggle()
                            try! viewContext.save()
                            presentationMode.dismiss()
                        }
                        .foregroundColor(Color("IjoTua"))
                    }
                }
            })
            .navigationTitle(compartment.compartmentName ??  "Compartment Name")
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $showCaptureImageView) {
                CaptureImageView(isShown: $showCaptureImageView, image: $image)
                    .ignoresSafeArea(.all, edges: .all)
            }
        }
    }
}


struct ReadBagCompartmentDetailsView: View {
    init(photoActionButtonText: String, tmpModel: CompartmentsEntity, itemList: Binding<[ItemsEntity]>, image: Binding<UIImage?>, isEditing: Binding<Bool>, showCaptureImageView: Binding<Bool>){
        self.photoActionButtonText = photoActionButtonText
        self.tmpModel = tmpModel
        self._listItem = itemList
        self._image = image
        self._isEditing = isEditing
        self._showCaptureImageView = showCaptureImageView
        
        UITableView.appearance().contentInset.top = 0
    }
    
    var photoActionButtonText: String
    var tmpModel: CompartmentsEntity
    @Binding var listItem: [ItemsEntity]
    @Binding var image: UIImage?
    @Binding var isEditing: Bool
    
    @Binding var showCaptureImageView: Bool
    
    var body: some View {
        VStack{
            ImagePlaceholder(compartmentImage: image != nil ? image : (tmpModel.compartmentImage == nil ? nil : UIImage(data:tmpModel.compartmentImage!)))
            Button(action : {
                showCaptureImageView.toggle()
                isEditing = true
            }){
                ZStack{
                    Rectangle()
                        .fill(Color("IjoTua"))
                        .cornerRadius(12)
                        .frame(width: 338, height: 50)
                    
                    Text(photoActionButtonText)
                        .bold()
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            Divider()
            HStack{
                Text("Compartment Items")
                    .font(.system(size: 22, design: .serif).bold())
                    .padding()
                Spacer()
            }
            Divider()
            ReadElementList(data: $listItem, isEditing: $isEditing)
                .safeAreaInset(edge: .bottom) {
                    ReadAddMoreItem(model: self.$listItem, isEditing: $isEditing)
                }
        }
    }
}





struct ReadElementCell: View {
    @Binding var row: String?
    var body: some View {
        VStack(alignment: .leading){
            Spacer()
            TextField("input item name", text: $row).padding(.leading)
            Spacer()
            Divider()
        }.listRowSeparator(.hidden)
            .listRowInsets(.init())
        
    }
}


struct ReadElementList: View {
    @Binding var data: [ItemsEntity]
    @Binding var isEditing: Bool
    var body: some View {
        List {
            ForEach($data, id: \.itemID) {
                item in
                ReadElementCell(row:item.itemName)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init())
                    .swipeActions {
                        Button(action: {
                            data = data.filter{
                                $0.itemID != item.itemID.wrappedValue
                            }
                            
                            isEditing = true
                        }) {
                            Text("Delete").foregroundColor(.red).background(.black)
                            
                        }.tint(.red)
                        
                    }
            }
        }.listStyle(PlainListStyle())
    }
}



struct ReadAddMoreItem: View {
    @Binding var model: [ItemsEntity]
    @Binding var isEditing: Bool
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        HStack{
            Button(action : {
                if(model.last?.itemName != "") {
                    let newItem = ItemsEntity(context: viewContext)
                    newItem.itemID = UUID()
                    model.append(newItem)
                    isEditing = true
                }
            })
            {
                Label("Add More Item", systemImage: "plus.circle")
                    .padding()
                    .foregroundColor(.white)
            }
            Spacer()
        }.background(Color("IjoTua"))
            .frame(height: 82)
    }
}
