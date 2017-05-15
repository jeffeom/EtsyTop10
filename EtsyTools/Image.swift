//
//  Image.swift
//  EtsyTools
//
//  Created by Jeff Eom on 2017-05-14.
//  Copyright © 2017 Jeff Eom. All rights reserved.
//

import SwiftyJSON

public struct Image {
  
  public let imageURL: String
  
  init(json: JSON) {
    imageURL = json["url_fullxfull"].stringValue
  }
}
