//
//  ProfileView.swift
//  StoryVault AI 2
//
//  Created by DM on 2/24/25.
//

import SwiftUI

// MARK: - Profile with Subscription Tier

struct ProfileView: View {
    @AppStorage("darkMode") private var darkMode = false
    
    @State private var username: String = "Reader"
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var fontSize: Double = 16
    
    @State private var subscriptionTier: String = "Free"
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.purple.opacity(0.2), .blue.opacity(0.2)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                
                Form {
                    Section(header: Text("User Info")) {
                        HStack(spacing: 16) {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.brandPrimary)
                            TextField("Username", text: $username)
                                .font(.headline)
                        }
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                        SecureField("Password", text: $password)
                    }
                    
                    Section(header: Text("Preferences")) {
                        Toggle("Dark Mode", isOn: $darkMode)
                        HStack {
                            Text("Font Size: \(Int(fontSize))")
                            Spacer()
                            Slider(value: $fontSize, in: 12...24, step: 1)
                        }
                        NavigationLink("Tutorial / Help") {
                            TutorialView()
                        }
                        NavigationLink("Reading Stats") {
                            ReadingStatsView()
                        }
                    }
                    
                    Section(header: Text("Subscription Tier")) {
                        Picker("Tier", selection: $subscriptionTier) {
                            Text("Free").tag("Free")
                            Text("Premium").tag("Premium")
                            Text("VIP").tag("VIP")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Button("Purchase / Update Subscription") {
                            // placeholder
                        }
                    }
                    
                    Section(header: Text("Account Management")) {
                        Button("Update Account") {
                            // placeholder
                        }
                        Button("Logout") {}
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Profile & Settings", displayMode: .inline)
        }
    }
}

// MARK: - Tutorial & Reading Stats

struct TutorialView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Tutorial & Help")
                    .font(.largeTitle.bold())
                Text("""
                1. “Beowulf” pinned chat adventure with 3 branching choices.
                2. “Write Your Own Story” includes random prompt & advanced fields.
                3. Library tracks reading progress (progress bar) + “Mark as Completed.”
                4. Profile page is placeholder for email/password/subscription logic.
                5. Marketplace references public domain expansions.
                6. Wave shapes, hidden nav bar on Home, etc.
                """)
                .font(.body)
            }
            .padding()
        }
        .navigationBarTitle("Tutorial / Help", displayMode: .inline)
    }
}

struct ReadingStatsView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Reading Stats")
                .font(.largeTitle.bold())
            Text("Coming Soon: track completed stories, achievements, daily reading streak, etc.")
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
        .navigationBarTitle("Reading Stats", displayMode: .inline)
    }
}
