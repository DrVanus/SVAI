//
//  BookListView.swift
//  StoryVaultAI
//
//  Created by DM on 3/1/25.
//


import SwiftUI

struct BookListView: View {
    let books: [Book] = [
        Book(title: "Treasure Island", author: "Robert Louis Stevenson", coverName: "TreasureIslandCover"),
        Book(title: "Frankenstein", author: "Mary Shelley", coverName: "FrankensteinCover")
        // Add more books as needed
    ]
    
    var body: some View {
        NavigationView {
            List(books) { book in
                BookRow(book: book)
            }
            .navigationTitle("My Book Library")
        }
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}