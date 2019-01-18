//
//  DownloadService.swift
//  PerpTestTask
//
//  Created by Yurii Tsymbala on 1/17/19.
//  Copyright © 2019 Yurii Tsymbala. All rights reserved.
//

import Foundation

import Foundation

enum DownloadServiceError: String {
  case firstError = "Request Error"
  case secondError = "Data Response Error"
  case thirdError  = "File Decoding Error"
  case fourthError = "Bad txt symbol. Failed to convert data from String"
}

protocol DownloadServiceType {
  typealias DownloadHandler = (Result<[InfoData], DownloadServiceError>) -> Void
  func fetchDataFromFile(completion: @escaping DownloadHandler)
}

class DownloadService: DownloadServiceType {

  private var infoDataArray = [InfoData]()
  private let indexOfLineToStartFetch = 7

  func fetchDataFromFile(completion: @escaping DownloadHandler) {
    let textURL = URL(string: "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/bradforddata.txt")!
    URLSession.shared.downloadTask(with: textURL) { [weak self]  (dataResponse,_,error) in
      guard let strongSelf = self else {return}
      guard error == nil else {completion(Result.failure(DownloadServiceError.firstError));return}
      guard let dataResponse = dataResponse else { completion(Result.failure(DownloadServiceError.secondError)); return }
      do {
        let string = try String(contentsOf: dataResponse, encoding: String.Encoding.utf8)
        var fullText = string.components(separatedBy: "\n")

        var maxTempArrayInfo = [Int]()
        var minTempArrayInfo = [Int]()
        var yearInfo = Int()

        for indexOfLine in strongSelf.indexOfLineToStartFetch..<fullText.count {
          var wordsInLine = fullText[indexOfLine].components(separatedBy: .whitespacesAndNewlines).filter{
            !$0.isEmpty && !$0.contains("Provisional")}
          var (year,maxTmp,minTmp) = (wordsInLine[0],wordsInLine[2],wordsInLine[3])
          if maxTmp.contains("*") || minTmp.contains("*") {
            maxTmp.removeLast()
            minTmp.removeLast()
          }
          if maxTmp.contains("---") || minTmp.contains("---") {
            maxTmp = "0"
            minTmp = "0"
          }
          guard let yearValue = Int(year) else {completion(Result.failure(DownloadServiceError.fourthError));return}
          guard let maxTempValue = Double(maxTmp) else {completion(Result.failure(DownloadServiceError.fourthError));return}
          guard let minTempValue = Double(minTmp) else {completion(Result.failure(DownloadServiceError.fourthError));return}

          maxTempArrayInfo.append(strongSelf.doubleToInteger(data:maxTempValue))
          minTempArrayInfo.append(strongSelf.doubleToInteger(data:minTempValue))
          yearInfo = yearValue

          if maxTempArrayInfo.count == 12 && minTempArrayInfo.count == 12 {
            strongSelf.infoDataArray.append(InfoData(year: yearInfo , maxTempArray: maxTempArrayInfo , minTempArray:minTempArrayInfo))
            maxTempArrayInfo.removeAll()
            minTempArrayInfo.removeAll()
          }
        }
        completion(Result.success(strongSelf.infoDataArray))
      } catch _ {
        completion(Result.failure(DownloadServiceError.thirdError))
      }
      }.resume()
  }

  private func filterData() -> [InfoData] {

  }

  private func doubleToInteger(data:Double) -> Int {
    let doubleToString = "\(data)"
    let stringToInteger = (doubleToString as NSString).integerValue
    return stringToInteger
  }
}



