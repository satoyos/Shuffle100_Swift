Shuffle100 (百首読み上げ) Swift Version
==========

[![CircleCI](https://circleci.com/gh/satoyos/Shuffle100_Swift/tree/master.svg?style=svg)](https://circleci.com/gh/satoyos/Shuffle100_Swift/tree/master)

(English to follow)

実際の百人一首かるたを使って対戦や練習をするときに、人の代わりに百人一首の歌の読み手を務めるiOSアプリです。
![Image](http://postachio-images.s3-website-us-east-1.amazonaws.com/bdc9788b9b5c8ff218c37223f302b9a4/511242b6e6a9f3507107fc8f1c2af6e2/w600_df90791d0bf5c6022857a54b3700d61b.png)

ボーカロイド音声（※1）または人間の音声（※2）で、百人一首の歌をランダムに読み上げます。
[こちらの動画](https://vimeo.com/88511077)で、実際に使っている様子をご覧いただけます。(競技かるた用の通常モードで遊ぶ場合の動画です)
また、歌を上の句から読み上げ始める「初心者モード」も用意しています。([こちらの動画](https://vimeo.com/104796183)をご覧ください。)

アプリは、[App Store](https://itunes.apple.com/jp/app/bai-shou-dumi-shangge/id857819404?mt=8)で公開中です。

# 設定できること

## 1. 読手

  バージョン3.0から、ボーカロイド音声（※1）に加え、人間の読手による読み上げ音声（※2）も選べるようになりました。

## 2. 通常モード / 初心者モード
  上の句から読み始めるのか(初心者モード)、前の歌の下の句から読み始めるのか(通常モード)を選べます。

| モード | 試合の流れ |
| ------ | ---------- |
| 通常モード(競技かるたモード) | (試合再開) → 下の句読み上げ → 次の歌の上の句読み上げ → (試合一次停止) |
| 初心者モード(散らし取りモード) | (試合再開) → 上の句読み上げ → 下の句読み上げ → (試合一次停止) |

## 3. 試合に使う歌の選択と保存
  100首の中から、試合に使う歌をお好みで選べます。  また、選んだ歌は「札セット」として名前をつけて保存しておくことができます。
  歌を選ぶための一覧画面で、ある歌の「詳細情報」ボタンを押すと、その歌の取り札イメージを見ることができます。

## 4. 空札(からふだ)の有無(通常モードのみ)
  読み上げる札の中に、空札(取り札が無い「ハズレ」札)を入れるかどうかを設定できます。
  空札は、「試合に使う歌」と同数の札がランダムに選ばれます。

## 5. 歌と歌の間隔(秒数)
  下の句を読み終えてから、次の歌の上の句を読み上げるまでの間隔を調整できます。

## 6 上の句と下の句の間隔(秒数)】(初心者モードのみ)
  初心者モードで、上の句を読み終えてから下の句を読み始めるまでの間隔を調整できます。

# VOCALOIDの歌唱データ

こちらの[GitHubページ](https://github.com/satoyos/HyakuninIsshuVocaloidScore)で公開しています。
VOCALOID Editorをお持ちでしたら、ぜひ改良してやってください。
(データはVOCALOID4 Editorで作成しています。)


Copyright (c) 2014-2022 Yoshifumi Sato
This software is released under the MIT License, see LICENSE.txt.

- - -

(※1) ボーカロイドはヤマハ株式会社の登録商標です。
(※2) [難波津いなばくん](http://naniwazu.la.coocan.jp)の音声データ「いなばくん」を、著作権者（なにはづ様）の許諾を得て使用しています。
`/resources/audio/inaba`フォルダの音声データの取り扱いについては、次のような制限があります。

- このアプリの動作確認を目的として、本リポジトリを音声データごとダウンロード(あるいはclone、forkなど)をすることについては、著作権者の許諾済みですので、改めて著作権者の許諾を得る必要はありません。
- 他の目的で`/resources/audio/inaba`の音声データを利用する場合には、著作権者の許諾を得てください。


- - -

[Below are English descriptions of this App.]

Kyogi-Karuta is a Japanese traditional game using the “Hyaku-nin-Isshu"(#1) Karuta cards.

(#1 .. It means "a hundred tanka poems by a hundred famous poem", selected by Teika Fujiwara about 800 years ago, as "The All Time Best 100 in these 600 years" at that time.)

This app is in [App Store](https://itunes.apple.com/jp/app/bai-shou-dumi-shangge/id857819404?mt=8) , supports playing the game, by reading tanka poems at random.

You can watch Demo video at [this page](https://vimeo.com/88511077).
(Now, we are migrating the app from RubyMotion to Swift in this repository.)

Some settings are available;

## 1. Reader

  You can select a poem reader.

| Name | Type |
| ---- | ----------- |
| IA   | VOCALOID(#2) voice |
| Inaba-kun (#3) | Human voice |

 (#2 .. VOCALOID is a registered trademark of Yamaha Corporation.)
 (#3 .. in Japanese; いなばくん. See footer note #7 about Copyright.)

## 2. Play Mode (sets timing of pause)

| Mode | Description |
| ---- | ----------- |
| Normal mode   | Mode for Kyogi-Karuta. Reader pauses singing just after 1st half of a poem. |
| Beginner mode | Recommended mode for Beginner. Reader pauses after singing a whole poem. |

## 3. Poems to read
  You can select tanka poems to read as you like, and save it with name as you like.
  When you tap detail-button on "Select Poems" screen(#4), you can confirm "Tori-Fuda" image(#5) of the poem.
  (#4 .. in Japanese; 「歌を選ぶ」画面)
  (#5 .. in Japanese; 「取り札」イメージ)

## 4. Use "Kara Fuda"(#6), or not.
  (#6 .. It means "Fake Poems", 「空札」 in Japanese)
  Fake Poems can be added in Normal mode. Additional fake poems are collected at random, as many as "Poems to read" you selected.

## 5. Interval time between poems

(by second)

## 6. Interval time between 1st half of a poem, and 2nd half of it

(by second, in Beginner mode only)

# And..

I apologize that this App supports Japanese only. If many people hope English support, I'll give it a try!

Copyright (c) 2014-2022 Yoshifumi Sato
This software is released under the MIT License, see LICENSE.txt.

- - -
(#7) Human voice files in `/resources/audio/inaba` folder are derived from [Naniwazu Inaba-kun](http://naniwazu.la.coocan.jp).
 So, the author of the software has the copyright of these voice files.

 - For the purpose of checking how this app works, you can download (clone, fork) the voice files without confirming author's permisson, because the author has already confirmed it.
 - For other purposes, the author's permission is required.
