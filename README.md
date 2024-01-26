# 推し活日記アプリ

## 概要

- 推し活に特化した日記投稿アプリです。
- 写真や位置情報をつけて投稿できます。
- カレンダー形式で投稿を振り返ることができます。

## 使用技術

- Ruby on Rails (Ruby 3.1.4、Rails 7.0.8)
- My SQL
- AWS S3
- Google Maps API
- RSpec
- jQuery
- JavaScript
- Bootstrap, CSS

## 機能一覧

### ログイン機能
deviseを使用したログイン機能です。ゲストログイン、メールアドレスログインを実装。
ヘッダーのログインページよりゲストログインボタンを押すとゲストユーザーとしてログインできます。

![ゲストログイン](https://github.com/R-Tsukiyama/oshikatsu-diary/assets/133231418/e18161d6-0e23-453c-bc40-cb2061507949)


### 投稿機能
マイページ画面で右下のプラスマークをクリックすると新規投稿画面へ移ります（ヘッダー右上のドロップダウンメニューからでもアクセスできます）。

![操作手順-新規投稿](https://github.com/R-Tsukiyama/oshikatsu-diary/assets/133231418/7277781a-36f1-4623-b36e-3a0d25e525dc)


- **画像投稿**: 
ActiveStorageを使用した画像投稿機能です。選択後、必要のない画像を削除することができます。

![写真選択](https://github.com/R-Tsukiyama/oshikatsu-diary/assets/133231418/ec44636e-e6c0-4373-b239-dc481b791e0b)


- **タグ機能**:
acts-as-taggable-onを使用したタグ管理機能です。
投稿一覧ページもしくは投稿詳細画面で表示されてあるタグをクリックすると、選択したタグで登録されている投稿が検索できます。

![タグ機能](https://github.com/R-Tsukiyama/oshikatsu-diary/assets/133231418/4f70358e-bfcc-4be8-bda9-3e9300257dd2)


- **位置情報検索機能**:
geocoderを使用した位置情報検索機能です。ワードを入力すると位置情報の候補が表示されます。

![位置情報検索機能](https://github.com/R-Tsukiyama/oshikatsu-diary/assets/133231418/adcedf1d-0862-4021-92db-0af25e4e0700)


### 編集機能
投稿一覧もしくは投稿詳細画面で編集を行うことができます。画像を新たに選択し、既存の画像を削除することができます。

![投稿編集](https://github.com/R-Tsukiyama/oshikatsu-diary/assets/133231418/95e1b2f8-ea58-44c5-8fd5-cf5ad9571996)


### カレンダー機能
SimpleCalenderを使用したカレンダー機能です。投稿一覧ページの隣にあるカレンダーマークのタブをクリックするとカレンダーが表示されます。カレンダー内で任意の投稿タイトルをクリックすると、投稿詳細へ移ります。

![操作手順-カレンダー表示](https://github.com/R-Tsukiyama/oshikatsu-diary/assets/133231418/f1d3353b-d17e-4ec1-a592-42ce393055db)


### ユーザー編集機能
Carrierwaveを使用し、ユーザーのアイコンの画像を自由に設定できる機能です。
自己紹介文を設定することもできます。 

![ユーザー編集](https://github.com/R-Tsukiyama/oshikatsu-diary/assets/133231418/aca75da5-328e-4438-8c14-ce82e2275fe9)


## テスト
**Respec**
- modelspec
- requestspec
- systemspec


## ER図
<img width="811" alt="ER図" src="https://github.com/R-Tsukiyama/oshikatsu-diary/assets/133231418/ff8b3aa0-4696-4860-abb5-98eceaa2ad94">


## 開発に至った経緯

「推し活」という言葉が若年層を中心に広まり、アイドルやアニメのファン活動として社会現象化しています。
私も外出先でアクリルスタンドを携帯して写真を撮り、これらの思い出を日記につけたいと感じる機会が増えました。

しかし、SNSのX（旧：Twitter）やInstagramでは、「推し活」を記録する媒体としては不十分な機能があると感じました。Xは文字だけの投稿ができますが、近年のサービス修正により自分の投稿を振り返るのが難しくなっています。一方でInstagramは詳細な場所情報を含んだ投稿ができますが、写真の添付が必須であり、文字だけの投稿ができません。

そこで、「推し活」に特化した日記アプリを開発することを考えました。
このアプリでは、自分が何日に何をしたかという記録をカレンダー形式で表示し、推し活を振り返ったり懐かしんだりすることができます。これにより、より充実した推し活が可能となるでしょう。
