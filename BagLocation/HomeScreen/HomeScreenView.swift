//
//  HomeScreenView.swift
//  BagLocation
//
//  Created by Jonathan Lee on 11/05/22.
//

import SwiftUI

struct HomeScreenView: View {
    // MARK: ENVIRONMENT
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.isSearching) private var isSearching
    
    // MARK: FETCH REQUEST
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var bags: FetchedResults<BagsEntity>
    
    // MARK: STATE
    @State var searchText: String = ""
    @State private var showingSheet = false
    
    init(){
        UITableView.appearance().sectionHeaderHeight = 3
        UITableView.appearance().sectionFooterHeight = 3
    }
    
    var body: some View {
        NavigationView {
            List{
                ForEach(bags, id: \.self) {
                    Section {
                        CardView()
                    }
                    .listRowBackground(Color("IjoMuda"))
                }
                .onDelete(perform: deleteBag)
//                ForEach((1...9).reversed(), id: \.self) { i in
//                    Section{
//                        CardView()
//                    }.listRowBackground(Color("IjoMuda"))
//                }
//                .onDelete(perform: <#T##Optional<(Foundation.IndexSet) -> Void>#>)
            }
            .listStyle(.insetGrouped)
            .searchable(text: $searchText, prompt: "Search item") {
                //TODO: LOOP ITEM LIST WITH LOCATION INFORMATION PSEUDOCODE
                // FOREACH ITEM IN ITEM_LIST
                //      SHOW CARDVIEW CONTAINING THE INFORMATION
            }
            .overlay {
//                if (itemList.count == 0) {
//                    VStack(spacing: 20) {
//                        //MARK: JIKA TIDAK MEMBUTUHKAN FOTO BISA DICOMMENT
//                        Image("EmptyBag")
//                            .resizable()
//                            .scaledToFit()
//                        Text("Your Bag List is empty. \nClick + to add new bag")
//                            .multilineTextAlignment(.center)
//                            .padding(.bottom, 40)
//                            .foregroundColor(.gray)
//                    }
//                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    //MARK: BAWAAN EDIT BUTTON SENDIRI
                    //UNTUK SEMENTARA, BUTTON EDIT ADALAH INI
                    //TETAPI SEPERTINYA AKAN DIGANTIKAN DENGAN
                    //BUTTON EDIT SENDIRI KARENA BUG YANG MUNGKIN TERJADI
                    //DENGAN CORE DATA.
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showingSheet) {
                        AddBag()
                    }
                }
            }
            .navigationTitle("Bag List")
        }
        
    }
    
    func deleteBag() {
        
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
