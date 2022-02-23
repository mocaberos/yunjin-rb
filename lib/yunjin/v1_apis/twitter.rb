# frozen_string_literal: true

require 'yunjin'
require 'typhoeus'
require 'json'
require 'date'

module YunJin
  module V1APIs
    # TwitterスクレイピングAPI
    class Twitter # rubocop:disable Metrics/ClassLength
      # ツイート検索API
      #
      # @raise JSON::ParserError レスポンスのパースエラー
      # @raise YunJin::RequestError 正しく処理出来なかった場合
      #
      # @param [String]  query      検索キーワード
      # @param [String]  start_date 検索開始日付 例: `2020-01-01`
      # @param [String]  end_date   検索終了日付 例: `2020-01-31`
      # @param [Integer] limit      取得数制限 (厳密に制限される訳ではない)
      # @return [Array] 検索結果
      def self.search_tweets!(query, start_date: nil, end_date: nil, limit: 1024)
        res = Typhoeus::Request.new(
          "#{YunJin::BASE_URL}/yunjin/api/v1/twitter/search-tweets",
          method:         :get,
          headers:        YunJin::HEADERS,
          params:         {
            query:      query,
            start_date: start_date,
            end_date:   end_date,
            limit:      limit
          },
          followlocation: true
        ).run
        unless res.success?
          YunJin.logger.error "YunJin: failed to search tweets. (status: #{res.code})"
          YunJin.logger.error "YunJin: query: #{query}, start_date: #{start_date}, end_date: #{end_date}, limit: #{limit}"
          raise YunJin::RequestError
        end
        JSON.parse!(res.body, { symbolize_names: true })[:tweets]
      end

      # ユーザーIDによる、ユーザープロフィール情報取得
      #
      # @raise JSON::ParserError レスポンスのパースエラー
      # @raise YunJin::RequestError 正しく処理出来なかった場合
      #
      # @param [String] user_id ユーザーID
      # @return [Hash] プロフィール情報
      def self.get_user_profile_by_id!(user_id)
        res = Typhoeus::Request.new(
          "#{YunJin::BASE_URL}/yunjin/api/v1/twitter/user-profile/user_id/#{user_id}",
          method:         :get,
          headers:        YunJin::HEADERS,
          followlocation: true
        ).run
        unless res.success?
          YunJin.logger.error "YunJin: failed to get user profile by ID. (status: #{res.code})"
          YunJin.logger.error "YunJin: user_id: #{user_id}"
          raise YunJin::RequestError
        end
        JSON.parse!(res.body, { symbolize_names: true })
      end

      # ユーザー名による、ユーザープロフィール情報取得
      #
      # @raise JSON::ParserError レスポンスのパースエラー
      # @raise YunJin::RequestError 正しく処理出来なかった場合
      #
      # @param [String] user_name ユーザー名
      # @return [Hash] プロフィール情報
      def self.get_user_profile_by_name!(user_name)
        res = Typhoeus::Request.new(
          "#{YunJin::BASE_URL}/yunjin/api/v1/twitter/user-profile/user_name/#{user_name}",
          method:         :get,
          headers:        YunJin::HEADERS,
          followlocation: true
        ).run
        unless res.success?
          YunJin.logger.error "YunJin: failed to get user profile by user name. (status: #{res.code})"
          YunJin.logger.error "YunJin: user_name: #{user_name}"
          raise YunJin::RequestError
        end
        JSON.parse!(res.body, { symbolize_names: true })
      end

      # ユーザー名をユーザーIDに変換する
      #
      # @raise JSON::ParserError レスポンスのパースエラー
      # @raise YunJin::RequestError 正しく処理出来なかった場合
      #
      # @param [String] user_name ユーザー名
      # @return [String] ユーザーID
      def self.name_to_id!(user_name)
        res = Typhoeus::Request.new(
          "#{YunJin::BASE_URL}/yunjin/api/v1/twitter/name-to-id/#{user_name}",
          method:         :get,
          headers:        YunJin::HEADERS,
          followlocation: true
        ).run
        unless res.success?
          YunJin.logger.error "YunJin: failed to convert user name to user id. (status: #{res.code})"
          YunJin.logger.error "YunJin: user_name: #{user_name}"
          raise YunJin::RequestError
        end
        JSON.parse!(res.body, { symbolize_names: true })[:user_id]
      end

      # ユーザーIDをユーザー名に変換する
      #
      # @raise JSON::ParserError レスポンスのパースエラー
      # @raise YunJin::RequestError 正しく処理出来なかった場合
      #
      # @param [String] user_id ユーザーID
      # @return [String] ユーザー名
      def self.id_to_name!(user_id)
        res = Typhoeus::Request.new(
          "#{YunJin::BASE_URL}/yunjin/api/v1/twitter/id-to-name/#{user_id}",
          method:         :get,
          headers:        YunJin::HEADERS,
          followlocation: true
        ).run
        unless res.success?
          YunJin.logger.error "YunJin: failed to convert user id to user name. (status: #{res.code})"
          YunJin.logger.error "YunJin: user_id: #{user_id}"
          raise YunJin::RequestError
        end
        JSON.parse!(res.body, { symbolize_names: true })[:user_name]
      end

      # 特定のユーザーのツイートを取得する
      #
      # @raise JSON::ParserError レスポンスのパースエラー
      # @raise YunJin::RequestError 正しく処理出来なかった場合
      #
      # @param [String]  user_id    ユーザーID
      # @param [String]  start_date 検索開始日付 例: `2020-01-01`
      # @param [String]  end_date   検索終了日付 例: `2020-01-31`
      # @return [Array] ツイート情報
      def self.user_timeline!(user_id, start_date, end_date)
        res = Typhoeus::Request.new(
          "#{YunJin::BASE_URL}/yunjin/api/v1/twitter/user-timeline",
          method:         :get,
          params:         {
            user_id: user_id,
            since:   start_date,
            until:   end_date
          },
          headers:        YunJin::HEADERS,
          followlocation: true
        ).run
        unless res.success?
          YunJin.logger.error "YunJin: failed to get user timeline. (status: #{res.code})"
          YunJin.logger.error "YunJin: user_id: #{user_id}, start_date: #{start_date}, end_date: #{end_date}"
          raise YunJin::RequestError
        end
        JSON.parse!(res.body, { symbolize_names: true })[:tweets]
      end

      # 特定のユーザーのツイートを全て取得する
      # 取得したツイートを少しずつProcに引き渡して、未取得ツイートが無くなるまで繰り返す
      #
      # @raise JSON::ParserError レスポンスのパースエラー
      # @raise YunJin::RequestError 正しく処理出来なかった場合
      #
      # @param [String]  user_id  ユーザーID
      # @param [Integer] interval 一回で取得する日数 (取得数上限を回避するため)
      # @param [Integer] wait     リクエスト後指定秒数待つ (アクセスレート制限回避のため)
      # @param [Proc]　　 block    取得されたツイートデータのリストが引数として渡されます
      def self.all_tweets!(user_id, interval: 10, wait: 5)
        join_date = get_user_profile_by_id!(user_id)[:join_date]
        search_start = Date.new(*join_date.split('-').map(&:to_i))
        search_pointer = search_start
        search_stop = Date.today
        loop do
          tweets = user_timeline!(user_id, search_pointer.to_s, (search_pointer + interval).to_s)
          yield(tweets)
          search_pointer += interval
          break if search_pointer > search_stop

          sleep(wait)
        end
      end
    end
  end
end
