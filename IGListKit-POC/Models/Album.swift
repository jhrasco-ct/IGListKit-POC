//
//  Album.swift
//  IGListKit-POC
//
//  Created by John Harold Rasco on 5/10/23.
//

import IGListKit

class Album {
//  private let identifier: String = UUID().uuidString

  var title: String
  var photos = [Photo]()

  init(title: String, photos: [Photo] = [Photo]()) {
    self.title = title
    self.photos = photos
  }
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

//extension Album: ListDiffable {
//  func diffIdentifier() -> NSObjectProtocol {
//    return identifier as NSString
//  }
//
//  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
//    guard let object = object as? Album else {
//      return false
//    }
//    return self.identifier == object.identifier
//  }
//}
