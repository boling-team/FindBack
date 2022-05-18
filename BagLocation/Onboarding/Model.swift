//
//  Model.swift
//  BagLocation
//
//  Created by Agus Budianto on 18/05/22.
//

import Foundation

struct OnboarModel: Hashable {
    var title : String
    var description : String
    var image: String
    var page: Int
    
    static func initData() -> [OnboarModel] {
        var data = [OnboarModel]()
        
        data.append(
            OnboarModel(
                title: "Hello Campers! 1",
                description: "Welcome to Backpack, Let’s organize your camping logistics in your bag.",
                image: "Screen1",
                page: 0
            )
        )
        
        data.append(
            OnboarModel(
                title: "Hello Campers! 2",
                description: "Welcome to Backpack, Let’s organize your camping logistics in your bag.",
                image: "Screen2",
                page: 1
            )
        )
        
        data.append(
            OnboarModel(
                title: "Hello Campers! 3",
                description: "Welcome to Backpack, Let’s organize your camping logistics in your bag.",
                image: "Screen3",
                page: 2
            )
        )
        
        data.append(
            OnboarModel(
                title: "Hello Campers! 4",
                description: "Welcome to Backpack, Let’s organize your camping logistics in your bag.",
                image: "Screen4",
                page: 3
            )
        )
        
        data.append(
            OnboarModel(
                title: "Hello Campers! 5",
                description: "Welcome to Backpack, Let’s organize your camping logistics in your bag.",
                image: "Screen5",
                page: 4
            )
        )
        
        
        return data
    }
}
