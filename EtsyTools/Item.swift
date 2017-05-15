//
//  Item.swift
//  EtsyTools
//
//  Created by Jeff Eom on 2017-05-14.
//  Copyright © 2017 Jeff Eom. All rights reserved.
//

import SwiftyJSON

public struct Item {
  
  public let listingId: Int
  public let title: String
  public let quantity: Int
  public let price: Double
  public let currency: String
  
  init(json: JSON) {
    listingId = json["listing_id"].intValue
    title = json["title"].stringValue
    quantity = json["quantity"].intValue
    price = json["price"].doubleValue
    currency = json["currency_code"].stringValue
  }
}
