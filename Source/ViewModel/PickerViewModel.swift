//
//  PickerViewModel.swift
//  PerpTestTask
//
//  Created by Yurii Tsymbala on 1/18/19.
//  Copyright © 2019 Yurii Tsymbala. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PickerViewModel {

  //var currentStickerPackName = BehaviorRelay<StickerPack>(value: .pockemons)

  var infoDataArray = [InfoData]()

  func getInfoOfYear(atIndex index: Int) -> String {
    return infoDataArray[index].year
  }

  var numberOfRowsForPicker: Int {
    return infoDataArray.count
  }

  init(infoDataArray: [InfoData]) {
    self.infoDataArray = infoDataArray
  }


  func sendInfoToLabel(indexOfTheRow row: Int) {

  }
}

