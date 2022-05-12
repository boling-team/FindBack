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
    @ObservedObject var viewModel = ImageTaggerViewModel()
    @State var currPoint = CGPoint(x: 0, y: 0)
    
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
                                    Button(action: {
                                        self.showCaptureImageView.toggle()
                                    }, label: {
                                        Image("empty-2")
                                            .resizable()
                                            .cornerRadius(10)
                                            .aspectRatio(contentMode: .fit)
                                            .padding(.bottom)
                                    })
                                    
                                }else{
                                    ZStack(alignment: .topLeading){
                                        image?.resizable()
                                            .gesture(
                                                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                                    .onChanged { value in
                                                        if self.currPoint.x != 0 && self.currPoint.y != 0 {
                                                            return
                                                        }
                                                        self.currPoint = value.location
                                                        print(value.location)
                                                    }
                                                    .onEnded { _ in
                                                        viewModel.tagPoint.append(
                                                            BagPoint(point: CGPoint(x: self.currPoint.x, y: self.currPoint.y)))
                                                        self.currPoint = CGPoint(x: 0, y: 0)
                                                    }
                                            )
                                            .frame(width: 330, height: 380)
//                                                .aspectRatio(contentMode: .fit)
//                                                .shadow(radius: 10)
                                        
                                        ForEach(0..<viewModel.tagPoint.count, id: \.self) { x in
                                            let bagPoint = viewModel.tagPoint[x]
                                            
                                            Image(systemName: "bubble.middle.bottom.fill")
                                                .foregroundColor(bagPoint.color)
//                                                    .stroke(lineWidth: 2.0)
//                                                    .fill(bagPoint.color)
                                                .position(bagPoint.point)
                                                .frame(width: 20, height: 20)
                                        }
                                    }
                                    .border(.black, width: 2)
                                    
                                }
                                
                                if (image==nil){
                                    
                                }else{
                                    Button(action: {
                                        self.showCaptureImageView.toggle()
                                    }) {
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
                                        Text("Main Pocket")
                                            .font(.system(size: 20))
                                            .foregroundColor(.gray)
                                        Text("15 Items")
                                            .foregroundColor(.black)
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

struct CloudShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        path.move(to: CGPoint(x: rect.minX + 0.81028 * rect.width, y: rect.minY + 0.39009 * rect.height))
        path.addCurve(to: CGPoint(x: rect.minX + 0.77271 * rect.width, y: rect.minY + 0.39612 * rect.height), control1: CGPoint(x: rect.minX + 0.79766 * rect.width, y: rect.minY + 0.39009 * rect.height), control2: CGPoint(x: rect.minX + 0.78507 * rect.width, y: rect.minY + 0.39210 * rect.height))
        path.addCurve(to: CGPoint(x: rect.minX + 0.69093 * rect.width, y: rect.minY + 0.22300 * rect.height), control1: CGPoint(x: rect.minX + 0.76339 * rect.width, y: rect.minY + 0.32133 * rect.height), control2: CGPoint(x: rect.minX + 0.73325 * rect.width, y: rect.minY + 0.25753 * rect.height))
        path.addCurve(to: CGPoint(x: rect.minX + 0.55572 * rect.width, y: rect.minY + 0.21906 * rect.height), control1: CGPoint(x: rect.minX + 0.64862 * rect.width, y: rect.minY + 0.18847 * rect.height), control2: CGPoint(x: rect.minX + 0.59879 * rect.width, y: rect.minY + 0.18702 * rect.height))
        path.addCurve(to: CGPoint(x: rect.minX + 0.29076 * rect.width, y: rect.minY + 0.02004 * rect.height), control1: CGPoint(x: rect.minX + 0.51674 * rect.width, y: rect.minY + 0.04650 * rect.height), control2: CGPoint(x: rect.minX + 0.39812 * rect.width, y: rect.minY + -0.04260 * rect.height))
        path.addCurve(to: CGPoint(x: rect.minX + 0.16694 * rect.width, y: rect.minY + 0.44594 * rect.height), control1: CGPoint(x: rect.minX + 0.18340 * rect.width, y: rect.minY + 0.08269 * rect.height), control2: CGPoint(x: rect.minX + 0.12797 * rect.width, y: rect.minY + 0.27339 * rect.height))
        path.addCurve(to: CGPoint(x: rect.minX + 0.00002 * rect.width, y: rect.minY + 0.72706 * rect.height), control1: CGPoint(x: rect.minX + 0.07290 * rect.width, y: rect.minY + 0.45072 * rect.height), control2: CGPoint(x: rect.minX + -0.00139 * rect.width, y: rect.minY + 0.57584 * rect.height))
        path.addCurve(to: CGPoint(x: rect.minX + 0.17212 * rect.width, y: rect.minY + 1.00000 * rect.height), control1: CGPoint(x: rect.minX + 0.00143 * rect.width, y: rect.minY + 0.87829 * rect.height), control2: CGPoint(x: rect.minX + 0.07803 * rect.width, y: rect.minY + 0.99976 * rect.height))
        path.addLine(to: CGPoint(x: rect.minX + 0.81028 * rect.width, y: rect.minY + 1.00000 * rect.height))
        path.addCurve(to: CGPoint(x: rect.minX + 1.00000 * rect.width, y: rect.minY + 0.69504 * rect.height), control1: CGPoint(x: rect.minX + 0.91505 * rect.width, y: rect.minY + 1.00000 * rect.height), control2: CGPoint(x: rect.minX + 1.00000 * rect.width, y: rect.minY + 0.86347 * rect.height))
        path.addCurve(to: CGPoint(x: rect.minX + 0.81028 * rect.width, y: rect.minY + 0.39009 * rect.height), control1: CGPoint(x: rect.minX + 1.00000 * rect.width, y: rect.minY + 0.52662 * rect.height), control2: CGPoint(x: rect.minX + 0.91505 * rect.width, y: rect.minY + 0.39009 * rect.height))
        path.closeSubpath()
        return path
        
    }
    
}

struct AddBag_Previews: PreviewProvider {
    static var previews: some View {
        AddBag()
    }
}
