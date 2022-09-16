//
//  PlusButtonView.swift
//  Hydrate
//
//  Created by David Laiymani on 06/09/2022.
//

import SwiftUI

struct PlusButtonView: View {
    @State var buttonPressed = false
    
    var numberOfFavorites: Int {
        return  Recipient.mockContainerData.filter({ $0.isFavorite == true }).count
    }
    
    var favoritesContainers: [Recipient] {
        return Recipient.mockContainerData.filter { $0.isFavorite == true}
    }
    
    var body: some View {
        ZStack {
            Button {
                // volumeInPercent += 10
                buttonPressed.toggle()
                
            } label: {
                Image(systemName: "plus")
                    .rotationEffect(.degrees(buttonPressed ? 45 : 0))
                    .foregroundColor(.white)
                    .font(.system(size: 38, weight: .bold))
                    .animation(.spring(response: 0.2, dampingFraction: 0.4, blendDuration: 0))
            }
            .padding(16)
            .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color("PurpleGradient")]), startPoint: .top, endPoint: .bottom))
            .mask(Circle())
            .shadow(color: Color.purple, radius: 5 )
            .zIndex(10)
            
            if buttonPressed {
                Circle()
                    .fill(Color.green)
                    .frame(width: 12, height: 12)
                    .modifier(ParticlesModifier())
                Circle()
                    .fill(Color.blue)
                    .frame(width: 12, height: 12)
                    .modifier(ParticlesModifier())
                Circle()
                    .fill(Color.red)
                    .frame(width: 12, height: 12)
                    .modifier(ParticlesModifier())
            }
            
            
            if numberOfFavorites == 1 {
                GlassButton(buttonPressed: $buttonPressed, icon: favoritesContainers[0].icon, offsetX: -40, offsetY: -80, delay: 0.1)
            } else if numberOfFavorites == 2 {
                GlassButton(buttonPressed: $buttonPressed, icon: favoritesContainers[0].icon, offsetX: -40, offsetY: -80, delay: 0.1)
                GlassButton(buttonPressed: $buttonPressed, icon: favoritesContainers[1].icon, offsetX: 40, offsetY: -80, delay: 0.3)
            } else if numberOfFavorites == 3 {
                GlassButton(buttonPressed: $buttonPressed, icon: favoritesContainers[0].icon, offsetX: -40, offsetY: -80, delay: 0.1)
                GlassButton(buttonPressed: $buttonPressed, icon: favoritesContainers[1].icon, offsetX: 40, offsetY: -80, delay: 0.3)
                 GlassButton(buttonPressed: $buttonPressed, icon: favoritesContainers[2].icon, offsetX: -90, delay: 0)
            } else if numberOfFavorites == 4 {
                GlassButton(buttonPressed: $buttonPressed, icon: favoritesContainers[0].icon, offsetX: -40, offsetY: -80, delay: 0.1)
                GlassButton(buttonPressed: $buttonPressed, icon: favoritesContainers[1].icon, offsetX: 40, offsetY: -80, delay: 0.3)
                 GlassButton(buttonPressed: $buttonPressed, icon: favoritesContainers[2].icon, offsetX: -90, delay: 0)
                 GlassButton(buttonPressed: $buttonPressed, icon: favoritesContainers[3].icon, offsetX: 90, delay: 0.4)
            }
            
      //      GlassButton(buttonPressed: $buttonPressed, icon: "drop.fill", offsetY: -90, delay: 0.2)
//           GlassButton(buttonPressed: $buttonPressed, icon: "drop.fill", offsetX: -40, offsetY: -80, delay: 0.1)
//           GlassButton(buttonPressed: $buttonPressed, icon: "drop.fill", offsetX: 40, offsetY: -80, delay: 0.3)
//            GlassButton(buttonPressed: $buttonPressed, icon: "drop.fill", offsetX: -90, delay: 0)
//            GlassButton(buttonPressed: $buttonPressed, icon: "drop.fill", offsetX: 90, delay: 0.4)
            
        }

    }
}



struct GlassButton: View {
    @Binding var buttonPressed: Bool
    var icon = "pencil"
    var offsetX = 0
    var offsetY = 0
    var delay = 0.0
    
    var body: some View {
        Button {
            
        } label: {
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.system(size: 25, weight: .bold))
        }
        .padding()
        .background(Color.purple)
        .mask(Circle())
        .offset(x: buttonPressed ? CGFloat(offsetX) : 0,
                y: buttonPressed ? CGFloat(offsetY) : 0)
        .scaleEffect(buttonPressed ? 1 : 0)
        .animation(.interpolatingSpring(stiffness: 170, damping: 15).delay(Double(delay)))
      //  .animation(.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0).delay(Double(delay)))
    }
}





struct PlusButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlusButtonView()
    }
}
