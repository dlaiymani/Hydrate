//
//  PlusButtonView.swift
//  Hydrate
//
//  Created by David Laiymani on 06/09/2022.
//

import SwiftUI

struct PlusButtonView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.volume)], predicate: NSPredicate(format: "isFavorite == true")) var recipients: FetchedResults<RecipientEntity>
    
    
    @State var buttonPressed = false
    @Binding var volume: Double
    var goal: Double

    
    var numberOfFavorites: Int {
        return  recipients.count
    }
    
    var body: some View {
        ZStack {
            Button {
                buttonPressed.toggle()
            } label: {
                Image(systemName: "plus")
                    .rotationEffect(.degrees(buttonPressed ? 45 : 0))
                    .foregroundColor(.white)
                    .font(.system(size: 38, weight: .regular))
                    .animation(.spring(response: 0.2, dampingFraction: 0.4, blendDuration: 0))
            }
            
            .padding(16)
            .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.purple, Color.indigo]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .mask(Circle())
            .shadow(color: Color.purple, radius: 5 )
            .zIndex(10)
            
            if numberOfFavorites == 1 {
                GlassButton(buttonPressed: $buttonPressed, volume: $volume, recipient: recipients[0], offsetX: -40, offsetY: -80, delay: 0.1)
            } else if numberOfFavorites == 2 {
                GlassButton(buttonPressed: $buttonPressed, volume: $volume, recipient: recipients[0], offsetX: -40, offsetY: -80, delay: 0.1)
                GlassButton(buttonPressed: $buttonPressed, volume: $volume, recipient: recipients[1], offsetX: 40, offsetY: -80, delay: 0.3)
            } else if numberOfFavorites == 3 {
                GlassButton(buttonPressed: $buttonPressed, volume: $volume, recipient: recipients[1], offsetX: -40, offsetY: -80, delay: 0.1)
                GlassButton(buttonPressed: $buttonPressed, volume: $volume, recipient: recipients[2], offsetX: 40, offsetY: -80, delay: 0.3)
                GlassButton(buttonPressed: $buttonPressed, volume: $volume, recipient: recipients[0], offsetX: -90, delay: 0 )
            } else if numberOfFavorites == 4 {
                GlassButton(buttonPressed: $buttonPressed, volume: $volume, recipient: recipients[1], offsetX: -40, offsetY: -80, delay: 0.1)
                GlassButton(buttonPressed: $buttonPressed, volume: $volume, recipient: recipients[2], offsetX: 40, offsetY: -80, delay: 0.3)
                GlassButton(buttonPressed: $buttonPressed, volume: $volume, recipient: recipients[0], offsetX: -90, delay: 0)
                GlassButton(buttonPressed: $buttonPressed, volume: $volume, recipient: recipients[3], offsetX: 90, delay: 0.4)
            }
        }
    }
}



struct GlassButton: View {
    
    @Binding var buttonPressed: Bool
    @Binding var volume: Double
    @State var recipient: RecipientEntity
    var offsetX = 0
    var offsetY = 0
    var delay = 0.0
        
    var body: some View {
        Button {
            volume += recipient.volume
            buttonPressed.toggle()
        } label: {
            VStack {
                Image(systemName: recipient.icon ?? "cup")
                    .font(.system(size: 18, weight: .bold))
                Text("\(Int(recipient.volume))")
            }
            .foregroundColor(.white)
            .frame(width: 40, height: 40)
            
        }
        .padding(12)
        .background(Color(recipient.color ?? "Plum"))
        .mask(Circle())
        .offset(x: buttonPressed ? CGFloat(offsetX) : 0,
                y: buttonPressed ? CGFloat(offsetY) : 0)
        .scaleEffect(buttonPressed ? 1 : 0)
        .animation(.interpolatingSpring(stiffness: 170, damping: 15).delay(Double(delay)), value: buttonPressed)
    }
}


struct PlusButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlusButtonView(volume: .constant(0.2), goal: 1200)
    }
}
