#!/usr/bin/env swift

import AppKit

struct ScreenshotSpec {
  let sourceDirectory: String
  let sourceName: String
  let outputName: String
  let crop: CGRect
  let highlight: CGRect
}

guard CommandLine.arguments.count == 4 else {
  fputs("Usage: generate_help_screenshots.swift <raw-dir> <delete-raw-dir> <output-dir>\n", stderr)
  exit(2)
}

let rawDirectory = CommandLine.arguments[1]
let deleteRawDirectory = CommandLine.arguments[2]
let outputDirectory = CommandLine.arguments[3]

let specs = [
  ScreenshotSpec(
    sourceDirectory: rawDirectory,
    sourceName: "iPhone 17-help_save_set_button.png",
    outputName: "save_set_button.png",
    crop: CGRect(x: 0, y: 120, width: 1206, height: 620),
    highlight: CGRect(x: 790, y: 155, width: 170, height: 185)
  ),
  ScreenshotSpec(
    sourceDirectory: rawDirectory,
    sourceName: "iPhone 17-help_select_by_group.png",
    outputName: "select_by_group.png",
    crop: CGRect(x: 0, y: 2180, width: 1206, height: 390),
    highlight: CGRect(x: 825, y: 2410, width: 350, height: 125)
  ),
  ScreenshotSpec(
    sourceDirectory: rawDirectory,
    sourceName: "iPhone 17-help_select_by_fuda_set.png",
    outputName: "select_by_fuda_set.png",
    crop: CGRect(x: 420, y: 1260, width: 786, height: 1160),
    highlight: CGRect(x: 485, y: 1500, width: 650, height: 165)
  ),
  ScreenshotSpec(
    sourceDirectory: deleteRawDirectory,
    sourceName: "iPhone 17-help_delete_fuda_set.png",
    outputName: "delete_fuda_set.png",
    crop: CGRect(x: 0, y: 125, width: 1206, height: 525),
    highlight: CGRect(x: 1015, y: 335, width: 160, height: 180)
  ),
  ScreenshotSpec(
    sourceDirectory: rawDirectory,
    sourceName: "iPhone 17-help_select_by_five_colors.png",
    outputName: "select_by_5_colors.png",
    crop: CGRect(x: 420, y: 1260, width: 786, height: 1160),
    highlight: CGRect(x: 500, y: 1870, width: 620, height: 150)
  ),
  ScreenshotSpec(
    sourceDirectory: rawDirectory,
    sourceName: "iPhone 17-help_memorize_timer.png",
    outputName: "memorizeTimerCell.jpg",
    crop: CGRect(x: 0, y: 120, width: 1206, height: 1480),
    highlight: CGRect(x: 30, y: 1270, width: 1146, height: 165)
  ),
  ScreenshotSpec(
    sourceDirectory: rawDirectory,
    sourceName: "iPhone 17-help_enable_postmortem.png",
    outputName: "enable_postmortem.png",
    crop: CGRect(x: 0, y: 1080, width: 1206, height: 760),
    highlight: CGRect(x: 40, y: 1500, width: 1126, height: 270)
  ),
  ScreenshotSpec(
    sourceDirectory: rawDirectory,
    sourceName: "iPhone 17-help_start_postmortem.png",
    outputName: "start_postmortem_button.png",
    crop: CGRect(x: 0, y: 1160, width: 1206, height: 640),
    highlight: CGRect(x: 330, y: 1450, width: 550, height: 150)
  )
]

let fileManager = FileManager.default
try fileManager.createDirectory(atPath: outputDirectory, withIntermediateDirectories: true)

func render(_ spec: ScreenshotSpec) throws {
  let sourceURL = URL(fileURLWithPath: spec.sourceDirectory).appendingPathComponent(spec.sourceName)
  guard let source = NSImage(contentsOf: sourceURL),
        let representation = source.representations.first else {
    throw NSError(domain: "HelpScreenshot", code: 1, userInfo: [NSLocalizedDescriptionKey: "Cannot read \(sourceURL.path)"])
  }

  let sourceWidth = CGFloat(representation.pixelsWide)
  let sourceHeight = CGFloat(representation.pixelsHigh)
  source.size = NSSize(width: sourceWidth, height: sourceHeight)

  let bitmap = NSBitmapImageRep(
    bitmapDataPlanes: nil,
    pixelsWide: Int(spec.crop.width),
    pixelsHigh: Int(spec.crop.height),
    bitsPerSample: 8,
    samplesPerPixel: 4,
    hasAlpha: true,
    isPlanar: false,
    colorSpaceName: .deviceRGB,
    bytesPerRow: 0,
    bitsPerPixel: 0
  )!

  NSGraphicsContext.saveGraphicsState()
  NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmap)
  NSColor.white.setFill()
  NSRect(x: 0, y: 0, width: spec.crop.width, height: spec.crop.height).fill()

  let sourceRect = NSRect(
    x: spec.crop.minX,
    y: sourceHeight - spec.crop.maxY,
    width: spec.crop.width,
    height: spec.crop.height
  )
  source.draw(
    in: NSRect(x: 0, y: 0, width: spec.crop.width, height: spec.crop.height),
    from: sourceRect,
    operation: .copy,
    fraction: 1
  )

  let localHighlight = NSRect(
    x: spec.highlight.minX - spec.crop.minX,
    y: spec.crop.height - (spec.highlight.maxY - spec.crop.minY),
    width: spec.highlight.width,
    height: spec.highlight.height
  )
  let path = NSBezierPath(roundedRect: localHighlight, xRadius: 24, yRadius: 24)
  path.lineWidth = 12
  NSColor(calibratedRed: 0.98, green: 0.20, blue: 0.42, alpha: 1).setStroke()
  path.stroke()
  NSGraphicsContext.restoreGraphicsState()

  let fileType: NSBitmapImageRep.FileType = spec.outputName.hasSuffix(".jpg") ? .jpeg : .png
  let properties: [NSBitmapImageRep.PropertyKey: Any] = fileType == .jpeg ? [.compressionFactor: 0.9] : [:]
  guard let data = bitmap.representation(using: fileType, properties: properties) else {
    throw NSError(domain: "HelpScreenshot", code: 2, userInfo: [NSLocalizedDescriptionKey: "Cannot encode \(spec.outputName)"])
  }
  try data.write(to: URL(fileURLWithPath: outputDirectory).appendingPathComponent(spec.outputName))
}

for spec in specs {
  try render(spec)
  print("generated \(spec.outputName)")
}
