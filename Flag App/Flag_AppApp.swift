//
//  Flag_AppApp.swift
//  Flag App
//
//  Created by Pete Nealley on 1/3/25.
//

import SwiftUI

@main

struct Flag_AppApp: App {
    @State private var timerObject = TimerObject(timerColor: .indigo, length: 10)
    var body: some Scene {
        WindowGroup {
            NewFlagView()
                .environment(timerObject)
        }
    }
}
