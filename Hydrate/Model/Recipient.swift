//
//  Container.swift
//  Hydrate
//
//  Created by David Laiymani on 10/09/2022.
//

import SwiftUI


struct Recipient: Hashable, Identifiable {
    var id = UUID()
    var name: String
    var icon: String
    var volume: Double
    var color: String
    var isFavorite: Bool
    
    static var mockContainerData: [Recipient] = [
        Recipient(name: "Glass", icon: "wineglass.fill", volume: 20,
                  color: "Aqua", isFavorite: true),
        Recipient(name: "Cup", icon: "cup.and.saucer.fill", volume: 10,
                  color: "Cantaloupe", isFavorite: false),
        Recipient(name: "Bottle", icon: "wineglass.fill", volume: 330,
                  color: "Clover", isFavorite: false)
    ]
}


