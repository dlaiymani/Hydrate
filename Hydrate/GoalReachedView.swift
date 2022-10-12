//
//  GoalReachedView.swift
//  Hydrate
//
//  Created by David Laiymani on 12/10/2022.
//

import SwiftUI

struct GoalReachedView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var scale = 0.5

    
    var body: some View {
        VStack {
            Spacer()
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
                
                ConfettisView()
            }
            Spacer()
            Button {
                dismiss()
            } label: {
                Text("Keep Going")
            }
            Spacer()

        }
    }
}

struct GoalReachedView_Previews: PreviewProvider {
    static var previews: some View {
        GoalReachedView()
    }
}
