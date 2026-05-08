# PotepanShare

PotepanCampの最終課題で制作した宿泊施設の予約、登録システムです。

🔗 Live Demo  


## 🌐 アプリ概要

PotepanShareは

* 宿泊施設の登録、管理
* 宿泊施設の予約

のためのWebアプリです。

「」をコンセプトに設計しています。


## 主な機能

### 🔐 ユーザー機能
ユーザー登録 / ログイン（Devise）
ゲストログイン
プロフィール編集

### 🏠 宿泊施設機能
宿泊施設の登録 / 編集 / 削除
画像アップロード
宿泊施設詳細表示
エリア検索機能

### 📅 予約機能
宿泊施設の予約
予約日数・人数入力
予約一覧確認

### 🎨 UI / UX

* シンプルで直感的なUI設計
* favicon / アプリアイコン実装


## 🛠 技術スタック

| Category        | Technology         |
| --------------- | ------------------ |
| Backend         | Ruby on Rails 7    |
| Authentication  | Devise             |
| Database        | ---       (本番環境)|
|                 | / SQLite3(開発環境) |
| Image Upload    | ActiveStorage?     |
|                 | ---      (本番環境) |         
| Frontend        | HTML / CSS / JS    |
| Environment     | Docker             |
| Version Control | Git / GitHub       |


## 🧱 ER図



## 🚀 セットアップ方法

```bash
git clone https://github.com/miraisato-dev/potepanShare.git
cd potepanShare
bundle install
rails db:create db:migrate
rails s
```

ブラウザで以下にアクセス：

```
http://localhost:3000
```



## 👤 ゲストログイン

ログイン画面から **ゲストログイン** を利用することで、アカウント登録なしで機能を確認できます。


## 🎯 開発背景

PotepanCampの最終課題として、
宿泊施設の登録・予約機能を持つWebアプリを開発しました。

RailsでのCRUD処理や認証機能、
画像アップロード、AWS S3を利用したファイル管理など、
実践的なWebアプリ開発を学ぶことを目的に制作しました。


## 💡 工夫した点

* 

## 🔮 今後の改善予定

* カレンダーのデザインを変更
* 
* 

## 📸 スクリーンショット

* トップページ
![top](images/top.png)
* ダッシュボード
![dashboard](images/dashboard.png)
* アイテム一覧
![dashboard](images/list.png)
* アイテム詳細
![detail](images/detail.png)
* ログイン画面
![login](images/login.png)


## 👨‍💻 作者

miraisato-dev
GitHub: https://github.com/miraisato-dev
