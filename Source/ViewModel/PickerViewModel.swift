//
//  PickerViewModel.swift
//  PerpTestTask
//
//  Created by Yurii Tsymbala on 1/18/19.
//  Copyright © 2019 Yurii Tsymbala. All rights reserved.
//

import RxSwift
import RxCocoa

class PickerViewModel {

  var currentChartData = BehaviorRelay<InfoData>(value: InfoData(year: "1908", maxTempArray: [0], minTempArray: [0]))

  private var infoDataArray = [InfoData]()
  
  func getInfoOfYear(atIndex index: Int) -> String {
    return infoDataArray[index].year
  }

  var numberOfRowsForPicker: Int {
    return infoDataArray.count
  }

  init(infoDataArray: [InfoData]) {
    self.infoDataArray = infoDataArray
  }

  func sendInfoToChart(indexOfTheRow row: Int) {
    currentChartData.accept(infoDataArray[row])
  }
}

