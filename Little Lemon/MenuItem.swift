//
//  MenuItem.swift
//  Little Lemon
//
//  Created by Stephen Sneed on 12/3/25.
//

import Foundation

struct MenuItem: Decodable {
    var title: String
    var image: String
    var price: String
    var category: String
    var description: String
}
