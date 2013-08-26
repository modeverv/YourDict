# YourDict
あなた個人の辞書を作成するWEBアプリケーションです。   
Microsoftの翻訳サービスを利用します。   
自分でdeployする場合は   
・Twitter/Facebookのアプリケーション登録  
・Microsoftの翻訳サービスの登録を行って下さい
## インストール
config/database.ymlを設定する

    bundle install
    bundle exec rake db:migrate
    
config/config.ymlを設定する

## 起動
    bundle exec sidekiq
    bundle exec unicorn -D -p 8080とか
