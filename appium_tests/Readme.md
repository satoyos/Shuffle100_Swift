# アプリ「百首読み上げ」のスクリーンショットを撮るには？

## 撮影方法

このフォルダで、以下のコマンドを実行する。
```sh
bundle exec rspec --format d take_screen_shots.rb
```

これにより、`screenshots`フォルダにスクリーンショットが格納される。

## 各種設定

シミュレーターの機種やiOSバージョンは、`spec_helper.rb`内で指定する。