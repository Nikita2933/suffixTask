//
//  suffixTaskApp.swift
//  suffixTask
//
//  Created by Никита Иванов on 19.06.2022.
//

import SwiftUI

@main
struct suffixTaskApp: App {
    @State var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(viewModel)
        }
    }
}
