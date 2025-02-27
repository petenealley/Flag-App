//
//  Country.swift
//  Flag App
//
//  Created by Paul Jordan on 2/26/25.
//


import Foundation

struct Country: Identifiable, Equatable {
    let code: String
    var id: String { code }
    var name: String {
        Locale.current.localizedString(forRegionCode: code) ?? ""
    }
    var flag: String {
        String(String.UnicodeScalarView(code.unicodeScalars.compactMap {
            UnicodeScalar(127397 + $0.value)
        }))
    }
}
