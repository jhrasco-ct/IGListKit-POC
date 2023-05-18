//
//  SceneDelegate.swift
//  IGListKit-POC
//
//  Created by John Harold Rasco on 5/10/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    setUpRootViewController(windowScene: windowScene)
  }

  private func setUpRootViewController(windowScene: UIWindowScene) {
    let photoListViewController = PhotoIGListViewController(viewModel: PhotoListViewModel())
    let navigationController = UINavigationController(rootViewController: photoListViewController)

    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = navigationController
    self.window = window
    window.makeKeyAndVisible()
  }
}
