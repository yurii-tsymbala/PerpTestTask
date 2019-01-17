//
//  DownloadService.swift
//  PerpTestTask
//
//  Created by Yurii Tsymbala on 1/17/19.
//  Copyright © 2019 Yurii Tsymbala. All rights reserved.
//

import Foundation

enum DownloadServiceError {

}

protocol DownloadServiceType {
  typealias DownloadHandler = (Result<[], DownloadServiceError>) -> Void
  func fetchDataFromFile(completion: @escaping DownloadHandler)
}

class DownloadService: DownloadServiceType {

  func fetchDataFromFile(completion: @escaping DownloadHandler) {
    let textURL = URL(string: "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/bradforddata.txt")!
    URLSession.shared.downloadTask(with: textURL) { [weak self]  (dataResponse,_,error) in
      guard let strongSelf = self else {return}
      guard error == nil else {completion();return}
      guard let dataResponse = dataResponse else { completion(Result.failure(); return }
      do {
      } catch _ {
        completion()
      }
      }.resume()
}
}

