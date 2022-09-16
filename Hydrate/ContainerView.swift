//
//  ContainerView.swift
//  Hydrate
//
//  Created by David Laiymani on 10/09/2022.
//

import SwiftUI

struct ContainerView: View {
    var container: Recipient
    @State var isFavorite = false
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .frame(width: 150, height: 150)
                .foregroundColor(container.color)
                .cornerRadius(20)
            
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: container.icon)
                        .padding()
                    
                    Spacer()
                    
                    Button {
                        isFavorite.toggle()
                    } label: {
                        Image(systemName: isFavorite ? "star.fill" : "star")
                    }
                    
                    .buttonStyle(FavoriteButtonStyle())
                }
                

               Spacer()

                Text(container.name)
                    .font(.title2)
                    .fontWeight(.medium)
                    .padding(.bottom,4)
                    .padding(.leading)

                Text("\(container.volume, specifier: "%2.f") cl")
                    .font(.subheadline)
                    .padding([.bottom, .leading])
            }
            .frame(width: 150, height: 150, alignment: .leading)
            .foregroundColor(.white)
        }
    }
}


struct FavoriteButtonStyle: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .scaleEffect(configuration.isPressed ? 0.6 : 1.2)
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView(container: Recipient(name: "Glass", icon: "wineglass.fill", volume: 20, color: Color.red))
    }
}
