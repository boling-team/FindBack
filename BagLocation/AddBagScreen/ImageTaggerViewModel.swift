//
//  ImageTaggerViewModel.swift
//  BagLocation
//
//  Created by Malik A. Aziz Lubis on 12/05/22.
//

import SwiftUI

class ImageTaggerViewModel : ObservableObject {
    @Published var tagPoint = [BagPoint]()
}

struct BagPoint {
    let point: CGPoint
    let color = Color.random
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
