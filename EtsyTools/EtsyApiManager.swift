//
//  EtsyApiManager.swift
//  EtsyTools
//
//  Created by Jeff Eom on 2017-05-14.
//  Copyright © 2017 Jeff Eom. All rights reserved.
//

import Alamofire
import SwiftyJSON

public enum Result<T> {
  case success(T)
  case failure(reason: String)
}

public final class EtsyApiManager {
  enum APIError: Error {
    case noInternet
  }
  
  static let etsyBaseURLString = "https://openapi.etsy.com/v2/"
  static let etsyParamURLString = "?api_key=z2bl38vl0caesjs6bv54xuag&limit=10"
  static let currencyBaseURLString = "http://www.apilayer.net/api/live"
  static let currencyParamURLString = "?access_key=3cc439ac3c00d74842de5f22193b6408&currencies=GBP,CAD,USD,EUR"
  static public let shared = EtsyApiManager()
}

// MARK: - ListingsRouter
public extension EtsyApiManager {
  func getItems(completion: @escaping (Result<[Item]>) -> ()) {
    Alamofire.request(ListingsRouter.getItems()).responseJSON { response in
      guard let response = response.result.value else { return completion(.failure(reason: "Unable to connect to the server.")) }
      
      let json = JSON(response)
      if let errorMessage = json["error"].string {
        completion(.failure(reason: errorMessage))
      } else {
        let items = json["results"].arrayValue.map(Item.init)
        completion(.success(items))
      }
    }
  }
  
  func getPhotoFromItem(withId id: Int, completion: @escaping (Result<[Image]>) -> ()) {
    Alamofire.request(ListingsRouter.getPhotoFromItem(id: id)).responseJSON { response in
      guard let response = response.result.value else { return completion(.failure(reason: "Unable to connect to the server.")) }
      
      let json = JSON(response)
      if let errorMessage = json["error"].string {
        completion(.failure(reason: errorMessage))
      }else {
        let images = json["results"].arrayValue.map(Image.init)
        completion(.success(images))
      }
    }
  }
}

// MARK: - CurrencyRouter
public extension EtsyApiManager {
  func getCurrency(completion: @escaping (Result<Currency>) -> ()) {
    Alamofire.request(CurrencyRouter.getCurrency()).responseJSON { response in
      guard let response = response.result.value else { return completion(.failure(reason: "Unable to connect to the server.")) }
      
      let json = JSON(response)
      if json["error"].string != nil {
      }else {
        let currencies = Currency(json: JSON(json["quotes"].dictionaryValue))
        completion(.success(currencies))
      }
    }
  }
}
