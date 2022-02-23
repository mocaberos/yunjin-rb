# frozen_string_literal: true

require 'yunjin'

RSpec.describe YunJin do
  it 'バージョンが取得できること' do
    expect(YunJin::VERSION).not_to be nil
  end

  it 'Loggerが取得できること' do
    expect(described_class.logger).not_to be nil
  end
end
