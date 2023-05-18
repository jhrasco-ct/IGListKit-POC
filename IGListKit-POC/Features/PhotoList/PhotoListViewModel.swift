//
//  PhotoListViewModel.swift
//  IGListKit-POC
//
//  Created by John Harold Rasco on 5/10/23.
//

import Foundation
import IGListKit

protocol PhotoListViewModelType {
  // Properties
  var navigationTitle: String { get }
  var albums: [Album] { get }
  var selectedAlbum: Album? { get }
  var selectedAlbumIndex: Int? { get }
  var selectedPhotoIndex: Int? { get }

  // Callbacks
  var onSelectAlbum: (() -> Void)? { get set }
  var onSelectPhoto: (() -> Void)? { get set }

  // Methods
  func selectAlbum(at index: Int)
  func selectPhoto(at index: Int)
  func deleteSelectedPhoto()
}

class PhotoListViewModel: PhotoListViewModelType {
  init() {
    loadAlbums()
  }

  private let identifier: String = UUID().uuidString

  var albums = [Album]()
  var selectedAlbumIndex: Int?
  var selectedPhotoIndex: Int?

  var onSelectAlbum: (() -> Void)?
  var onSelectPhoto: (() -> Void)?

  var navigationTitle: String {
    "Photos"
  }

  var selectedAlbum: Album? {
    guard let selectedAlbumIndex else { return nil }
    return albums[selectedAlbumIndex]
  }

  func selectAlbum(at index: Int) {
    selectedAlbumIndex = index
    onSelectAlbum?()
  }

  func selectPhoto(at index: Int) {
    selectedPhotoIndex = index
    onSelectPhoto?()
  }

  func deleteSelectedPhoto() {
    guard let selectedAlbumIndex, let selectedPhotoIndex else { return }
    albums[selectedAlbumIndex].photos.remove(at: selectedPhotoIndex)
    self.selectedPhotoIndex = nil
  }

  // MARK: - Private

  private func loadAlbums() {
    albums = Album.dummies()
    selectedAlbumIndex = albums.isEmpty ? nil : 0
  }
}

extension PhotoListViewModel: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    return identifier as NSString
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let object = object as? PhotoListViewModel else {
      return false
    }
    return self.identifier == object.identifier
  }
}
