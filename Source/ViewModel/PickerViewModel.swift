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

  var currentChartData = BehaviorRelay<InfoData>(value: InfoData(year: "1908",
                                                                 maxTempArray: [5,7,6,8,15,17,18,17,16,14,9,5],
                                                                 minTempArray: [-1,2,0,2,7,8,11,9,8,8,3,0]))

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

