//
//  ViewController.swift
//  EtsyTools
//
//  Created by Jeff Eom on 2017-05-14.
//  Copyright © 2017 Jeff Eom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  //MARK: - Properties & IBOutlets
  var myDict: [Int: String] = [:]
  var fetchedItems: [Int: Item] = [:]
  var fetchedCurrency: Currency?
  @IBOutlet var myTableView: UITableView!
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    getItems(completion: {
      for aItem in self.fetchedItems.values {
        self.getImage(with: aItem.listingId, completion: { result in
          self.myDict[aItem.listingId] = result.first!.imageURL
          self.myTableView.reloadData()
        })
      }
      self.getCurrency(completion: { result in
        self.fetchedCurrency = result
      })
    })
  }
}

// MARK: - API Calls
extension ViewController {
  func getItems(completion: @escaping () -> ()) {
    EtsyApiManager.shared.getItems(completion: { result in
      switch result {
      case .success(let items):
        for aItem in items {
          self.myDict.updateValue("", forKey: aItem.listingId)
          self.fetchedItems.updateValue(aItem, forKey: aItem.listingId)
        }
        // created for a slow fetch for api calls since I am only allowed 10 fetches every second for using a free api version.
        sleep(UInt32(0.5))
        
        completion()
      case .failure(let message):
        fatalError(message)
      }
    })
  }
  
  func getImage(with imageId: Int, completion: @escaping ([Image]) -> ()) {
    EtsyApiManager.shared.getPhotoFromItem(withId: imageId, completion: { result in
      switch result {
      case .success(let images):
        completion(images)
      case .failure(let message):
        fatalError(message)
      }
    })
  }
  
  func getCurrency(completion: @escaping (Currency) -> ()) {
    EtsyApiManager.shared.getCurrency(completion: { result in
      switch result {
      case .success(let prices):
        completion(prices)
      case .failure(let message):
        fatalError(message)
      }
    })
  }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.myDict.keys.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.reuseIdentifier) as? ItemTableViewCell else { fatalError() }
    
    let keyValue = Array(myDict)[indexPath.row].key
    cell.itemImage.imageFromURL(urlString: self.myDict[keyValue]!)
    cell.itemTitle.text = String(htmlEncodedString: self.fetchedItems[keyValue]!.title)
    
    let gbpPrice = round((fetchedCurrency?.gbp)! * self.fetchedItems[keyValue]!.price * 100) / 100
    let cadPrice = round((fetchedCurrency?.cad)! * self.fetchedItems[keyValue]!.price * 100) / 100
    let usdPrice = round((fetchedCurrency?.usd)! * self.fetchedItems[keyValue]!.price * 100) / 100
    let eurPrice = round((fetchedCurrency?.eur)! * self.fetchedItems[keyValue]!.price * 100) / 100
    
    cell.itemPrice.text = String(format: "GBP: £%.2f, CAD: $%.2f\n USD: $%.2f, EUR: €%.2f", gbpPrice, cadPrice, usdPrice, eurPrice)
    
    return cell
  }
}

