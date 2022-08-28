//
//  ArtWork.swift
//  ArtBook
//
//  Created by Chris Hand on 8/28/22.
//

import Foundation

struct Artwork: Identifiable {
    var id: UUID
    var title: String
    var artist: String
    var year: Int
    var image: Data
}
