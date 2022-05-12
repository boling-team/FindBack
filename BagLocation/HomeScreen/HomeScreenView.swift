//
//  HomeScreenView.swift
//  BagLocation
//
//  Created by Jonathan Lee on 11/05/22.
//

import SwiftUI

struct HomeScreenView: View {
    //  STATE
    @State var searchText: String = ""
    //    @State var showSearch: Bool = true
    @State var itemList = [1,2,3,4]
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List{
                        CardView()
                        CardView()
                        CardView()
                        CardView()
                    }
                    .searchable(text: $searchText, prompt: "Search item") {
                        //TODO: LOOP ITEM LIST WITH LOCATION INFORMATION PSEUDOCODE
                        // FOREACH ITEM IN ITEM_LIST
                        //      SHOW CARDVIEW CONTAINING THE INFORMATION
                    }
                    .overlay {
                        if (itemList.count == 0) {
                            VStack(spacing: 20) {
                                //MARK: JIKA TIDAK MEMBUTUHKAN FOTO BISA DICOMMENT
                                Image("EmptyBag")
                                    .resizable()
                                    .scaledToFit()
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
                                
                            } label: {
                                Image(systemName: "plus")
                            }
                        }
                    }
                    
                    Spacer()
                }
                .onChange(of: searchText, perform: { _ in
                    //TODO: FILTERING THE ITEM LIST BASED ON THE SEARCH BAR INPUT (searchText)
                    
                })
            }
            .navigationTitle("Bag List")
           
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
