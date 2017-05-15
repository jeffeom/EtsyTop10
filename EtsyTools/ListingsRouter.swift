//
//  ListingsRouter.swift
//  EtsyTools
//
//  Created by Jeff Eom on 2017-05-14.
//  Copyright © 2017 Jeff Eom. All rights reserved.
//

import Alamofire

enum ListingsRouter: URLRequestConvertible {
  case getItems()
  case getPhotoFromItem(id: Int)
  
  func asURLRequest() throws -> URLRequest {
    var method: HTTPMethod {
      switch self {
      case .getItems, .getPhotoFromItem:
        return .get
      }
    }
    
    var url: URL {
      let relativePath: String
      switch self {
      case .getItems():
        relativePath = "listings/active"
      case .getPhotoFromItem(let id):
        relativePath = "listings/\(id)/images"
      }
      let url = URL(string: EtsyApiManager.etsyBaseURLString + relativePath + EtsyApiManager.etsyParamURLString)!
      return url
    }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    
    return try JSONEncoding.default.encode(urlRequest, with: nil)
  }
}
