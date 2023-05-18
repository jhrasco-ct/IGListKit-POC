//
//  AlbumListSectionController.swift
//  IGListKit-POC
//
//  Created by Monty Carlo Pineda on 5/18/23.
//

import IGListKit

class AlbumListSectionController: ListSectionController {
  var viewModel: PhotoListViewModel!

  override init() {
    super.init()
    minimumLineSpacing = 8.0
    inset = .init(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
  }

  override func numberOfItems() -> Int {
    return viewModel.albums.count
  }

  override func sizeForItem(at index: Int) -> CGSize {
    return .init(width: 80.0, height: 80.0)
  }

  override func cellForItem(at index: Int) -> UICollectionViewCell {
    let cell = collectionContext!.dequeueReusableCell(of: AlbumCollectionCell.self, for: self, at: index) as! AlbumCollectionCell
    cell.title = viewModel.albums[index].title
    return cell
  }

  override func didUpdate(to object: Any) {
    viewModel = object as? PhotoListViewModel
  }

  override func didSelectItem(at index: Int) {
    viewModel.selectAlbum(at: index)
  }
}
