//
//  MainViewController.swift
//  IGListKit-POC
//
//  Created by Monty Carlo Pineda on 5/16/23.
//

import UIKit

class MainViewController: UIViewController {
  private lazy var uiKitButton: UIButton = {
    let view = UIButton(type: .system, primaryAction: UIAction(title: "UIKit", handler: { _ in
      self.navigationController?.pushViewController(PhotoListViewController(viewModel: PhotoListViewModel()), animated: true)
    }))
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var igListKitButton: UIButton = {
    let view = UIButton(type: .system, primaryAction: UIAction(title: "IGListKit", handler: { _ in
      self.navigationController?.pushViewController(PhotoIGListViewController(viewModel: PhotoListViewModel()), animated: true)
    }))
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private func setupViews() {
    view.backgroundColor = .white
    view.addSubview(uiKitButton)
    view.addSubview(igListKitButton)

    NSLayoutConstraint.activate([
      uiKitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      uiKitButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30.0),
      igListKitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      igListKitButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30.0)
    ])
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
}
