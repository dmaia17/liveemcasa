//
//  LivesInteractor.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 04/04/20.
//  Copyright (c) 2020 Daniel Maia dos Passos. All rights reserved.
//
//

import Foundation

protocol GetLivesInteractorProtocol {
  func getLivesSuccess(success: [Live])
  func getLivesError(error: Error)
}

final class LivesInteractor {
  
  // MARK: - Response Protocol
  var response: GetLivesInteractorProtocol?
  
  init() {}
  
  func getLives() {
    
    let url = URL(string: String(format: "%@%@", Constants.Strings.apiUrl, "/lives"))!
    let request = URLRequest(url: url)
    let session = URLSession.shared
    
    let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
      if let _ = error {
        self.response?.getLivesError(error: CustomErros.badResponse)
        return
      }
      guard let _ = response else {
        self.response?.getLivesError(error: CustomErros.badResponse)
        return
      }
      guard let data = data else {
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
        self.response?.getLivesError(error: CustomErros.badResponse)
        return
      }
      
      do {
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        print(json)
        let lives = try JSONDecoder().decode(LiveResponse.self, from: data)
        self.response?.getLivesSuccess(success: lives.lives)
      } catch {
        print("JSON error: \(error.localizedDescription)")
        self.response?.getLivesError(error: CustomErros.badResponse)
        return
      }
    })

    task.resume()
  }
}

// MARK: - Extensions -
extension LivesInteractor: LivesInteractorInterface {
}
