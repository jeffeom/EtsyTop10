//
//  Currency.swift
//  EtsyTools
//
//  Created by Jeff Eom on 2017-05-15.
//  Copyright © 2017 Jeff Eom. All rights reserved.
//

import SwiftyJSON

public struct Currency {
  
  public let gbp: Double
  public let cad: Double
  public let usd: Double
  public let eur: Double
  
  init(json: JSON) {
    gbp = json["USDGBP"].doubleValue
    cad = json["USDCAD"].doubleValue
    usd = json["USDUSD"].doubleValue
    eur = json["USDEUR"].doubleValue
  }
}

