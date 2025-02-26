//
//  ProfileView.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

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
                    }
                    
                    Section(header: Text("Subscription Tier")) {
                        Picker("Tier", selection: $subscriptionTier) {
                            Text("Free").tag("Free")
                            Text("Premium").tag("Premium")
                            Text("VIP").tag("VIP")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Button("Purchase / Update Subscription") {
                            // placeholder for future functionality
                        }
                    }
                    
                    Section(header: Text("Account Management")) {
                        Button("Update Account") {
                            // placeholder
                        }
                        Button("Logout") {
                            // placeholder
                        }
                        .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Profile & Settings", displayMode: .inline)
        }
    }
}
