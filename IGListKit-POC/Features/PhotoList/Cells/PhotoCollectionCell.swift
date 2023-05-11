//
//  PhotoCollectionCell.swift
//  IGListKit-POC
//
//  Created by John Harold Rasco on 5/11/23.
//

import UIKit
import Kingfisher

class PhotoCollectionCell: UICollectionViewCell {
  static let reuseIdentifier = String(describing: PhotoCollectionCell.self)

  override init(frame: CGRect) {
    super.init(frame: frame)

    setUpViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override var isHighlighted: Bool {
    didSet {
      contentView.alpha = isHighlighted ? 0.3 : 1.0
    }
  }

  // MARK: - Internal

  let imageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  var imageURL: URL? {
    didSet {
      imageView.kf.setImage(with: imageURL)
    }
  }

  // MARK: - Private

  private func setUpViews() {
    backgroundColor = .systemGray6

    contentView.addSubview(imageView)

    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
}
