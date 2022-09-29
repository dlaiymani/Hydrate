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
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var opacity: CGFloat
    var isFavorite: Bool
    
    static var mockContainerData: [Recipient] = [
        Recipient(name: "Glass", icon: "wineglass.fill", volume: 20,
                  red: UIColor(.red).cgColor.components![0],
                  green: UIColor(.red).cgColor.components![1],
                  blue: UIColor(.red).cgColor.components![2],
                  opacity: 1.0,
                  isFavorite: true),
        Recipient(name: "Cup", icon: "cup.and.saucer.fill", volume: 10,
                  red: UIColor(.green).cgColor.components![0],
                  green: UIColor(.green).cgColor.components![1],
                  blue: UIColor(.green).cgColor.components![2],
                  opacity: 1.0,
                  isFavorite: false),
        Recipient(name: "Bottle", icon: "wineglass.fill", volume: 330,
                  red: UIColor(.orange).cgColor.components![0],
                  green: UIColor(.orange).cgColor.components![1],
                  blue: UIColor(.orange).cgColor.components![2],
                  opacity: 1.0,
                  isFavorite: false)
    ]
}


