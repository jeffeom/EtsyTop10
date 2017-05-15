//
//  CurrencyRouter.swift
//  EtsyTools
//
//  Created by Jeff Eom on 2017-05-14.
//  Copyright © 2017 Jeff Eom. All rights reserved.
//

import Foundation

import Alamofire

enum CurrencyRouter: URLRequestConvertible {
  case getCurrency()
  
  func asURLRequest() throws -> URLRequest {
    var method: HTTPMethod {
      switch self {
      case .getCurrency:
        return .get
      }
    }
    
    var url: URL {
      let url = URL(string: EtsyApiManager.currencyBaseURLString + EtsyApiManager.currencyParamURLString)!
      return url
    }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    
    return try JSONEncoding.default.encode(urlRequest, with: nil)
  }
}
