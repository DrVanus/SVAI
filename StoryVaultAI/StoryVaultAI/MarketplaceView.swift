//
//  MarketplaceView.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

struct MarketplaceItem: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let year: String
    let description: String
}

struct BookCategory: Identifiable {
    let id = UUID()
    let name: String
    let books: [MarketplaceItem]
}

struct MarketplaceView: View {
    @State private var searchText = ""
    
    // Full set of categories
    private let allCategories: [BookCategory] = [
        BookCategory(
            name: "Fantasy",
            books: [
                MarketplaceItem(title: "Alice’s Adventures in Wonderland", author: "Lewis Carroll", year: "1865", description: "..."),
                MarketplaceItem(title: "The Wonderful Wizard of Oz", author: "L. Frank Baum", year: "1900", description: "..."),
                MarketplaceItem(title: "Peter Pan", author: "J. M. Barrie", year: "1911", description: "..."),
                MarketplaceItem(title: "Grimm’s Fairy Tales", author: "Jacob & Wilhelm Grimm", year: "19th century", description: "..."),
                MarketplaceItem(title: "One Thousand and One Nights", author: "Various", year: "ancient/medieval", description: "...")
            ]
        ),
        BookCategory(
            name: "Adventure",
            books: [
                MarketplaceItem(title: "Treasure Island", author: "Robert Louis Stevenson", year: "1883", description: "..."),
                MarketplaceItem(title: "The Count of Monte Cristo", author: "Alexandre Dumas", year: "1844", description: "..."),
                MarketplaceItem(title: "The Three Musketeers", author: "Alexandre Dumas", year: "1844", description: "..."),
                MarketplaceItem(title: "Robinson Crusoe", author: "Daniel Defoe", year: "1719", description: "..."),
                MarketplaceItem(title: "The Odyssey", author: "Homer", year: "ancient Greek epic", description: "...")
            ]
        ),
        BookCategory(
            name: "Horror / Gothic",
            books: [
                MarketplaceItem(title: "Dracula", author: "Bram Stoker", year: "1897", description: "..."),
                MarketplaceItem(title: "Frankenstein", author: "Mary Shelley", year: "1818", description: "..."),
                MarketplaceItem(title: "Carmilla", author: "J. Sheridan Le Fanu", year: "1872", description: "..."),
                MarketplaceItem(title: "Strange Case of Dr. Jekyll and Mr. Hyde", author: "R. L. Stevenson", year: "1886", description: "...")
            ]
        ),
        BookCategory(
            name: "Romance",
            books: [
                MarketplaceItem(title: "Pride and Prejudice", author: "Jane Austen", year: "1813", description: "..."),
                MarketplaceItem(title: "Jane Eyre", author: "Charlotte Brontë", year: "1847", description: "..."),
                MarketplaceItem(title: "Wuthering Heights", author: "Emily Brontë", year: "1847", description: "..."),
                MarketplaceItem(title: "Little Women", author: "Louisa May Alcott", year: "1868", description: "...")
            ]
        ),
        BookCategory(
            name: "Mystery / Detective",
            books: [
                MarketplaceItem(title: "The Adventures of Sherlock Holmes", author: "Arthur Conan Doyle", year: "1892", description: "..."),
                MarketplaceItem(title: "The Hound of the Baskervilles", author: "Arthur Conan Doyle", year: "1902", description: "..."),
                MarketplaceItem(title: "The Moonstone", author: "Wilkie Collins", year: "1868", description: "..."),
                MarketplaceItem(title: "The Mysterious Affair at Styles", author: "Agatha Christie", year: "1920", description: "...")
            ]
        ),
        BookCategory(
            name: "Science Fiction",
            books: [
                MarketplaceItem(title: "The War of the Worlds", author: "H. G. Wells", year: "1898", description: "..."),
                MarketplaceItem(title: "The Time Machine", author: "H. G. Wells", year: "1895", description: "..."),
                MarketplaceItem(title: "20,000 Leagues Under the Sea", author: "Jules Verne", year: "1870", description: "..."),
                MarketplaceItem(title: "Journey to the Center of the Earth", author: "Jules Verne", year: "1864", description: "...")
            ]
        ),
        BookCategory(
            name: "Drama / Literary Fiction",
            books: [
                MarketplaceItem(title: "The Great Gatsby", author: "F. Scott Fitzgerald", year: "1925", description: "..."),
                MarketplaceItem(title: "The Phantom of the Opera", author: "Gaston Leroux", year: "1910", description: "..."),
                MarketplaceItem(title: "The Sun Also Rises", author: "Ernest Hemingway", year: "1926", description: "..."),
                MarketplaceItem(title: "Winnie-the-Pooh", author: "A. A. Milne", year: "1926", description: "...")
            ]
        )
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredCategories) { category in
                    Section(header: Text(category.name)) {
                        ForEach(category.books) { book in
                            NavigationLink(destination: BookDetailView(book: book)) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(book.title)
                                        .font(.headline)
                                    Text("\(book.author), \(book.year)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Marketplace", displayMode: .inline)
            .searchable(text: $searchText, prompt: "Search books...") // iOS 16+
        }
    }
    
    private var filteredCategories: [BookCategory] {
        if searchText.isEmpty {
            return allCategories
        } else {
            let lower = searchText.lowercased()
            let filtered = allCategories.map { category in
                let matchingBooks = category.books.filter { book in
                    book.title.lowercased().contains(lower)
                    || book.author.lowercased().contains(lower)
                }
                return BookCategory(name: category.name, books: matchingBooks)
            }
            return filtered.filter { !$0.books.isEmpty }
        }
    }
}

struct BookDetailView: View {
    let book: MarketplaceItem
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(book.title)
                    .font(.largeTitle.bold())
                
                Text("\(book.author), \(book.year)")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text(book.description)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
