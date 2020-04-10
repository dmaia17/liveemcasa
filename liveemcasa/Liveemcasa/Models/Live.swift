//
//  Live.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 04/04/20.
//  Copyright © 2020 Daniel Maia dos Passos. All rights reserved.
//
 
struct Live: Decodable {
  var id: Int = 0
  var name: String = ""
  var date: String = ""
  var description: String = ""
  var link: String = ""
  var socialMedia: String = ""
  var category: String = ""
  var bands: [Band] = []
}
