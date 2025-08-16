# Screenshot Generation Guide

## Practical Method

Run the following command in this folder:
```bash
bundle exec fastlane snapshot run --workspace "../Shuffle100.xcworkspace"
```

## Device Configuration

This configuration generates screenshots for 2024 App Store requirements:
- **iPhone 16 Pro Max** (6.9-inch) - Mandatory size for 2024
- **iPad Pro 13-inch (M4)** (13-inch) - Mandatory size for 2024

## Test Scenarios

The following UI test scenarios are captured:
1. `test_RecitePoemScreenShot` - Poem recitation screen
2. `test_IntervalScreenShot` - Interval settings screen
3. `test_SearchScreenShot` - Search functionality
4. `test_PoemPickerScreenShot` - Poem selection screen
5. `test_5colorsScreenShot` - Five colors selection
6. `test_TorifudaScreenShot` - Torifuda (poem card) display
7. `test_MemorizeTimerScreenShot` - Memory timer screen

## Generated Files

- `screenshots/ja-JP/` - Contains 14 PNG files (7 scenarios × 2 devices)
- `screenshots/screenshots.html` - HTML preview gallery

## Known Issues

Current fastlane screenshot generation has some unresolved issues:
- **Workspace specification**: Cannot properly specify workspace in Snapfile
  - Workaround: Use command-line argument as shown in "Practical Method" above
- **HTML display**: iPhone screenshots are generated but not displayed in screenshots.html
  - Screenshot files exist and are valid for App Store submission
  - HTML display issue does not affect actual screenshot quality

## Troubleshooting

If you encounter build errors:
1. Ensure `Shuffle100.xcworkspace` is properly accessible from fastlane directory
2. Check that iOS Simulator devices are available: `xcrun simctl list devices`
3. Verify UITest target builds successfully:
   ```bash
   xcodebuild build-for-testing \
    -workspace ../Shuffle100.xcworkspace \
    -scheme Shuffle100 \
    -destination 'platform=iOS Simulator,name=iPhone 16 Pro Max'
   ```