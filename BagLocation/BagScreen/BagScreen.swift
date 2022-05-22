//
//  BagScreen.swift
//  BagLocation
//
//  Created by Malik A. Aziz Lubis on 20/05/22.
//

import SwiftUI

struct BagScreen: View {
    // MARK: ENVIRONMENT
    @Environment(\.dismiss) var dismiss
    @Environment(\.editMode) private var editMode
    @Environment(\.managedObjectContext) private var viewContext
    
    // MARK: STATE
    @State var image: UIImage? = nil
    @State var showCaptureImageView: Bool = false
    @State private var showingSheet = false
    
    // MARK: OBSERVED OBJECT
    @ObservedObject var bag: BagsEntity
    
    init(bag: BagsEntity) {
        UITableView.appearance().sectionHeaderHeight = 3
        UITableView.appearance().sectionFooterHeight = 3
        
        self._bag = ObservedObject(initialValue: bag)
    }
    
    var body: some View {
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
                            ZStack {
                                if(bag.bagImage == nil) {
                                    Rectangle()
                                        .fill(Color("IjoTua"))
                                        .cornerRadius(5)
                                        .frame(width: 100, height: 100)
                                    
                                    Image(systemName: "camera")
                                        .frame(width: 40, height: 40)
                                        .font(Font.custom("Serif",size: 30))
                                        .foregroundColor(.white)
                                }
                                else {
                                    Image(uiImage: UIImage(data: bag.bagImage!)!)
                                        .resizable()
                                        .clipped()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(5)
                                        .padding(.all, 0.0)
                                }
                            }
                        }
                        .fullScreenCover(isPresented: $showingSheet) {
                            AddBagImageCoreData(image: bag.wrappedBagImage, bag: bag)
                        }
                        
                        VStack(alignment: .leading){
                            Text("Bag Name")
                                .font(Font.system(.headline, design: .serif))
                                .foregroundColor(.black)
                            BagNameTextField(bag: bag)
                                .foregroundColor(.black)
                                .disabled(!editMode!.wrappedValue.isEditing)
                            
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
                .textCase(nil)
            
            
            ForEach(bag.compartmentList, id:\.compartmentID) {
                compartment in
                ReadBagCompartmentView(compartment: compartment)
            }
            .onDelete(perform: deleteCompartment)
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Bag")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
                    .foregroundColor(Color("IjoTua"))
            }
            
            ToolbarItemGroup(placement: .bottomBar) {
                if(editMode?.wrappedValue == .active) {
                    Button{
                        withAnimation {
                            // MARK: CAN BE BETTER
                            // ADD A NEW COMPARTMENT
                            if (bag.compartmentList.first?.compartmentName != "") {
                                viewContext.performAndWait {
                                    let newCompartments = CompartmentsEntity(context: viewContext)
                                    newCompartments.compartmentName = ""
                                    newCompartments.compartmentID = UUID()
                                    newCompartments.bag = bag
                                    
                                    var currentCompartments = bag.compartmentList
                                    currentCompartments.append(newCompartments)
                                    
                                    bag.compartments = NSSet(array: currentCompartments)
                                    
                                    try? viewContext.save()
                                    
                                }
                            }
                        }
                    } label: {
                        HStack {
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
    
    private func deleteCompartment(offsets: IndexSet) {
        withAnimation {
            // LOOP THROUGH OFFSETS AND DELETE THOSE INDEXES
            offsets.map { bag.compartmentList[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // AUTO GENERATED CODE BY CORE DATA
                
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ReadBagCompartmentView: View {
    // MARK: ENVIRONMENT
    @Environment(\.editMode) var editMode
    
    // MARK: BINDING
    @ObservedObject var compartment: CompartmentsEntity
    
    @State private var showingSheet = false
    var body: some View {
        Section{
            Button {
                showingSheet.toggle()
            } label: {
                HStack{
                    Image(uiImage:  compartment.wrappedCompartmentImage)
                        .resizable()
                        .cornerRadius(5)
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading){
                        CompartmentNameTextField(compartment: compartment)
                            .disabled(!editMode!.wrappedValue.isEditing)
                            .font(Font.system(.headline, design: .serif))
                            .foregroundColor(.black)
                            .padding(.leading, 5.0)
                        Text("\(compartment.items?.count ?? 0) Items")
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
        }
        .listRowBackground(Color("IjoMuda"))
        .sheet(isPresented: $showingSheet) {
            ReadBagCompartment(compartment: compartment, itemList: compartment.itemList)
        }
    }
}

struct BagNameTextField: View {
    @ObservedObject var bag: BagsEntity
    @Environment(\.managedObjectContext) private var viewContext
    
    @FocusState var isTextFieldFocused: Bool
    
    init(bag: BagsEntity) {
        self._bag = ObservedObject(initialValue: bag)
    }
    
    var body: some View {
        TextField("E.g. Green Bag", text: $bag.bagName)
        //            .modifier(TextClearField(text: $bag.bagName.toUnwrapped(defaultValue: "")))
            .focused($isTextFieldFocused)
            .onChange(of: isTextFieldFocused) { isFocused in
                if !isFocused {
                    try! viewContext.save()
                }
            }
    }
}

struct CompartmentNameTextField: View {
    @ObservedObject var compartment: CompartmentsEntity
    @Environment(\.managedObjectContext) private var viewContext
    
    @FocusState var isTextFieldFocused: Bool
    
    init(compartment: CompartmentsEntity) {
        self._compartment = ObservedObject(initialValue: compartment)
    }
    
    var body: some View {
        TextField("E.g. Side pocket", text: $compartment.compartmentName)
        //            .modifier(TextClearField(text: $compartment.compartmentName.toUnwrapped(defaultValue: "")))
            .focused($isTextFieldFocused)
            .onChange(of: isTextFieldFocused) { isFocused in
                if !isFocused {
                    print("Before Save", compartment.compartmentName!)
                    try! viewContext.save()
                    print("After Save", compartment.compartmentName!)
                }
            }
    }
}

extension Binding {
    func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
