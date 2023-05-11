//
//  Photo.swift
//  IGListKit-POC
//
//  Created by John Harold Rasco on 5/10/23.
//

import Foundation

struct Photo {
  var imageURL: URL
}

extension Photo {
  static func dummy() -> Photo {
    let seed = Int.random(in: 1...200)
    let urlString = "https://picsum.photos/seed/\(seed)/200/200"
    return .init(imageURL: URL(string: urlString)!)
  }

  static func dummies(count: Int) -> [Photo] {
    var photos = [Photo]()
    for _ in 0..<count {
      photos.append(.dummy())
    }
    return photos
  }
}
