//
//  SheetRoute.swift
//  Shuffle100
//

import Foundation

enum SheetRoute: Identifiable {
  case reciteSettings
  case help
  case torifuda(Poem)
  case whatsNext(Poem)

  var id: String {
    switch self {
    case .reciteSettings: return "reciteSettings"
    case .help:           return "help"
    case .torifuda(let poem):  return "torifuda-\(poem.number)"
    case .whatsNext(let poem): return "whatsNext-\(poem.number)"
    }
  }
}
