//
//  Container.swift
//  Hydrate
//
//  Created by David Laiymani on 10/09/2022.
//

import SwiftUI


struct Container: Hashable, Identifiable {
    var id = UUID()
    var name: String
    var icon: String
    var volume: Double
    var color: Color
    var isFavorite = false
    
    static var mockContainerData: [Container] = [
        Container(name: "Glass", icon: "wineglass.fill", volume: 20, color: .red, isFavorite: true),
        Container(name: "Cup", icon: "cup.and.saucer.fill", volume: 10, color: .green, isFavorite: true),
        Container(name: "Cup", icon: "cup.and.saucer.fill", volume: 10, color: .orange),
        Container(name: "Cup", icon: "cup.and.saucer.fill", volume: 10, color: .green),
        Container(name: "Cup", icon: "cup.and.saucer.fill", volume: 10, color: .green),
        Container(name: "Cup", icon: "cup.and.saucer.fill", volume: 10, color: .green),
        Container(name: "Cup", icon: "cup.and.saucer.fill", volume: 10, color: .green),
        Container(name: "Cup", icon: "cup.and.saucer.fill", volume: 10, color: .green),
        Container(name: "Cup", icon: "cup.and.saucer.fill", volume: 10, color: .green),
        Container(name: "Cup", icon: "cup.and.saucer.fill", volume: 10, color: .green)
    ]
}


