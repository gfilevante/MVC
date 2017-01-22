//
//  PhotoModel.swift
//  MVVM
//
//  Created by belga on 18/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import Foundation
import Moya


protocol PhotoModelType {
  
  var  provider : MoyaProvider<PhotoTarget> { get set }
  
  func listPhotos(_ success:@escaping (_ result: [PhotoType]) -> Void, fail:@escaping (_ error: Swift.Error ) -> Void  )
  
  func getPhoto(id:Int,
                success:@escaping (_ result: PhotoType) -> Void,
                fail:@escaping (_ error: Swift.Error ) -> Void  )
}
