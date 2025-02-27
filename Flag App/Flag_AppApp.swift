//
//  Flag_AppApp.swift
//  Flag App
//
//  Created by Paul Jordan on 2/26/25.
//

import SwiftUI

@main
struct Flag_AppApp: App {
    @State private var timerObject = TimerObject(timerColor: .indigo, length: 180)
    
    var body: some Scene {
        WindowGroup {
            NewFlagView()
                .environment(timerObject)
        }
    }
}
