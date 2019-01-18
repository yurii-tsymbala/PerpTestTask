//
//  MainViewController.swift
//  PerpTestTask
//
//  Created by Yurii Tsymbala on 1/17/19.
//  Copyright © 2019 Yurii Tsymbala. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Charts

class MainViewController: UIViewController {
  @IBOutlet weak private var yearPickerView: UIPickerView!
  @IBOutlet weak private var lineChartView: LineChartView!
  private var viewModel: MainViewModel!
  private let disposeBag = DisposeBag()
  private var router: Router!

  convenience init(withViewModel viewModel: MainViewModel,withRouter router: Router) {
    self.init()
    self.router = router
    self.viewModel = viewModel
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    observeViewModel()
    viewModel.fetchData()
    setupView()
  }

  private func observeViewModel() {
    viewModel.reloadData
      .subscribe(onNext: { [weak self] in
        guard let strongSelf = self else {return}
        strongSelf.viewModel.pickerViewModel.currentChartData
          .subscribe(onNext: { [weak self] currentChartData in
            guard let strongSelf = self else {return}
            DispatchQueue.main.async {
              strongSelf.setupChartView(withMaxTemp: currentChartData.maxTempArray,
                                        withMinTemp: currentChartData.minTempArray)
            }
          }).disposed(by: strongSelf.disposeBag)
        DispatchQueue.main.async {
          strongSelf.setupPickerView()
        }
      }).disposed(by: disposeBag)

  }

  private func setupView() {
    title = viewModel.navigatiomItemTitle
  }

  private func setupPickerView() {
    yearPickerView.delegate = self
    yearPickerView.dataSource = self
  }

  private func setupChartView(withMaxTemp maxTemp: [Int],withMinTemp minTemp: [Int]) {
    lineChartView.data?.clearValues()

    let data = LineChartData()

    var lineChartEntry1 = [ChartDataEntry]()
    var lineChartEntry2 = [ChartDataEntry]()

    for i in 0..<maxTemp.count {
      lineChartEntry2.append(ChartDataEntry(x: Double(i), y: Double(maxTemp[i])))
    }
    let line2 = LineChartDataSet(values: lineChartEntry2, label: "Max temperature")
    line2.setColor(UIColor.red.withAlphaComponent(0.5))
    line2.setCircleColor(UIColor.red)
    line2.lineWidth = 2.0
    line2.circleRadius = 6.0
    line2.fillAlpha = 65 / 255.0
    line2.fillColor = UIColor.red
    line2.highlightColor = UIColor.white
    line2.setColor(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1))
    data.addDataSet(line2)

    for i in 0..<minTemp.count {
      lineChartEntry1.append(ChartDataEntry(x: Double(i), y: Double(minTemp[i])))
    }
    let line1 = LineChartDataSet(values: lineChartEntry1, label: "Min Temperature")
    line1.setColor(UIColor.blue.withAlphaComponent(0.5))
    line1.setCircleColor(UIColor.blue)
    line1.lineWidth = 2.0
    line1.circleRadius = 6.0
    line1.fillAlpha = 65 / 255.0
    line1.fillColor = UIColor.blue
    line1.highlightColor = UIColor.white
    line1.setColor(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))
    data.addDataSet(line1)

    lineChartView.data = data
  }
}

extension MainViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return viewModel.pickerViewModel.numberOfRowsForPicker
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return viewModel.pickerViewModel.getInfoOfYear(atIndex: row)
  }
}

extension MainViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    viewModel.pickerViewModel.sendInfoToChart(indexOfTheRow: row)
  }
}





