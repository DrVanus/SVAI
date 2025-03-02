//
//  HomeView.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

struct HomeView: View {
    // State vars for showing sheets
    @State private var showWriteYourOwnStory = false
    @State private var showAIAdventure = false
    
    var body: some View {
        ZStack {
            // Purple-to-blue gradient background (customize if you want your original)
            LinearGradient(
                gradient: Gradient(colors: [Color.purple, Color.blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Title & motto
                    Text("StoryVault AI")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.top, 30)
                    
                    Text("Unlock Your Imagination")
                        .foregroundColor(.white)
                        .font(.subheadline)
                    
                    // "Write Your Own Story" button
                    Button(action: {
                        showWriteYourOwnStory = true
                    }) {
                        Text("Write Your Own Story")
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .sheet(isPresented: $showWriteYourOwnStory) {
                        // References your existing WriteYourOwnStoryView file
                        WriteYourOwnStoryView()
                    }
                    
                    // "AI Adventure (Beta)" button
                    Button(action: {
                        showAIAdventure = true
                    }) {
                        Text("AI Adventure (Beta)")
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.purple)
                            .cornerRadius(8)
                    }
                    .sheet(isPresented: $showAIAdventure) {
                        // Change this to your real file name if it's not "BeowulfAdventureView"
                        BeowulfAdventureView()
                    }
                    
                    // ============================
                    // FANTASY
                    // ============================
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Fantasy")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        HStack(spacing: 16) {
                            Button(action: { /* Book action */ }) {
                                VStack {
                                    Image("cover_alice_wonderland")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("Alice's Adventures\nin Wonderland")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            
                            Button(action: {}) {
                                VStack {
                                    Image("cover_wizard_of_oz")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("The Wonderful\nWizard of Oz")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            
                            Button(action: {}) {
                                VStack {
                                    Image("cover_peter_pan")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("Peter Pan")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            
                            Button(action: {}) {
                                VStack {
                                    Image("cover_grimms_fairy_tales")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("Grimm's\nFairy Tales")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // ============================
                    // ADVENTURE
                    // ============================
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Adventure")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        HStack(spacing: 16) {
                            Button(action: {}) {
                                VStack {
                                    Image("cover_treasure_island")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("Treasure Island")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            
                            Button(action: {}) {
                                VStack {
                                    Image("cover_count_of_monte_cristo")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("The Count of\nMonte Cristo")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            
                            Button(action: {}) {
                                VStack {
                                    Image("cover_odyssey")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("The Odyssey")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            
                            Button(action: {}) {
                                VStack {
                                    Image("cover_robinson_crusoe")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("Robinson Crusoe")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // ============================
                    // HORROR / GOTHIC
                    // ============================
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Horror / Gothic")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        HStack(spacing: 16) {
                            Button(action: {}) {
                                VStack {
                                    Image("cover_dracula")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("Dracula")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            
                            Button(action: {}) {
                                VStack {
                                    Image("cover_frankenstein")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("Frankenstein")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            
                            Button(action: {}) {
                                VStack {
                                    Image("cover_carmilla")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("Carmilla")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            
                            Button(action: {}) {
                                VStack {
                                    Image("cover_jekyll_hyde")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("Jekyll & Hyde")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // ============================
                    // ROMANCE
                    // ============================
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Romance")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        HStack(spacing: 16) {
                            Button(action: {}) {
                                VStack {
                                    Image("cover_pride_prejudice")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("Pride and\nPrejudice")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            
                            Button(action: {}) {
                                VStack {
                                    Image("cover_wuthering_heights")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("Wuthering\nHeights")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            
                            Button(action: {}) {
                                VStack {
                                    Image("cover_jane_eyre")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("Jane Eyre")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            
                            Button(action: {}) {
                                VStack {
                                    Image("cover_little_women")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("Little Women")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer().frame(height: 40)
                }
            }
        }
    }
}

// Optional preview struct
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
