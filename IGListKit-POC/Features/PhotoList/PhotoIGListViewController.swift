//
//  PhotoIGListViewController.swift
//  IGListKit-POC
//
//  Created by Monty Carlo Pineda on 5/17/23.
//

import IGListKit
import UIKit

class PhotoIGListViewController: UIViewController {
  private lazy var albumAdapter: ListAdapter = {
    return ListAdapter(
      updater: ListAdapterUpdater(),
      viewController: self,
      workingRangeSize: 0)
  }()

  private lazy var photoAdapter: ListAdapter = {
    return ListAdapter(
      updater: ListAdapterUpdater(),
      viewController: self,
      workingRangeSize: 0)
  }()

  private var customView: PhotoListView {
    view as! PhotoListView
  }

  private var viewModel: PhotoListViewModelType!

  init(viewModel: PhotoListViewModelType) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    view = PhotoListView()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setUpViews()
    registerCells()
    bindViewModel()
  }

  private func setUpViews() {
    albumAdapter.collectionView = customView.albumCollectionView
    albumAdapter.dataSource = self

    photoAdapter.collectionView = customView.photoCollectionView
    photoAdapter.dataSource = self
  }

  private func registerCells() {
    customView.albumCollectionView.register(AlbumCollectionCell.self, forCellWithReuseIdentifier: AlbumCollectionCell.reuseIdentifier)
    customView.photoCollectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: PhotoCollectionCell.reuseIdentifier)
  }

  private func bindViewModel() {
    navigationItem.title = viewModel.navigationTitle

    if let selectedAlbumIndex = viewModel.selectedAlbumIndex {
      customView.albumCollectionView.selectItem(
        at: IndexPath(item: selectedAlbumIndex, section: 0),
        animated: false,
        scrollPosition: [])
    }

    viewModel.onSelectAlbum = { [weak self] in
      self?.customView.photoCollectionView.reloadData()
      self?.customView.photoCollectionView.setContentOffset(.zero, animated: false) // scroll to top
    }

    viewModel.onSelectPhoto = { [weak self] in
      self?.showDeleteConfirmationAlert()
    }
  }

  private func showDeleteConfirmationAlert() {
    let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

    let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
      self?.deleteSelectedPhoto()
    }

    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

    controller.addAction(deleteAction)
    controller.addAction(cancelAction)

    present(controller, animated: true)
  }

  private func deleteSelectedPhoto() {
    guard let selectedPhotoIndex = viewModel.selectedPhotoIndex else { return }
    customView.photoCollectionView.performBatchUpdates { [weak self] in
      self?.viewModel.deleteSelectedPhoto()
      customView.photoCollectionView.deleteItems(at: [IndexPath(item: selectedPhotoIndex, section: 0)])
    }

//    viewModel.deleteSelectedPhoto()
//    photoAdapter.performUpdates(animated: true)
  }
}

extension PhotoIGListViewController: ListAdapterDataSource {
  func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
    if listAdapter.collectionView == customView.albumCollectionView {
      return [viewModel] as! [ListDiffable]
    }

    if listAdapter.collectionView == customView.photoCollectionView {
      return [viewModel] as! [ListDiffable]
    }

    return []
  }

  func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
    if listAdapter.collectionView == customView.albumCollectionView {
      return AlbumListSectionController()
    }

    if listAdapter.collectionView == customView.photoCollectionView {
      return PhotoListSectionController()
    }

    return ListSectionController()
  }

  func emptyView(for listAdapter: ListAdapter) -> UIView? {
    return nil
  }
}
