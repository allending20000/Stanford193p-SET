//
//  Set_GameApp.swift
//  Set Game
//
//  Created by Allen Ding on 3/22/21.
//

import SwiftUI

@main
struct Set_GameApp: App {
    var body: some Scene {
        WindowGroup {
            SetGameView(viewModel: SetGameVM())
        }
    }
}
