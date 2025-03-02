//
//  LibraryDetailView.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

struct LibraryDetailView: View {
    @Binding var item: LibraryItem

    var body: some View {
        Form {
            Section(header: Text("STORY INFO")) {
                Text("Title: `\(item.title)")
                // Add other details
            }
        }
    }
}
