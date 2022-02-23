# frozen_string_literal: true

require 'typhoeus'

module YunJin
  # システム動作確認用API
  class Sys
    # ヘルスチェック
    #
    # @return [Boolean] システムの状態
    def self.health?
      res = Typhoeus::Request.new(
        "#{YunJin::BASE_URL}/yunjin/api/v1/sys/health",
        method:         :get,
        headers:        YunJin::HEADERS,
        followlocation: true
      ).run
      YunJin.logger.warn "YunJin: health check failed. (status: #{res.code})" unless res.success?
      res.success?
    end

    # ヘルスチェック
    #
    # @raise YunJin::RequestError ヘルスチェックが通らない場合
    def self.health!
      raise YunJin::RequestError unless health?
    end
  end
end
