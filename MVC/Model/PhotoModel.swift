//
//  PhotoService.swift
//  MoyaTest
//
//  Created by belga on 15/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import Foundation
import Moya

class PhotoModel: PhotoModelType {
  
  var  provider = MoyaProvider<PhotoTarget>()
  
  func listPhotos(_ success:@escaping (_ result: [PhotoType]) -> Void,
                  fail:@escaping (_ error: Swift.Error ) -> Void  )  {
    provider.request(.listPhotos) { result in
      // do something with the result (read on for more details)
      switch result {
      case let .success(moyaResponse):
        let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
        if statusCode == 200 {
          do {
            //            try moyaResponse.filterSuccessfulStatusCodes()
            let json = try moyaResponse.mapJSON()
            let photos = self.parsePhotos(with: json)
            success(photos)
          } catch let error as MoyaError{
            fail(error)
          } catch {
            print("Something went wrong")
          }
        } else {
          
          fail(NSError(domain: "es.gfi", code: statusCode,  userInfo: [NSLocalizedDescriptionKey: moyaResponse.debugDescription] ))
        }
      // do something in your app
      case let .failure(error):
        fail(error)
      }
    }
  }
  
  
  func getPhoto(id:Int,
                success:@escaping (_ result: PhotoType) -> Void,
                fail:@escaping (_ error: Swift.Error ) -> Void  ){
    provider.request(.getPhoto(id: id)) { result in
      switch result {
      case let .success(moyaResponse):
        let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
        if statusCode == 200 {
          do {
            //            try moyaResponse.filterSuccessfulStatusCodes()
            let json = try moyaResponse.mapJSON()
            if let photos = self.parsePhoto(with: json) {
              success(photos)
            } else {
              fail(NSError(domain: "es.gfi", code: 1,  userInfo: [NSLocalizedDescriptionKey: "JSON Parse error"]))
            }
          } catch let error as MoyaError{
            fail(error)
          } catch {
            print("Something went wrong")
          }
        } else {
          
          fail(NSError(domain: "es.gfi", code: statusCode,  userInfo: [NSLocalizedDescriptionKey: moyaResponse.debugDescription] ))
        }
      // do something in your app
      case let .failure(error):
        fail(error)
      }
    }
  }
  
  private func parsePhotos(with json:Any) -> [PhotoType] {
    var result = [PhotoType]()
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    
    if let array = json as? [Any] {
      // access all objects in array
      for object in array {
        if let photo = self.parsePhoto(with: object ) {
          result.append(photo)
        }
      }
    }
    return result
  }
  
  private func parsePhoto(with json:Any) -> PhotoType? {
    var result : Photo?
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    
    if let object = json as? [String:Any] {
      // access all objects in array
      if let id = object["id"] as? Int,
        let albumId = object["albumId"] as? Int,
        let title = object["title"] as? String,
        let url = object["url"] as? String,
        let thumbnailUrl = object["thumbnailUrl"] as? String,
        let dateStr = object["date"] as? String,
        let date = formatter.date(from: dateStr){
        result = Photo(id: id,albumId: albumId, title: title, url: url, thumbnailUrl: thumbnailUrl, date: date)
      }
    }
    return result
  }
  
}
