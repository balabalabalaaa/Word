//
//  WordAppApp.swift
//  WordApp
//
//  Created by 赵静怡 on 2024/9/20.
//

import SwiftUI

@main
struct WordAppApp: App {
    @StateObject private var wordDataManager = WordDataManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(wordDataManager)
        }
    }
}
