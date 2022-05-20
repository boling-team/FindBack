//
//  AddBagImageCoreData.swift
//  BagLocation
//
//  Created by Jonathan Lee on 20/05/22.
//

import SwiftUI

struct AddBagImageCoreData: View {
    // MARK: ENVIRONMENT
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State var showCaptureImageView: Bool = false
    @State var capturedImage: UIImage?
    
    var bag: BagsEntity
    
    init(image: UIImage, bag: BagsEntity) {
        self._capturedImage = State(initialValue: image)
        self.bag = bag
    }
    
    var body: some View {
        ZStack {
            NavigationView{
                ZStack {
                    VStack {
                        if (capturedImage==nil){
                            ZStack{
                                Rectangle()
                                    .fill(Color("IjoTua"))
                                    .cornerRadius(12)
                                    .frame(width: 338, height: 338)
                                
                                Image(systemName: "camera")
                                    .renderingMode(.original)
                                    .font(Font.custom("Serif",size: 60))
                                    .foregroundColor(.white)
                            }
                        } else {
                            // JIKA EDIT MODE NYALA
                            // TUNJUKKIN ICON EDIT
                            ZStack {
                                Image(uiImage: capturedImage!)
                                    .resizable()
                                    .frame(width: 338, height: 338)
                                    .cornerRadius(5)
                                    .padding(.all, 0.0)
                            }
                        }
                        
                        
                        Button(action: {
                            self.showCaptureImageView.toggle()
                        }, label: {
                            ZStack{
                                Rectangle()
                                    .fill(Color("IjoTua"))
                                    .cornerRadius(12)
                                    .frame(width: 338, height: 50)
                                
                                //                                Text(image==nil ? "Take Photo" : "Change Photo")
                                Text("Take Photo")
                                    .bold()
                                    .font(.system(size: 22))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        })
                        Spacer()
                    }
                    
                }
                .navigationBarItems(
                    leading:
                        // MARK: CANCEL
                    Button(action:{
                        dismiss()
                    }){
                        Text("Cancel")
                            .foregroundColor(Color("IjoTua"))
                    },
                    trailing:
                        // MARK: SAVE
                    Button(action:{
                        print("Button Save Pressed")
                        
                        // SAVE
                        viewContext.performAndWait {
                            bag.bagImage = capturedImage?.jpegData(compressionQuality: 1.0)
                            
                            try? viewContext.save()
                        }
                        
                        // DISMISS THE SHEETS
                        dismiss()
                    }){
                        Text("Save")
                            .foregroundColor(Color("IjoTua"))
                    }
                )
            }
            if (showCaptureImageView) {
                CaptureImageView(isShown: $showCaptureImageView, image: $capturedImage)
                    .ignoresSafeArea(.all, edges: .all)
            }
        }
    }
}
