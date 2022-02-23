# frozen_string_literal: true

require 'yunjin'

RSpec.describe YunJin do
  it 'Loggerが取得できること' do
    expect(described_class.logger).not_to be nil
  end
end
