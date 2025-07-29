////
////  PickerWithCircleImageProtocol.swift
////  Shuffle100
////
////  Created by Yoshifumi Sato on 2023/05/07.
////  Copyright © 2023 里 佳史. All rights reserved.
////
//
//import UIKit
//
//protocol PickerWithCircleImage {
//  var tableView: UITableView! { get }
//  
//  func createTableViewForScreen() -> UITableView
//  func setTableDataSource(_: UITableView)
//  func setTableDelegate(_: UITableView)
//  func updateTableAndBadge()
//  func flippedState(from: PoemsSelectedState,
//                    for: [Int]) -> SelectedState100
//}
//
//extension PickerWithCircleImage where Self: Screen {
//  
//  func createTableViewForScreen() -> UITableView {
//    let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
//    setTableDataSource(tableView)
//    setTableDelegate(tableView)
//    return tableView
//  }
//}
//
//extension PickerWithCircleImage where Self: UITableViewDataSource {
//  func setTableDataSource(_ tableView: UITableView) {
//    tableView.dataSource = self
//  }
//}
//
//extension PickerWithCircleImage where Self: UITableViewDelegate {
//  func setTableDelegate(_ tableView: UITableView) {
//    tableView.delegate = self
//  }
//}
//
//extension PickerWithCircleImage where Self: SelectedPoemsNumber {
//  
//  func updateTableAndBadge() {
//    updateBadge()
//    tableView.reloadData()
//  }
//}
//
//extension PickerWithCircleImage where Self: SettingsAttachedScreen {
//  func flippedState(
//    from selectedState: PoemsSelectedState,
//    for numbers: [Int]) -> SelectedState100 {
//      
//      switch selectedState {
//      case .full:
//        return settings.state100.cancelInNumbers(numbers)
//      default:
//        return settings.state100.selectInNumbers(numbers)
//      }
//    }
//}
//
