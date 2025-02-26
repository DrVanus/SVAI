//
//  ProfileView.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("darkMode") private var darkMode = false
    
    // Example user info
    @State private var username: String = "Reader"
    @State private var subscriptionTier: String = "Free"
    
    @EnvironmentObject var achievementsModel: AchievementsModel
    @EnvironmentObject var library: LibraryModel
    
    // Control showing the edit profile sheet (optional)
    @State private var showEditProfile: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient for a dark, moody look
                LinearGradient(
                    gradient: Gradient(colors: [Color.black, Color.gray.opacity(0.85)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    // Profile Header with Edit button
                    ZStack(alignment: .topTrailing) {
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.brandPrimary)
                            
                            VStack(alignment: .leading) {
                                Text(username)
                                    .font(.title)
                                    .foregroundColor(.white)
                                Text(subscriptionTier)
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.top, 20)
                        
                        // Edit Profile Button (pencil icon)
                        Button(action: {
                            showEditProfile = true
                        }) {
                            Image(systemName: "pencil.circle.fill")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 30)
                        .padding(.top, 28)
                    }
                    
                    // Row for Achievements, Stats, and Upgrade
                    HStack(spacing: 8) {
                        NavigationLink(destination: AchievementsView().environmentObject(achievementsModel)) {
                            HStack(spacing: 4) {
                                Image(systemName: "rosette")
                                    .foregroundColor(.yellow)
                                Text("Achievements")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.6)
                            }
                            .padding(8)
                            .background(Color.purple.opacity(0.7))
                            .cornerRadius(8)
                        }
                        
                        NavigationLink(destination: StatsView().environmentObject(library)) {
                            HStack(spacing: 4) {
                                Image(systemName: "chart.bar.fill")
                                    .foregroundColor(.green)
                                Text("Stats")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.6)
                            }
                            .padding(8)
                            .background(Color.purple.opacity(0.7))
                            .cornerRadius(8)
                        }
                        
                        NavigationLink(destination: SubscriptionView()) {
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Text("Upgrade")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.6)
                            }
                            .padding(8)
                            .background(Color.blue)
                            .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Account Management Section
                    List {
                        Section(header: Text("Account Management").foregroundColor(.primary)) {
                            NavigationLink("Settings", destination: SettingsView())
                            Toggle("Dark Mode", isOn: $darkMode)
                            
                            Button("Logout") {
                                // Placeholder logout logic
                                print("User tapped logout.")
                            }
                            .foregroundColor(.red)
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    
                    Spacer()
                }
            }
            .navigationBarTitle("Profile & Settings", displayMode: .inline)
            .sheet(isPresented: $showEditProfile) {
                // Optional EditProfileView if you want users to change their username/subscription
                EditProfileView(username: $username, subscriptionTier: $subscriptionTier)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AchievementsModel())
            .environmentObject(LibraryModel())
    }
}
