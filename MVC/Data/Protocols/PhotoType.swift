//
//  PlaceholderProtocol.swift
//  MoyaTest
//
//  Created by belga on 14/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import Foundation


protocol PhotoType  {
  var id: Int { get }
  var albumId: Int { get }
  var title: String? { get }
  var url: String? { get }
  var thumbnailUrl: String? { get }
  var date : Date? { get }
  
}

