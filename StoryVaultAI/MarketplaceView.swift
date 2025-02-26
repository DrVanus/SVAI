//
//  MarketplaceView.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

/// A single book in the Marketplace, with title, author, year, and a short description.
struct MarketplaceItem: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let year: String
    let description: String
}

/// A category (genre) containing multiple books.
struct BookCategory: Identifiable {
    let id = UUID()
    let name: String
    let books: [MarketplaceItem]
}

/// The main Marketplace view, showing a list of genres (sections).
struct MarketplaceView: View {
    /// All your public-domain books, grouped by genre.
    private let allCategories: [BookCategory] = [
        BookCategory(
            name: "Fantasy",
            books: [
                MarketplaceItem(
                    title: "Alice’s Adventures in Wonderland",
                    author: "Lewis Carroll",
                    year: "1865",
                    description: "A whimsical tale following Alice down the rabbit hole into a realm of nonsense."
                ),
                MarketplaceItem(
                    title: "The Wonderful Wizard of Oz",
                    author: "L. Frank Baum",
                    year: "1900",
                    description: "Dorothy’s magical journey in Oz with Scarecrow, Tin Man, Cowardly Lion, and the Wizard."
                ),
                MarketplaceItem(
                    title: "Peter Pan (Peter and Wendy)",
                    author: "J. M. Barrie",
                    year: "1911",
                    description: "Adventures of the boy who wouldn’t grow up, set in the enchanted realm of Neverland."
                ),
                MarketplaceItem(
                    title: "Grimm’s Fairy Tales",
                    author: "Jacob & Wilhelm Grimm",
                    year: "19th century",
                    description: "Classic fairy tales like ‘Cinderella’ and ‘Hansel and Gretel.’"
                ),
                MarketplaceItem(
                    title: "One Thousand and One Nights",
                    author: "Various (Arabian Nights)",
                    year: "ancient/medieval",
                    description: "A vast anthology of Middle Eastern folk tales including Aladdin, Ali Baba, and Sinbad."
                )
            ]
        ),
        BookCategory(
            name: "Adventure",
            books: [
                MarketplaceItem(
                    title: "Treasure Island",
                    author: "Robert Louis Stevenson",
                    year: "1883",
                    description: "Quintessential pirate adventure: treasure hunts, mutiny, and Long John Silver."
                ),
                MarketplaceItem(
                    title: "The Count of Monte Cristo",
                    author: "Alexandre Dumas",
                    year: "1844",
                    description: "Edmond Dantès’s epic tale of betrayal, imprisonment, and calculated revenge."
                ),
                MarketplaceItem(
                    title: "The Three Musketeers",
                    author: "Alexandre Dumas",
                    year: "1844",
                    description: "Swashbuckling swordsmen and court intrigue in 17th-century France."
                ),
                MarketplaceItem(
                    title: "Robinson Crusoe",
                    author: "Daniel Defoe",
                    year: "1719",
                    description: "Shipwreck survival saga on a desert island; often called the first English novel."
                ),
                MarketplaceItem(
                    title: "The Odyssey",
                    author: "Homer",
                    year: "ancient Greek epic",
                    description: "Odysseus’s perilous sea journey home, facing cyclopes, sirens, and gods."
                )
            ]
        ),
        BookCategory(
            name: "Romance",
            books: [
                MarketplaceItem(
                    title: "Pride and Prejudice",
                    author: "Jane Austen",
                    year: "1813",
                    description: "Witty courtship and social satire featuring Elizabeth Bennet and Mr. Darcy."
                ),
                MarketplaceItem(
                    title: "Jane Eyre",
                    author: "Charlotte Brontë",
                    year: "1847",
                    description: "A strong-willed governess navigates love, independence, and dark secrets."
                ),
                MarketplaceItem(
                    title: "Wuthering Heights",
                    author: "Emily Brontë",
                    year: "1847",
                    description: "A turbulent, passionate love story on the Yorkshire moors."
                ),
                MarketplaceItem(
                    title: "Little Women",
                    author: "Louisa May Alcott",
                    year: "1868",
                    description: "Coming-of-age story of four sisters, their ambitions, loves, and family trials."
                )
            ]
        ),
        BookCategory(
            name: "Horror / Gothic",
            books: [
                MarketplaceItem(
                    title: "Dracula",
                    author: "Bram Stoker",
                    year: "1897",
                    description: "Seminal vampire novel; a battle of wits against the sinister Count from Transylvania."
                ),
                MarketplaceItem(
                    title: "Frankenstein",
                    author: "Mary Shelley",
                    year: "1818",
                    description: "Earliest sci-fi/horror hybrid; a scientist’s tragic creation of a living being."
                ),
                MarketplaceItem(
                    title: "Carmilla",
                    author: "J. Sheridan Le Fanu",
                    year: "1872",
                    description: "Atmospheric vampire story predating Dracula, featuring an eerie female predator."
                ),
                MarketplaceItem(
                    title: "Strange Case of Dr. Jekyll and Mr. Hyde",
                    author: "Robert Louis Stevenson",
                    year: "1886",
                    description: "Dark exploration of dual personalities and the line between good and evil."
                )
            ]
        ),
        BookCategory(
            name: "Mystery / Detective",
            books: [
                MarketplaceItem(
                    title: "The Adventures of Sherlock Holmes",
                    author: "Arthur Conan Doyle",
                    year: "1892",
                    description: "Short story collection introducing Sherlock Holmes and Dr. Watson’s classic cases."
                ),
                MarketplaceItem(
                    title: "The Hound of the Baskervilles",
                    author: "Arthur Conan Doyle",
                    year: "1902",
                    description: "One of Holmes’s most famous cases, set on the eerie Dartmoor moors."
                ),
                MarketplaceItem(
                    title: "The Moonstone",
                    author: "Wilkie Collins",
                    year: "1868",
                    description: "Often called the first modern English detective novel, involving a stolen gem."
                ),
                MarketplaceItem(
                    title: "The Mysterious Affair at Styles",
                    author: "Agatha Christie",
                    year: "1920",
                    description: "Hercule Poirot’s first appearance, investigating a murder in a country manor."
                )
            ]
        ),
        BookCategory(
            name: "Science Fiction",
            books: [
                MarketplaceItem(
                    title: "The War of the Worlds",
                    author: "H. G. Wells",
                    year: "1898",
                    description: "Martian invasion story; an early alien-invasion classic."
                ),
                MarketplaceItem(
                    title: "The Time Machine",
                    author: "H. G. Wells",
                    year: "1895",
                    description: "A Victorian scientist travels far into the future, encountering Eloi and Morlocks."
                ),
                MarketplaceItem(
                    title: "20,000 Leagues Under the Sea",
                    author: "Jules Verne",
                    year: "1870",
                    description: "Captain Nemo’s submarine voyages across the globe’s oceans, encountering wonders."
                ),
                MarketplaceItem(
                    title: "Journey to the Center of the Earth",
                    author: "Jules Verne",
                    year: "1864",
                    description: "Explorers descend into Earth’s core, discovering prehistoric creatures and caverns."
                )
            ]
        ),
        BookCategory(
            name: "Drama / Literary Fiction",
            books: [
                MarketplaceItem(
                    title: "The Great Gatsby",
                    author: "F. Scott Fitzgerald",
                    year: "1925",
                    description: "Roaring Twenties tale of wealth, love, and tragedy; public domain in 2021."
                ),
                MarketplaceItem(
                    title: "The Phantom of the Opera",
                    author: "Gaston Leroux",
                    year: "1910",
                    description: "Gothic romance-mystery set in the Paris Opera House, featuring a masked composer."
                ),
                MarketplaceItem(
                    title: "The Sun Also Rises",
                    author: "Ernest Hemingway",
                    year: "1926",
                    description: "Modernist drama of expatriates traveling from Paris to Pamplona; public domain in 2022."
                ),
                MarketplaceItem(
                    title: "Winnie-the-Pooh",
                    author: "A. A. Milne",
                    year: "1926",
                    description: "Beloved children’s classic about Pooh and friends in the Hundred Acre Wood."
                )
            ]
        )
    ]
    
    var body: some View {
        NavigationView {
            List {
                // For each genre, create a Section
                ForEach(allCategories) { category in
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
        }
    }
}

/// A detail screen for each book in the Marketplace
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
