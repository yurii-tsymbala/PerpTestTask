//
//  MainViewModel.swift
//  PerpTestTask
//
//  Created by Yurii Tsymbala on 1/17/19.
//  Copyright © 2019 Yurii Tsymbala. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol MainViewModelType {
  var navigatiomItemTitle: String { get }
  var reloadData: PublishSubject<Void> { get }
  var showAlert: PublishSubject<AlertViewModel> { get }
  func fetchData()
}

class MainViewModel: MainViewModelType {
  private struct Strings {
    static let navigatiomItemTitle = NSLocalizedString("Weather info", comment: "")
  }

  private let downloadService: DownloadServiceType
  private var infoDataArray = [InfoData]()
  var pickerViewModel: PickerViewModel!

  init(downloadService: DownloadServiceType) {
    self.downloadService = downloadService
  }

  var navigatiomItemTitle = Strings.navigatiomItemTitle

  var reloadData = PublishSubject<Void>()
  var showAlert = PublishSubject<AlertViewModel>()

  func fetchData() {
    downloadService.fetchDataFromFile( completion: { [weak self] fetchResult in
      guard let strongSelf = self else {return}
      switch fetchResult {
      case .success(let infoDataArray):
        strongSelf.infoDataArray = infoDataArray
        strongSelf.pickerViewModel = PickerViewModel(infoDataArray: infoDataArray)
        strongSelf.reloadData.onNext(())
      case .failure(let error):
        print(error.rawValue)
        strongSelf.showAlert.onNext(AlertViewModel(message: error.rawValue))
      }
    })
  }
}
