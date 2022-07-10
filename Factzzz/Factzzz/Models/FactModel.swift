//
//  FactModel.swift
//  Factzzz
//
//  Created by Luke Hendriks on 10/07/2022.
//

import Foundation

struct FactModel: Identifiable, Codable, Hashable {
    var id: UUID
    var text: String
}
