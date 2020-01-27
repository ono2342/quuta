# Quuta
​
プログラミングスクールの同期３人で作成しました。  
野球の記事を投稿するサイトです。
​
### URL
​
https://quuta.net/
​
### 使用技術
​
Ruby 2.5.1  
Rails 5.2.3  
AWS  
- EC2
- S3
- Route53

### 機能一覧
​
- ユーザ登録(devise),ログイン機能全般
- facebook/google/Twitter での omniauth 認証
- 記事投稿（マークダウン記法）、リアルタイムプレビュー表示
- 画像のプレビュー機能(jQuery)
- 複数画像アップロード(carrierwave)
- 記事のいいね機能、お気に入り機能
- ページネーション(kaminari)
- 自動デプロイ(capistrano)
