//
//  WalkThroughScreen.swift
//  Hydrate
//
//  Created by David Laiymani on 20/10/2022.
//

import SwiftUI

var totalPages = 3

struct WalkThroughScreen: View {
    
    @AppStorage("currentPage") var currentPage = 1

    
    var body: some View {
        ZStack {
            if currentPage == 1 {
                ScreenView(image: "guy-drinking", title: "Step 1", detail: "", bgColor: Color.purple)
                    .transition(.scale)
            }
            
            if currentPage == 2 {
                ScreenView(image: "guy-drinking", title: "Step 2", detail: "", bgColor: Color.yellow)
                    .transition(.scale)

            }
            
            if currentPage == 3 {
                ScreenView(image: "guy-drinking", title: "Step 3", detail: "", bgColor: Color.pink)
                    .transition(.scale)

            }
           
        }
        .animation(.easeInOut(duration: 0.35), value: currentPage)
        .overlay(
            Button {
                withAnimation(.easeInOut) {
                    currentPage += 1
                }
            } label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay {
                        ZStack {
                            Circle()
                                .stroke(Color.black.opacity(0.04), lineWidth: 4)
                                
                            Circle()
                                .trim(from: 0, to: CGFloat(currentPage) / CGFloat(3))
                                .stroke(Color.white, lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }
                        .padding(-15)
                    }
            }, alignment: .bottom)
        
    }
}

struct WalkThroughScreen_Previews: PreviewProvider {
    static var previews: some View {
        WalkThroughScreen()
    }
}

struct ScreenView: View {
    
    var image: String
    var title: String
    var detail: String
    var bgColor: Color
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                
                if currentPage == 1 {
                    Text("Hello Member!")
                        .font(.title)
                        .fontWeight(.semibold)
                        .kerning(1.4)
                } else {
                    Button {
                        
                        withAnimation(.easeInOut) {
                            currentPage -= 1
                        }
                        
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                    }
                }
                
                
                
                Spacer()
                
                Button {
                    withAnimation(.easeInOut) {
                        currentPage = 4
                    }
                } label: {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .kerning(1.2)
                }
            }
            .foregroundColor(.black)
            .padding()
            
            Spacer(minLength: 0)
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top)
            
            
            Text("Lorem ipsum is dummy text used in laying out print, graphic or web design")
                .fontWeight(.semibold)
                .kerning(1.3)
                .multilineTextAlignment(.center)
            
            Spacer(minLength: 100)
        }
        .background(bgColor.cornerRadius(10).ignoresSafeArea())
    }
}
