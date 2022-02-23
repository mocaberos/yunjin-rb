# YunJinクライアントライブラリ

#### Ruby3.1.0 CI Test Status
[![Build Status](https://codebuild.ap-northeast-1.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiQjduQWZnZElnYllQWlcrSmx1TEY4cjVuQnRkZUFGK2g0Skl1b24zRFJ4Q2FhZGlUV0x1cUEyZFkzME02a0JCMGQ2MjJxeGR5ZWpmYzd5b2l1UnBrSlFnPSIsIml2UGFyYW1ldGVyU3BlYyI6Im96bU1XalpqRFJydjdlcXYiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=master)](https://ap-northeast-1.console.aws.amazon.com/codesuite/codebuild/085041388644/projects/yunjin-rb-3-1-0)
#### Ruby3.0.3 CI Test Status
[![Build Status](https://codebuild.ap-northeast-1.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoib3NndjFNSCsrVDFJUEtvdjdUWWFSMDZqRWwzejI1K2F6UHl0MkNiTFh4bVdFdkVwMUVUYnBxbFp5YlBwZlQvRGNERTdha2lPK1NqMU14MUIxNi9oaEs0PSIsIml2UGFyYW1ldGVyU3BlYyI6IjdyNHVta2d4eVhuMHBseDciLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=master)](https://ap-northeast-1.console.aws.amazon.com/codesuite/codebuild/085041388644/projects/yunjin-rb-3-0-3)

https://github.com/mocaberos/yunjin

### 使用方法
```
gem 'yunjin-rb'
```
#### ヘルスチェック
```ruby
YunJin::V1APIs::Sys.health?
# or
YunJin::V1APIs::Sys.health!
```
#### ツイート検索
```ruby
YunJin::V1APIs::Twitter.search_tweets!('めんだこちゃん', '2022-01-01', '2022-02-01', limit: 10)
```
#### ユーザーIDによる、ユーザープロフィール情報取得
```ruby
YunJin::V1APIs::Twitter.get_user_profile_by_id!('1040201001767034882')
```
#### ユーザー名による、ユーザープロフィール情報取得
```ruby
YunJin::V1APIs::Twitter.get_user_profile_by_name!('Mendako_Vtuber')
```
#### ユーザー名をユーザーIDに変換する
```ruby
YunJin::V1APIs::Twitter.name_to_id!('Mendako_Vtuber')
```
#### ユーザーIDをユーザー名に変換する
```ruby
YunJin::V1APIs::Twitter.id_to_name!('1040201001767034882')
```
#### 指定したユーザーのツイートを取得
```ruby
YunJin::V1APIs::Twitter.user_timeline!('1040201001767034882', '2022-01-01', '2022-02-01')
```
#### 指定したユーザーのツイートを全て取得する
```ruby
YunJin::V1APIs::Twitter.all_tweets!('1040201001767034882') do |tweets|
  p tweets
end
```

### 動作確認(irb)
```shell
$ ./bin/console
# or
$ docker-compose run yunjin_rb
```

### テストを実行する
```shell
$ ./bin/test.sh
# or
$ docker-compose run yunjin_rb /app/bin/test.sh
```
