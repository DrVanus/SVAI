//
//  SubscriptionView.swift
//  StoryVaultAI
//
//  Created by DM on 2/26/25.
//

import SwiftUI

struct SubscriptionView: View {
    @State private var selectedTier: String = "Free"
    
    var body: some View {
        ZStack {
            // Subtle background
            LinearGradient(
                gradient: Gradient(colors: [Color.gray.opacity(0.4), Color.black.opacity(0.8)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    Text("Choose Your Plan")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    // Tiers in a vertical list
                    VStack(spacing: 16) {
                        
                        // FREE TIER
                        subscriptionTierCard(
                            tierName: "Free",
                            price: "$0/mo",
                            features: [
                                "Basic Reading",
                                "Limited AI Interactions"
                            ],
                            isSelected: selectedTier == "Free"
                        )
                        .onTapGesture { selectedTier = "Free" }
                        
                        // PREMIUM TIER
                        subscriptionTierCard(
                            tierName: "Premium",
                            price: "$9.99/mo",
                            features: [
                                "Unlimited AI Interactions",
                                "AI-Generated Photos"
                            ],
                            isSelected: selectedTier == "Premium"
                        )
                        .onTapGesture { selectedTier = "Premium" }
                        
                        // VIP TIER
                        subscriptionTierCard(
                            tierName: "VIP",
                            price: "$19.99/mo",
                            features: [
                                "All Premium Features",
                                "AI Voices + Chat",
                                "Beta Access to New Features"
                            ],
                            isSelected: selectedTier == "VIP"
                        )
                        .onTapGesture { selectedTier = "VIP" }
                    }
                    .padding(.horizontal, 20)
                    
                    // Purchase / Select Button
                    Button(action: {
                        // Placeholder purchase logic
                        print("Attempting to purchase or select tier: \(selectedTier)")
                    }) {
                        if selectedTier == "Free" {
                            Text("Select Free")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(12)
                                .padding(.horizontal, 20)
                        } else {
                            Text("Subscribe to \(selectedTier)")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(12)
                                .padding(.horizontal, 20)
                        }
                    }
                    
                    Spacer().frame(height: 40)
                }
            }
        }
        .navigationBarTitle("Subscription", displayMode: .inline)
    }
    
    /// A helper view that displays a subscription tier card with features.
    @ViewBuilder
    private func subscriptionTierCard(
        tierName: String,
        price: String,
        features: [String],
        isSelected: Bool
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(tierName)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                Spacer()
                Text(price)
                    .foregroundColor(.white)
            }
            ForEach(features, id: \.self) { feature in
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text(feature)
                        .foregroundColor(.white.opacity(0.9))
                }
                .font(.subheadline)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(isSelected ? Color.purple.opacity(0.6) : Color.black.opacity(0.5))
        .cornerRadius(10)
    }
}

struct SubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionView()
    }
}
