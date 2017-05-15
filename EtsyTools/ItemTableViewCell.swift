//
//  ItemTableViewCell.swift
//  EtsyTools
//
//  Created by Jeff Eom on 2017-05-14.
//  Copyright © 2017 Jeff Eom. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
  static let reuseIdentifier = "\(ItemTableViewCell.self)"
  
  @IBOutlet var itemImage: UIImageView!
  @IBOutlet var itemTitle: UILabel!
  @IBOutlet var itemPrice: UILabel!
}
