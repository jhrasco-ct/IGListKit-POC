//
//  Album.swift
//  IGListKit-POC
//
//  Created by John Harold Rasco on 5/10/23.
//

import Foundation

struct Album {
  var title: String
  var photos = [Photo]()
}

extension Album {
  static func dummies() -> [Album] {
    return [
      .init(title: "Album 1", photos: Photo.dummies(count: 25)),
      .init(title: "Album 2", photos: Photo.dummies(count: 25)),
      .init(title: "Album 3", photos: Photo.dummies(count: 25)),
      .init(title: "Album 4", photos: Photo.dummies(count: 25)),
      .init(title: "Album 5", photos: Photo.dummies(count: 25)),
      .init(title: "Album 6", photos: Photo.dummies(count: 25))
    ]
  }
}
