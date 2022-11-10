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
                ScreenView(image: "guy-drinking", title: "Step 1", detail: "", bgColor: Color.white)
                    .transition(.scale)
            }
            
            if currentPage == 2 {
                ScreenView(image: "guy-drinking", title: "Step 2", detail: "", bgColor: Color.white)
                    .transition(.scale)

            }
            
            if currentPage == 3 {
                ProfileView()
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
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Color.accentColor)
                    .clipShape(Circle())
                    .overlay {
                        ZStack {
                            Circle()
                                .stroke(Color.accentColor.opacity(0.04), lineWidth: 4)
                                
                            Circle()
                                .trim(from: 0, to: CGFloat(currentPage) / CGFloat(3))
                                .stroke(Color.accentColor, lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }
                        .padding(-10)
                    }
            }
                .disabled(currentPage == 3)
                .opacity(currentPage == 3 ? 0 : 1)
            , alignment: .bottom)
        
    }
}

struct WalkThroughScreen_Previews: PreviewProvider {
    static var previews: some View {
        WalkThroughScreen()
            .environment(\.locale, .init(identifier: "fr"))
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
                    Text("Welcome to")
                        .font(.title)
                        .fontWeight(.semibold)
                        
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
//
//                Button {
//                    withAnimation(.easeInOut) {
//                        currentPage = 4
//                    }
//                } label: {
//                    Text("Skip")
//                        .fontWeight(.semibold)
//                        .foregroundColor(.accentColor)
//                }
            }
            .foregroundColor(.black)
            .padding()
            
            Spacer(minLength: 0)
            
            Text("Hydrate")
                .font(Font.system(size: 50, weight: .bold, design: .rounded).leading(.loose))
                .foregroundColor(.purple)
            
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(LocalizedStringKey(title))
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
