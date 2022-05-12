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

struct AddBag: View {
    @State var image: Image? = nil
    @State var showCaptureImageView: Bool = false
    @State var bag: Bag = Bag()
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack {
                    List{
                        Section(header:Text("Bag Name")
                            .foregroundColor(.black)
                            .bold()){
                            TextField("Green Bag", text: $bag.bagName)
                                .foregroundColor(.black)
                            
                                if (image==nil){
                                    Image("empty")
                                        .resizable()
                                        .cornerRadius(10)
                                        .aspectRatio(contentMode: .fit)
                                        .padding(.bottom)
                                }else{
                                    HStack(alignment: .center){
                                        image?.resizable()
                                          .frame(width: 330, height: 330)
                                          .aspectRatio(contentMode: .fit)
                                          .shadow(radius: 10)
                                    }.frame(maxWidth: .infinity)
                                }
                                
                              Button(action: {
                                self.showCaptureImageView.toggle()
                              }) {
                                if (image==nil){
                                    Text("Add photo")
                                }else{
                                    Text("Change photo")
                                }
                              }
                                  
                                
                                
                                
                        }.listRowBackground(Color(red: 0.97, green: 0.97, blue: 0.97))
                        
                        Section(){
                            ForEach((1...5).reversed(), id: \.self) { i in
//                                NavigationLink(destination: , {
                                    HStack{
                                        Image(systemName: "bubble.middle.bottom.fill")
                                            .renderingMode(.original) // <1>
                                            .font(.system(size: 25))
                                        VStack(alignment: .leading){
                                            Text("Main Pocket").foregroundColor(.gray)
                                            Text("15 Items")
                                                .foregroundColor(.black)
                                                .font(.system(size: 20))
                                                .multilineTextAlignment(.leading)
                                        }
                                        
                                    }
//                                }
                            }
                        }.listRowBackground(Color(red: 0.97, green: 0.97, blue: 0.97))

                    }.listStyle(.insetGrouped)
                    
                   
                }
                if (showCaptureImageView) {
                  CaptureImageView(isShown: $showCaptureImageView, image: $image)
                }
            
            }.navigationTitle("Add Bag")
                .foregroundColor(Color(red: 0.1, green: 0.5, blue: 0.9))
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    leading:
                        Button(action:{
                            print("Button Cancel Pressed")
                        }){
                            Image(systemName: "chevron.backward")
                                .renderingMode(.original) // <1>
                                .font(.system(size: 20))
                            Text("Cancel").bold()
                        
                        },
                    trailing:
                        Button(action:{
                            print("Button Save Pressed")
                        }){
                            Text("Save").bold()
                        }
                )
                .background(.white)
            
        }
    }
}

struct CaptureImageView {
    
    /// MARK: - Properties
    @Binding var isShown: Bool
    @Binding var image: Image?
    
    func makeCoordinator() -> Coordinator {
      return Coordinator(isShown: $isShown, image: $image)
    }
}

extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
            context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}

struct AddBag_Previews: PreviewProvider {
    static var previews: some View {
        AddBag()
    }
}
