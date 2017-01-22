//
//  JSONPlaceholderService.swift
//  MoyaTest
//
//  Created by belga on 10/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import Foundation
import Moya

enum PhotoTarget {
  case listPhotos
  case getPhoto(id: Int)
}


extension PhotoTarget : TargetType {
  var baseURL: URL { return URL(string: "http://localhost:3000")! }
  var path: String {
    switch self {
    case .listPhotos:
      return "/photos"
    case .getPhoto(let id):
      return "/photos/\(id)"
    }
  }
  var method: Moya.Method {
    switch self {
    case .listPhotos, .getPhoto:
      return .get
    }
  }
  var parameters: [String: Any]? {
    switch self {
    case .listPhotos, .getPhoto:
      return nil
    }
  }
  
  var parameterEncoding: Moya.ParameterEncoding {
      return URLEncoding.default
  }
  
  var sampleData: Data {
    switch self {
    case .getPhoto(let id):
      return "{\"id\": \(id), \"albumId\": 1, \"title\": \"accusamus beatae ad facilis cum similique qui sunt\", \"url\": \"http://placehold.it/600/92c952\", \"thumbnailUrl\": \"http://placehold.it/150/30ac17\", \"date\":  \"2016-10-13T01:22:27.103Z\" }".utf8Encoded
    case .listPhotos:
      // Provided you have a file named accounts.json in your bundle.
      do {
        if let path = Bundle.main.path(forResource: "photos", ofType: "json") {
          let data =  try Data(contentsOf: URL(fileURLWithPath: path))
          return data
        }
      } catch  {}
      return Data()
    }
  }
  var task: Task {
    switch self {
    case .listPhotos, .getPhoto:
      return .request
    }
  }
}


// MARK: - Helpers
private extension String {
  var urlEscaped: String {
    return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
  }
  
  var utf8Encoded: Data {
    return self.data(using: .utf8)!
  }
}
