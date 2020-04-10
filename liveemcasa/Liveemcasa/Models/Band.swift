//
//  Band.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 04/04/20.
//  Copyright © 2020 Daniel Maia dos Passos. All rights reserved.
//
 
struct Band: Decodable {
  var id: Int = 0
  var name: String = ""
  var bucketFile: BucketFile
}

struct BucketFile: Decodable {
  let id: Int
  var preSignedUrl: String = ""
}
