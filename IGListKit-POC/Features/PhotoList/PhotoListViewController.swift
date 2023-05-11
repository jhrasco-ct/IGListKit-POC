//
//  PhotoListViewController.swift
//  IGListKit-POC
//
//  Created by John Harold Rasco on 5/10/23.
//

import UIKit

class PhotoListViewController: UIViewController {
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

  // MARK: - Private

  private var customView: PhotoListView {
    view as! PhotoListView
  }

  private var viewModel: PhotoListViewModelType!

  private func setUpViews() {
    customView.albumCollectionView.dataSource = self
    customView.albumCollectionView.delegate = self
    customView.photoCollectionView.dataSource = self
    customView.photoCollectionView.delegate = self
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
  }
}

// MARK: - UICollectionViewDataSource

extension PhotoListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // Album
    if collectionView == customView.albumCollectionView {
      return viewModel.albums.count
    }
    // Photos
    if collectionView == customView.photoCollectionView {
      return viewModel.selectedAlbum?.photos.count ?? 0
    }
    return 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // Album
    if collectionView == customView.albumCollectionView {
      let album = viewModel.albums[indexPath.item]
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionCell.reuseIdentifier, for: indexPath) as! AlbumCollectionCell
      cell.title = album.title
      return cell
    }
    // Photos
    if collectionView == customView.photoCollectionView {
      let photo = viewModel.selectedAlbum?.photos[indexPath.item]
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionCell.reuseIdentifier, for: indexPath) as! PhotoCollectionCell
      cell.imageURL = photo?.imageURL
      return cell
    }
    return UICollectionViewCell()
  }
}

// MARK: - UICollectionViewDelegate

extension PhotoListViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // Album
    if collectionView == customView.albumCollectionView {
      viewModel.selectAlbum(at: indexPath.item)
    }
    // Photos
    if collectionView == customView.photoCollectionView {
      viewModel.selectPhoto(at: indexPath.item)
    }
  }
}
