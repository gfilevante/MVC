//
//  Placeholder.swift
//  MoyaTest
//
//  Created by belga on 14/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import Foundation

struct Photo : PhotoType {
  let id: Int
  let albumId: Int
  let title: String?
  let url: String?
  let thumbnailUrl: String?
  let date : Date?
  
  init(id: Int, albumId: Int, title: String?, url: String?, thumbnailUrl: String?, date: Date?)
  {
    self.id = id
    self.albumId = albumId
    self.title = title
    self.url = url
    self.thumbnailUrl = thumbnailUrl
    self.date = date
  }
  
}
