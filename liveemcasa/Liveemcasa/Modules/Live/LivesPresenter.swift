//
//  LivesPresenter.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 04/04/20.
//  Copyright (c) 2020 Daniel Maia dos Passos. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class LivesPresenter {
  
  // MARK: - Private properties -
  
  private weak var view: LivesViewInterface?
  private let interactor: LivesInteractor
  private let wireframe: LivesWireframe!
  
  private var list = [Live]()
  static let cellIdentifier = "LivesCollectionViewCell"
  
  private enum Strings {
    static let title = "Lives"
  }
  
  // MARK: - Lifecycle -
  
  init(view: LivesViewInterface,
       interactor: LivesInteractor,
       wireframe: LivesWireframe) {
    self.view = view
    self.interactor = interactor
    self.wireframe = wireframe
    
    self.interactor.response = self
  }
  
  // MARK: - Private Functions
  private func bindLives(lives: [Live]) {
    list = lives
    view?.showProgress(show: false)
    view?.updateTableView()
  }
}

// MARK: - Extensions -

extension LivesPresenter: LivesPresenterInterface {
  
  func getTitle() -> UIImageView {
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
    imageView.contentMode = .scaleAspectFit
    let image = UIImage(named: "icon_app_transparent")
    imageView.image = image
    return imageView
  }
  
  func callService(showProgress: Bool) {
    if showProgress {
      view?.showProgress(show: true)
    }
    
    networking.check()
  }
  
  func numberOfItems() -> Int {
    return  list.count
  }
  
  func cell(for collectionView: UICollectionView, at index: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LivesCollectionViewCell.identifier, for: index) as? LivesCollectionViewCell
   
    cell?.configureCell(live: list[index.row])
    
    return cell ?? UICollectionViewCell()
  }
  
  func didSelectItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) {
    self.wireframe.navigate(to: .openUrlLive(urlLive: self.list[indexPath.row].link))
  }
}

extension LivesPresenter: NetworkingInteractorResponse {
  func networkingAvailable() {
    self.interactor.getLives()
  }

  func networkingNotAvailable() {
    self.wireframe.navigate(to: .showConnectionErrorAlert)
  }
}

extension LivesPresenter: GetLivesInteractorProtocol {
  func getLivesSuccess(success: [Live]) {
    DispatchQueue.main.async {
      self.bindLives(lives: success)
    }
  }
  
  func getLivesError(error: Error) {
    DispatchQueue.main.async {
      self.view?.showPlaceholderScreenError()
    }
  }
}

