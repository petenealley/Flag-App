//
//  View+readSize.swift
//  Flag App
//
//  Created by Paul Jordan on 2/26/25.
//


import SwiftUI

// Extend View to add the readSize modifier
extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        self
            .background(
                GeometryReader { geometryProxy in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
                }
            )
            .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}
