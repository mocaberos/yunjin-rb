# frozen_string_literal: true

require 'yunjin'

RSpec.describe 'YunJin::VERSION' do
  it 'バージョンが取得できること' do
    expect(YunJin::VERSION).not_to be nil
  end
end
