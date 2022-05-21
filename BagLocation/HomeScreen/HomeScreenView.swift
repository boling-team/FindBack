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
            HomeScreenList(bags: bags)
                .listStyle(.insetGrouped)
                .searchable(text: $searchText, prompt: "Search item") {
                    //TODO: LOOP ITEM LIST WITH LOCATION INFORMATION PSEUDOCODE
                    // FOREACH ITEM IN ITEM_LIST
                    //      SHOW CARDVIEW CONTAINING THE INFORMATION
                }
//                .environment(\.managedObjectContext, viewContext)
            .overlay {
                if (bags.count == 0) {
                    VStack(spacing: 20) {
                        //MARK: JIKA TIDAK MEMBUTUHKAN FOTO BISA DICOMMENT
                        Text("Your Bag List is empty. \nClick + to add new bag")
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 40)
                            .foregroundColor(.gray)
                    }
                }
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
}

struct HomeScreenList: View {
    // MARK: SEARCH
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.isSearching) private var isSearching
    
    // MARK: STATE
    @State var searchText: String = ""
    @State var searchResult: [SearchResult] = []
    
    var bags: FetchedResults<BagsEntity>
    
    var body: some View {
        List{
            if(isSearching) {
                // MARK: FITUR SEARCHING
//                ForEach(bags, id: \.wrappedBagID) {
//                    bag in
//                    Section {
//                        CardView(bag: bag)
//                    }
//                    .listRowBackground(Color("IjoMuda"))
//                }
//                .onDelete(perform: deleteBag)
                Text("Lagi Cari Mas")
            } else {
                ForEach(bags, id: \.wrappedBagID) {
                    bag in
                        CardView(bag: bag)
                    .listRowBackground(Color("IjoMuda"))
                }
                .onDelete(perform: deleteBag)
            }
            
            Section {
                // MARK: JANGAN LUPA HAPUS
                Button("PRINT OUT DB LOCATION") {
                    // DB LOCATION
                    let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
                    print(paths[0])
                }
            }
      }
        .onChange(of: searchText, perform: { _ in
            //TODO: FILTERING THE ITEM LIST BASED ON THE SEARCH BAR INPUT (searchText)
            
            // MARK: JANGAN LUPA
            // Bag <--->> Compartment <--->> Item
            var results: [SearchResult] = []
            
            for bag in bags {
                for compartment in bag.compartmentList {
                    // if array.contains(where: {$0.name == "foo"})
                    for item in compartment.itemList {
                        if(item.itemName!.localizedCaseInsensitiveContains(searchText)) {
                            results.append(SearchResult(bag: bag, compartment: compartment, item: item))
                        }
                    }
                }
            }
            
            print(results)
            searchResult = results
        })
    }
    
    private func deleteBag(offsets: IndexSet) {
        withAnimation {
            offsets.map { bags[$0] }.forEach(viewContext.delete)
            
            try! viewContext.save()
//            
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}

struct SearchResult {
    var bag: BagsEntity
    var compartment: CompartmentsEntity
    var item: ItemsEntity
}
