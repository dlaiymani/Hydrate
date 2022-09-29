//
//  GridContainerCell.swift
//  Hydrate
//
//  Created by David Laiymani on 29/09/2022.
//

import SwiftUI

struct GridContainerCell: View {
    
    @EnvironmentObject var recipientViewModel: RecipientsViewModel

    var container: RecipientEntity
    @State private var shouldShowMenu = true
    @State private var showingSheet = false

    
    var body: some View {
        ContainerView(container: container)
            .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: 30, style: .continuous))
            .contextMenu {
                Button {
                   // self.recipient = container
                    self.showingSheet.toggle()
                } label : {
                    Label("Edit", systemImage: "square.and.pencil")
                }
                
                Divider()
                
                Button(role: .destructive) {
                    withAnimation {
                  //      recipientViewModel.deleteRecipient(container)
                    }
                } label: {
                    Label("Delete", systemImage: "trash")
                    
                }
            }
    }
}

//struct GridContainerCell_Previews: PreviewProvider {
//    static var previews: some View {
//
//        GridContainerCell(container: )
//    }
//}
