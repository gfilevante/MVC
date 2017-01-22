//
//  PhotoTargetSpec.swift
//  MoyaTest
//
//  Created by belga on 15/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import Quick
import Nimble
import Moya

@testable import MVC

class PhotoModelSpec: QuickSpec {
  override func spec() {
    
    
    describe("with correct data") {
      var service: PhotoModel!
      beforeEach({
        let testProvider = MoyaProvider<PhotoTarget>(stubClosure: MoyaProvider.immediatelyStub)
        service = PhotoModel()
        service.provider = testProvider
      })
      it("listPhotos returns a list of photos") {
        var errored = false
        var photos : [PhotoType] = []
        waitUntil(action: { done in
          service.listPhotos({ result in
            photos = result
            done()
          }, fail: { error in
            errored = true
            done()
          })
        })
        expect(photos.count).to(equal(100))
        expect(errored).to(beFalse())
      }
    }
    
    describe("with errors") {
      var service: PhotoModel!
      beforeEach({
        let failureEndpointClosure = { (target: PhotoTarget) -> Endpoint<PhotoTarget> in
          let url = target.baseURL.appendingPathComponent(target.path).absoluteString
          let error = NSError(domain: "com.moya.moyaerror", code: 0, userInfo: [NSLocalizedDescriptionKey: "Houston, we have a problem"])
          return Endpoint<PhotoTarget>(url: url, sampleResponseClosure: {.networkError(error)}, method: target.method, parameters: target.parameters)
        }
        let testProvider = MoyaProvider<PhotoTarget>(endpointClosure:failureEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        service = PhotoModel()
        service.provider = testProvider
      })
      it("listPhotos returns an error") {
        var errored = false
        var photos : [PhotoType] = []
        waitUntil(action: { done in
          service.listPhotos({ result in
            photos = result
            done()
          }, fail: { error in
            errored = true
            done()
          })
        })
        expect(errored).to(beTrue())
        expect(photos).to(beEmpty())
      }
    }
    describe("with server error") {
      var service: PhotoModel!
      beforeEach({
        let failureEndpointClosure = { (target: PhotoTarget) -> Endpoint<PhotoTarget> in
          let url = target.baseURL.appendingPathComponent(target.path).absoluteString
          return Endpoint<PhotoTarget>(url: url, sampleResponseClosure: {.networkResponse(500, Data())}, method: target.method, parameters: target.parameters)
        }
        let testProvider = MoyaProvider<PhotoTarget>(endpointClosure:failureEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        service = PhotoModel()
        service.provider = testProvider
      })
      it("listPhotos returns an error") {
        var errored = false
        var photos : [PhotoType] = []
        waitUntil(action: { done in
          service.listPhotos({ result in
            photos = result
            done()
          }, fail: { error in
            errored = true
            done()
          })
        })
        expect(errored).to(beTrue())
        expect(photos).to(beEmpty())
      }
    }
  }
}
