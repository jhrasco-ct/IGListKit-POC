//
//  Photo.swift
//  IGListKit-POC
//
//  Created by John Harold Rasco on 5/10/23.
//

import IGListKit

class Photo {
//  private let identifier: String = UUID().uuidString

  var imageURL: URL

  init(imageURL: URL) {
    self.imageURL = imageURL
  }
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

//extension Photo: ListDiffable {
//  func diffIdentifier() -> NSObjectProtocol {
//    return identifier as NSString
//  }
//
//  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
//    guard let object = object as? Photo else {
//      return false
//    }
//    return self.identifier == object.identifier
//  }
//}
