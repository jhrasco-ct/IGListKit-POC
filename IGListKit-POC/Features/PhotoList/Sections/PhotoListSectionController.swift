//
//  PhotoListSectionController.swift
//  IGListKit-POC
//
//  Created by Monty Carlo Pineda on 5/17/23.
//

import IGListKit

class PhotoListSectionController: ListSectionController {
  var viewModel: PhotoListViewModel!

  override init() {
    super.init()
    minimumInteritemSpacing = 2.0
    minimumLineSpacing = 2.0
  }

  override func numberOfItems() -> Int {
    return viewModel.selectedAlbum?.photos.count ?? 0
  }

  override func sizeForItem(at index: Int) -> CGSize {
    guard let width = collectionContext?.containerSize.width else { return .zero }

    let itemPerRow = 3
    let availableWidth = width - (minimumInteritemSpacing * CGFloat(itemPerRow)) - 1.0
    let itemWidth = availableWidth / CGFloat(itemPerRow)
    return .init(width: itemWidth, height: itemWidth)
  }

  override func cellForItem(at index: Int) -> UICollectionViewCell {
    let cell = collectionContext!.dequeueReusableCell(of: PhotoCollectionCell.self, for: self, at: index) as! PhotoCollectionCell
    cell.imageURL = viewModel.selectedAlbum?.photos[index].imageURL
    return cell
  }

  override func didUpdate(to object: Any) {
    viewModel = object as? PhotoListViewModel
  }

  override func didSelectItem(at index: Int) {
    viewModel.selectPhoto(at: index)
  }
}

