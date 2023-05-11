//
//  PhotoListView.swift
//  IGListKit-POC
//
//  Created by John Harold Rasco on 5/10/23.
//

import UIKit

class PhotoListView: UIView {
  // MARK: - Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpViews()
  }

  required init() {
    super.init(frame: .zero)
    setUpViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Internal

  lazy var albumCollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: albumCollectionViewFlowLayout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.alwaysBounceHorizontal = true
    collectionView.showsHorizontalScrollIndicator = false
    return collectionView
  }()

  let albumCollectionViewFlowLayout = {
    let collectionViewLayout = UICollectionViewFlowLayout()
    collectionViewLayout.scrollDirection = .horizontal
    collectionViewLayout.sectionInset = .init(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
    collectionViewLayout.minimumLineSpacing = 8.0
    collectionViewLayout.itemSize = .init(width: 80.0, height: 80.0)
    return collectionViewLayout
  }()

  lazy var photoCollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: photoCollectionViewFlowLayout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.alwaysBounceVertical = true
    collectionView.showsVerticalScrollIndicator = false
    return collectionView
  }()

  let photoCollectionViewFlowLayout = {
    let collectionViewLayout = UICollectionViewFlowLayout()
    collectionViewLayout.scrollDirection = .vertical
    collectionViewLayout.sectionInset = .zero
    collectionViewLayout.minimumInteritemSpacing = 2.0
    collectionViewLayout.minimumLineSpacing = 2.0

    let itemPerRow = 3

    let availableWidth = (
      UIScreen.main.bounds.width
      - collectionViewLayout.sectionInset.left
      - collectionViewLayout.sectionInset.right
      - (collectionViewLayout.minimumInteritemSpacing * (CGFloat(itemPerRow) - 1.0))
    )

    let itemWidth = availableWidth / CGFloat(itemPerRow)
    collectionViewLayout.itemSize = .init(width: itemWidth, height: itemWidth)
    return collectionViewLayout
  }()


  // MARK: - Private

  private let borderView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .systemGray5
    return view
  }()

  private func setUpViews() {
    backgroundColor = .white
    setUpAlbumCollectionView()
    setUpBorderView()
    setUpPhotoCollectionView()
  }

  private func setUpBorderView() {
    addSubview(borderView)

    NSLayoutConstraint.activate([
      borderView.topAnchor.constraint(equalTo: albumCollectionView.bottomAnchor),
      borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
      borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
      borderView.heightAnchor.constraint(equalToConstant: 1.0)
    ])
  }

  private func setUpAlbumCollectionView() {
    addSubview(albumCollectionView)

    let albumCollectionViewHeight = (
      albumCollectionViewFlowLayout.itemSize.height
      + albumCollectionViewFlowLayout.sectionInset.top
      + albumCollectionViewFlowLayout.sectionInset.bottom
    )

    NSLayoutConstraint.activate([
      albumCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      albumCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      albumCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      albumCollectionView.heightAnchor.constraint(equalToConstant: albumCollectionViewHeight)
    ])
  }

  private func setUpPhotoCollectionView() {
    addSubview(photoCollectionView)

    NSLayoutConstraint.activate([
      photoCollectionView.topAnchor.constraint(equalTo: borderView.bottomAnchor),
      photoCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      photoCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      photoCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
