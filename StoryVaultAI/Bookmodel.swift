//
//  Book.swift
//  StoryVaultAI
//
//  Created by DM on 3/1/25.
//

import SwiftUI

// MARK: - Book Struct
struct Book: Identifiable {
    let id = UUID()
    let title: String
    let author: String?
    let coverName: String?  // Matches the image name in Assets.xcassets
}

// MARK: - BookCategory Struct
struct BookCategory: Identifiable {
    let id = UUID()
    let name: String        // e.g. "Fantasy", "Adventure"
    let books: [Book]       // the books in this category
}

// MARK: - All Categories & Books
let allCategories: [BookCategory] = [
    BookCategory(
        name: "Fantasy",
        books: [
            Book(title: "Alice's Adventures in Wonderland", author: "Lewis Carroll", coverName: "cover_alice_wonderland"),
            Book(title: "The Wonderful Wizard of Oz", author: "L. Frank Baum", coverName: "cover_wizard_of_oz"),
            Book(title: "Peter Pan", author: "J. M. Barrie", coverName: "cover_peter_pan"),
            Book(title: "Grimm's Fairy Tales", author: "The Brothers Grimm", coverName: "cover_grimms_fairy_tales")
        ]
    ),
    BookCategory(
        name: "Adventure",
        books: [
            Book(title: "Treasure Island", author: "Robert Louis Stevenson", coverName: "cover_treasure_island"),
            Book(title: "The Count of Monte Cristo", author: "Alexandre Dumas", coverName: "cover_count_of_monte_cristo"),
            Book(title: "The Odyssey", author: "Homer", coverName: "cover_odyssey"),
            Book(title: "Robinson Crusoe", author: "Daniel Defoe", coverName: "cover_robinson_crusoe")
        ]
    ),
    BookCategory(
        name: "Horror / Gothic",
        books: [
            Book(title: "Dracula", author: "Bram Stoker", coverName: "cover_dracula"),
            Book(title: "Frankenstein", author: "Mary Shelley", coverName: "cover_frankenstein"),
            Book(title: "Carmilla", author: "Sheridan Le Fanu", coverName: "cover_carmilla"),
            Book(title: "Jekyll & Hyde", author: "Robert Louis Stevenson", coverName: "cover_jekyll_hyde")
        ]
    ),
    BookCategory(
        name: "Romance",
        books: [
            Book(title: "Pride and Prejudice", author: "Jane Austen", coverName: "cover_pride_prejudice"),
            Book(title: "Wuthering Heights", author: "Emily Brontë", coverName: "cover_wuthering_heights"),
            Book(title: "Jane Eyre", author: "Charlotte Brontë", coverName: "cover_jane_eyre"),
            Book(title: "Little Women", author: "Louisa May Alcott", coverName: "cover_little_women")
        ]
    )
]
