//
//  CategoryListView.swift
//  StoryVaultAI
//
//  Created by DM on 3/1/25.
//

import SwiftUI

struct CategoryListView: View {
    let categories: [BookCategory] = allCategories
    
    var body: some View {
        NavigationView {
            List {
                ForEach(categories) { category in
                    Section(header: Text(category.name)) {
                        ForEach(category.books) { book in
                            BookRow(book: book)
                        }
                    }
                }
            }
            .navigationTitle("StoryVault AI")
        }
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView()
    }
}
