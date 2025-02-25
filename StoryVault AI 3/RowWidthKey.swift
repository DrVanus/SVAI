//
//  RowWidthKey.swift
//  StoryVault AI 2
//
//  Created by DM on 2/24/25.
//

import SwiftUI

// MARK: - Preference Key for geometryRow

struct RowWidthKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        let next = nextValue()
        if next > value { value = next }
    }
}
