//
//  AlbumCollectionCell.swift
//  IGListKit-POC
//
//  Created by John Harold Rasco on 5/11/23.
//

import UIKit

class AlbumCollectionCell: UICollectionViewCell {
  static let reuseIdentifier = String(describing: AlbumCollectionCell.self)

  override init(frame: CGRect) {
    super.init(frame: frame)

    setUpViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override var isSelected: Bool {
    didSet {
      updateUI(isSelected: isSelected)
    }
  }

  // MARK: - Internal

  let titleLabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14.0, weight: .medium)
    label.textColor = .systemGray
    label.textAlignment = .center
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  var title: String? {
    didSet {
      titleLabel.text = title
    }
  }

  // MARK: - Private

  private func setUpViews() {
    contentView.layer.cornerRadius = 5.0
    contentView.layer.borderColor = UIColor.systemGray.cgColor
    contentView.layer.borderWidth = 1.0

    contentView.addSubview(titleLabel)

    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 4.0),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4.0),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4.0),
      titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -4.0),
      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])

    updateUI(isSelected: false)
  }

  private func updateUI(isSelected: Bool) {
    contentView.backgroundColor = isSelected ? .systemGray : .white
    titleLabel.textColor = isSelected ? .white : .systemGray
  }
}
