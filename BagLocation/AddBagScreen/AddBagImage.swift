//
//  AddBagImage.swift
//  BagLocation
//
//  Created by Malik A. Aziz Lubis on 18/05/22.
//

import SwiftUI

struct AddBagImage: View {
    @State var showCaptureImageView: Bool = false
    @Binding var image: UIImage?
    
    @State var capturedImage: UIImage?
    
    @Environment(\.dismiss) var dismiss
    
    init(image: Binding<UIImage?>) {
        self._image = image
        
        self._capturedImage = State(initialValue: image.wrappedValue)
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
                        }else{
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
                        HStack{
                            Image(systemName: "chevron.backward")
                                .renderingMode(.original) // <1>
                                .padding(.trailing, 0.0)
                                .font(.system(size: 17))
                            Text("cancel")
                                .padding(.leading, 0.0)
                        }
                        
                    }.foregroundColor(Color("IjoTua")),
                    trailing:
                        // MARK: SAVE
                    Button(action:{
                        print("Button Save Pressed")
                        image = capturedImage
                        
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

struct CaptureImageView {
    
    /// MARK: - Properties
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, image: $image)
    }
}

extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        //        picker.sourceType = .camera
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}

//
//struct AddBagImage_Previews: PreviewProvider {
//    static var previews: some View {
//        AddBagImage()
//    }
//}
