//
//  ContainerView.swift
//  Hydrate
//
//  Created by David Laiymani on 10/09/2022.
//

import SwiftUI

struct ContainerView: View {
    
    @AppStorage("sounds") private var soundIsOn = true
    @AppStorage("vibrations") private var vibrationIsOn = true
    
    
    @ObservedObject var container: RecipientEntity // because it is a class!!!!
    @FetchRequest(sortDescriptors: [SortDescriptor(\.volume)], predicate: NSPredicate(format: "isFavorite == true")) var favoriteRecipients: FetchedResults<RecipientEntity>
    
    @State private var isShowingAlert = false

    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: container.icon ?? "cup")
                    .padding()

                
                Spacer()
                
                Button {
                    withAnimation {
                        if ((favoriteRecipients.count == 4) && (container.isFavorite == false)) {
                            isShowingAlert = true
                        } else {
                            container.isFavorite.toggle()
                            if vibrationIsOn {
                                simpleSuccess()
                            }
                            PersistenceController.shared.save()
                        }
                    }
                    
                } label: {
                    Image(systemName: container.isFavorite ? "star.fill" : "star")
                }
                .buttonStyle(FavoriteButtonStyle())
            }
            
            
            Spacer()
            
            Text(container.name ?? "cup")
                .font(.title2)
                .fontWeight(.medium)
                .padding(.bottom,4)
                .padding(.leading)
            
            Text("\(container.volume, specifier: "%2.f") cl")
                .font(.subheadline)
                .padding([.bottom, .leading])
        }
        .frame(width: 150, height: 150, alignment: .leading)
        .background(Color(container.color ?? "Lavender"))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .foregroundColor(.white)
        .alert(isPresented: $isShowingAlert, content: {
            Alert(title: Text("You must favorite at most 4 recipients 😎"))
        })
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}


struct FavoriteButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .scaleEffect(configuration.isPressed ? 0.6 : 1.2)
    }
}

//struct ContainerView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContainerView(container: Recipient(name: "Glass", icon: "wineglass.fill", volume: 20,
//                                           red: UIColor(.red).cgColor.components![0],
//                                           green: UIColor(.red).cgColor.components![1],
//                                           blue: UIColor(.red).cgColor.components![2],
//                                           opacity: 1.0,
//                                           isFavorite: true))
//    }
//}
