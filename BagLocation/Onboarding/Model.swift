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
                title: "Hello Campers!",
                description: "Welcome to Backpack, Let’s organize your camping logistics in your bag.",
                image: "Screen1",
                page: 0
            )
        )
        
        data.append(
            OnboarModel(
                title: "Logistic Planning",
                description: "Backpack can helps you to plan your logistics for your camping needs!",
                image: "Screen2",
                page: 1
            )
        )
        
        data.append(
            OnboarModel(
                title: "Item Search",
                description: "You can find the items in your bag quickly whenever you need them.",
                image: "Screen3",
                page: 2
            )
        )
        
        data.append(
            OnboarModel(
                title: "How do we do it?",
                description: "You can make a list of bags, take pictures, and determine items’ placement. You can find items in your bag quickly with the search feature.",
                image: "Screen4",
                page: 3
            )
        )
        
        data.append(
            OnboarModel(
                title: "Fun Camping",
                description: "Let's make camping a fun experience!",
                image: "Screen5",
                page: 4
            )
        )
        
        
        return data
    }
}
