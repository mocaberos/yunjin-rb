# frozen_string_literal: true

require_relative 'yunjin/version'
require_relative 'yunjin/v1_apis/sys'
require_relative 'yunjin/v1_apis/twitter'

require 'logger'

# YunJinクライアントライブラリ
module YunJin
  BASE_URL = ENV.fetch('YUNJIN_URL', 'http://localhost:1190')
  HEADERS  = {
    client:  'yunjin-rb',
    version: YunJin::VERSION
  }.freeze

  class RequestError < StandardError; end

  def self.logger
    @logger ||= _logger
  end

  def self._logger
    if defined?(Rails)
      Rails.logger
    else
      Logger.new($stdout)
    end
  end
end
