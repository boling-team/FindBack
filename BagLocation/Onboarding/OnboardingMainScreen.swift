//
//  OnboardingMainScreen.swift
//  BagLocation
//
//  Created by Agus Budianto on 18/05/22.
//

import SwiftUI

struct OnboardingMainScreen: View {
    @Environment(\.dismiss) var dismiss
    @State var selectedPage = 0
    var onboardItem: [OnboarModel]
    
    init() {
        self.onboardItem = OnboarModel.initData()
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
        
    }
    
    var body: some View {
        ZStack {
            
            Image("GradientBG")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer(minLength: 50)
                Button(action:{
                    UserDefaults.standard.set(false, forKey: "FirstTimeUser")
                    
                    dismiss()
                }){
                    HStack{
                        Spacer()
                        Text("Skip")
                            .font(Font.system(.headline, design: .serif))
                            .padding()
                    }
                }
                
                TabView(selection: $selectedPage)
                {
                    ForEach(0..<onboardItem.count){ index in
                        OnboardItemView(model: onboardItem[index], page: index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                
                
                
                Button(action : {
                    withAnimation {
                        // JIKA SELECTED PAGE == ONBOARD COUNT
                        if selectedPage == (onboardItem.count - 1){
                            UserDefaults.standard.set(false, forKey: "FirstTimeUser")
                            
                            dismiss()
                            
                            // SAVE KE USER DEFAULTS
                            
                            return
                        } else {
                            selectedPage += 1
                        }
                    }
                })
                {
                    Text(selectedPage == (onboardItem.count - 1) ? "Get Started" : "Next")
                        .frame(width: 192)
                        .font(.system(size: 18))
                        .padding()
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 2)
                        )
                }
                .background(Color("appColor"))
                .cornerRadius(10)
                
                Spacer(minLength: 100)
                
            }
        }
    }
}

struct OnboardingMainScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingMainScreen()
    }
}

