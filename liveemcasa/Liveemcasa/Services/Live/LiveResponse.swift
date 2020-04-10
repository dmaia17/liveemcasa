//
//  LiveResponse.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 05/04/20.
//  Copyright © 2020 Daniel Maia dos Passos. All rights reserved.
//

import Foundation
//import Mapper

struct LiveResponse: Decodable {
    let lives: [Live]

    /* init(map: Mapper) throws {
      try lives = map.from("lives")
    } */
}
