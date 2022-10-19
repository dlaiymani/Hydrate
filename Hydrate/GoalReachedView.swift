//
//  GoalReachedView.swift
//  Hydrate
//
//  Created by David Laiymani on 12/10/2022.
//

import SwiftUI
import ConfettiSwiftUI

struct GoalReachedView: View {
        
    @State private var scale = 0.5
    @Binding var alreadyCongrats: Bool
    @State var counter: Int = 0


    
    var body: some View {
        VStack {
            ZStack {
                VStack(spacing:12) {
                    Text("Congratulations 👏")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Your daily goal is completed")
                        .font(.title3)
                        .fontWeight(.medium)
                    
                    HStack {
                        Image(systemName: "trophy.fill")
                        Image(systemName: "trophy.fill")
                        Image(systemName: "trophy.fill")
                    }
                    
                }
                .frame(width: 300, height: 100)
                .foregroundColor(.white)
                .padding()
                .background(LinearGradient(colors: [Color.purple, Color.indigo], startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(12)
                .animation(.linear(duration: 5), value: scale)
                .scaleEffect(scale)
                .onAppear {
                    let baseAnimation = Animation.easeInOut(duration: 1)
                    let repeated = baseAnimation.repeatCount(1)
                    
                    withAnimation(repeated) {
                        scale = 1.0
                    }
                }
                
            }
            
            Button {
                alreadyCongrats = true
                print("hello")
            } label: {
                Text("Keep Going")
            }
        }
        .frame(height: 300)
        .confettiCannon(counter: $counter, num: 50)
        .onAppear {
            counter += 1
        }
    }
}

struct GoalReachedView_Previews: PreviewProvider {
    static var previews: some View {
        GoalReachedView(alreadyCongrats: .constant(false))
            .frame(width: 300, height: 300)
            .previewLayout(.sizeThatFits)

    }
}
