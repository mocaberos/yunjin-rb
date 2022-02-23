# frozen_string_literal: true

require 'yunjin'
require 'json'

RSpec.describe YunJin::V1APIs::Twitter do
  let :json_parse_options do
    { symbolize_names: true }
  end

  let :request do
    Typhoeus::Request.new(base_url, **options)
  end

  let :response do
    Typhoeus::Response.new
  end

  describe '#search_tweets!' do
    subject do
      described_class.search_tweets!(query, start_date: start_date, end_date: end_date, limit: limit)
    end

    let :base_url do
      "#{YunJin::BASE_URL}/yunjin/api/v1/twitter/search-tweets"
    end

    let :options do
      {
        method:         :get,
        headers:        YunJin::HEADERS,
        params:         {
          query:      query,
          start_date: start_date,
          end_date:   end_date,
          limit:      limit
        },
        followlocation: true
      }
    end

    let :query do
      'some_query'
    end

    let :start_date do
      '2022-01-01'
    end

    let :end_date do
      '2022-01-10'
    end

    let :limit do
      10
    end

    let :res_body do
      {
        tweets: []
      }.to_json
    end

    before :each do
      allow(Typhoeus::Request).to receive(:new).with(base_url, **options).and_return(request)
      allow(request).to receive(:run).and_return(response)
      allow(response).to receive(:body).and_return(res_body)
    end

    context '正しく取得できた場合' do
      before :each do
        allow(response).to receive(:success?).and_return(true)
        allow(JSON).to receive(:parse!).with(res_body, json_parse_options).and_return({ tweets: [] })
      end

      it 'JSONのレスポンスをパースして返すこと' do
        expect(JSON).to receive(:parse!).with(res_body, json_parse_options)

        subject
      end
    end

    context '正しく取得できなかった場合' do
      before :each do
        allow(response).to receive(:success?).and_return(false)
      end

      it '例外(YunJin::RequestError)が発生すること' do
        expect { subject }.to raise_error(YunJin::RequestError)
      end

      it 'エラーログが記録されること' do
        expect(YunJin.logger).to receive(:error).twice

        begin
          subject
        rescue YunJin::RequestError
          # Ignore
        end
      end
    end
  end

  describe '#get_user_profile_by_id!' do
    subject do
      described_class.get_user_profile_by_id!(user_id)
    end

    let :base_url do
      "#{YunJin::BASE_URL}/yunjin/api/v1/twitter/user-profile/user_id/#{user_id}"
    end

    let :options do
      {
        method:         :get,
        headers:        YunJin::HEADERS,
        followlocation: true
      }
    end

    let :user_id do
      '12345678901'
    end

    let :res_body do
      {}.to_json
    end

    before :each do
      allow(Typhoeus::Request).to receive(:new).with(base_url, **options).and_return(request)
      allow(request).to receive(:run).and_return(response)
      allow(response).to receive(:body).and_return(res_body)
    end

    context '正しく取得できた場合' do
      before :each do
        allow(response).to receive(:success?).and_return(true)
        allow(JSON).to receive(:parse!).with(res_body, json_parse_options).and_return({})
      end

      it 'JSONのレスポンスをパースして返すこと' do
        expect(JSON).to receive(:parse!).with(res_body, json_parse_options)

        subject
      end
    end

    context '正しく取得できなかった場合' do
      before :each do
        allow(response).to receive(:success?).and_return(false)
      end

      it '例外(YunJin::RequestError)が発生すること' do
        expect { subject }.to raise_error(YunJin::RequestError)
      end

      it 'エラーログが記録されること' do
        expect(YunJin.logger).to receive(:error).twice

        begin
          subject
        rescue YunJin::RequestError
          # Ignore
        end
      end
    end
  end

  describe '#get_user_profile_by_name!' do
    subject do
      described_class.get_user_profile_by_name!(user_name)
    end

    let :base_url do
      "#{YunJin::BASE_URL}/yunjin/api/v1/twitter/user-profile/user_name/#{user_name}"
    end

    let :options do
      {
        method:         :get,
        headers:        YunJin::HEADERS,
        followlocation: true
      }
    end

    let :user_name do
      'user_name'
    end

    let :res_body do
      {}.to_json
    end

    before :each do
      allow(Typhoeus::Request).to receive(:new).with(base_url, **options).and_return(request)
      allow(request).to receive(:run).and_return(response)
      allow(response).to receive(:body).and_return(res_body)
    end

    context '正しく取得できた場合' do
      before :each do
        allow(response).to receive(:success?).and_return(true)
        allow(JSON).to receive(:parse!).with(res_body, json_parse_options).and_return({})
      end

      it 'JSONのレスポンスをパースして返すこと' do
        expect(JSON).to receive(:parse!).with(res_body, json_parse_options)

        subject
      end
    end

    context '正しく取得できなかった場合' do
      before :each do
        allow(response).to receive(:success?).and_return(false)
      end

      it '例外(YunJin::RequestError)が発生すること' do
        expect { subject }.to raise_error(YunJin::RequestError)
      end

      it 'エラーログが記録されること' do
        expect(YunJin.logger).to receive(:error).twice

        begin
          subject
        rescue YunJin::RequestError
          # Ignore
        end
      end
    end
  end

  describe '#name_to_id!' do
    subject do
      described_class.name_to_id!(user_name)
    end

    let :base_url do
      "#{YunJin::BASE_URL}/yunjin/api/v1/twitter/name-to-id/#{user_name}"
    end

    let :options do
      {
        method:         :get,
        headers:        YunJin::HEADERS,
        followlocation: true
      }
    end

    let :user_name do
      'user_name'
    end

    let :res_body do
      {
        user_id: '1234567890'
      }.to_json
    end

    before :each do
      allow(Typhoeus::Request).to receive(:new).with(base_url, **options).and_return(request)
      allow(request).to receive(:run).and_return(response)
      allow(response).to receive(:body).and_return(res_body)
    end

    context '正しく取得できた場合' do
      before :each do
        allow(response).to receive(:success?).and_return(true)
        allow(JSON).to receive(:parse!).with(res_body, json_parse_options).and_return({ user_id: '1234567890' })
      end

      it 'JSONのレスポンスをパースして返すこと' do
        expect(JSON).to receive(:parse!).with(res_body, json_parse_options)

        subject
      end
    end

    context '正しく取得できなかった場合' do
      before :each do
        allow(response).to receive(:success?).and_return(false)
      end

      it '例外(YunJin::RequestError)が発生すること' do
        expect { subject }.to raise_error(YunJin::RequestError)
      end

      it 'エラーログが記録されること' do
        expect(YunJin.logger).to receive(:error).twice

        begin
          subject
        rescue YunJin::RequestError
          # Ignore
        end
      end
    end
  end

  describe '#id_to_name!' do
    subject do
      described_class.id_to_name!(user_id)
    end

    let :base_url do
      "#{YunJin::BASE_URL}/yunjin/api/v1/twitter/id-to-name/#{user_id}"
    end

    let :options do
      {
        method:         :get,
        headers:        YunJin::HEADERS,
        followlocation: true
      }
    end

    let :user_id do
      '1234567890'
    end

    let :res_body do
      {
        user_name: 'user_name'
      }.to_json
    end

    before :each do
      allow(Typhoeus::Request).to receive(:new).with(base_url, **options).and_return(request)
      allow(request).to receive(:run).and_return(response)
      allow(response).to receive(:body).and_return(res_body)
    end

    context '正しく取得できた場合' do
      before :each do
        allow(response).to receive(:success?).and_return(true)
        allow(JSON).to receive(:parse!).with(res_body, json_parse_options).and_return({ user_name: 'user_name' })
      end

      it 'JSONのレスポンスをパースして返すこと' do
        expect(JSON).to receive(:parse!).with(res_body, json_parse_options)

        subject
      end
    end

    context '正しく取得できなかった場合' do
      before :each do
        allow(response).to receive(:success?).and_return(false)
      end

      it '例外(YunJin::RequestError)が発生すること' do
        expect { subject }.to raise_error(YunJin::RequestError)
      end

      it 'エラーログが記録されること' do
        expect(YunJin.logger).to receive(:error).twice

        begin
          subject
        rescue YunJin::RequestError
          # Ignore
        end
      end
    end
  end

  describe '#user_timeline!' do
    subject do
      described_class.user_timeline!(user_id, start_date, end_date)
    end

    let :base_url do
      "#{YunJin::BASE_URL}/yunjin/api/v1/twitter/user-timeline"
    end

    let :options do
      {
        method:         :get,
        params:         {
          user_id: user_id,
          since:   start_date,
          until:   end_date
        },
        headers:        YunJin::HEADERS,
        followlocation: true
      }
    end

    let :user_id do
      '1234567890'
    end

    let :start_date do
      '2022-01-01'
    end

    let :end_date do
      '2022-01-10'
    end

    let :res_body do
      {
        tweets: []
      }.to_json
    end

    before :each do
      allow(Typhoeus::Request).to receive(:new).with(base_url, **options).and_return(request)
      allow(request).to receive(:run).and_return(response)
      allow(response).to receive(:body).and_return(res_body)
    end

    context '正しく取得できた場合' do
      before :each do
        allow(response).to receive(:success?).and_return(true)
        allow(JSON).to receive(:parse!).with(res_body, json_parse_options).and_return({ tweets: [] })
      end

      it 'JSONのレスポンスをパースして返すこと' do
        expect(JSON).to receive(:parse!).with(res_body, json_parse_options)

        subject
      end
    end

    context '正しく取得できなかった場合' do
      before :each do
        allow(response).to receive(:success?).and_return(false)
      end

      it '例外(YunJin::RequestError)が発生すること' do
        expect { subject }.to raise_error(YunJin::RequestError)
      end

      it 'エラーログが記録されること' do
        expect(YunJin.logger).to receive(:error).twice

        begin
          subject
        rescue YunJin::RequestError
          # Ignore
        end
      end
    end
  end

  describe '#all_tweets!' do
    let :user_id do
      '1234567890'
    end

    let :interval do
      10
    end

    let :wait do
      5
    end

    let :tweets do
      []
    end

    before :each do
      allow(described_class).to receive(:get_user_profile_by_id!).with(user_id).and_return({ join_date: '2022-01-01' })
      allow(Date).to receive(:today).and_return(Date.new(2022, 1, 25))
      allow(described_class).to receive(:user_timeline!).with(user_id, anything, anything).and_return(tweets)
      allow(Object).to receive(:sleep).and_return(nil)
    end

    context '正しく取得できた場合' do
      it '#user_timeline!を正しく呼び出すこと' do
        expect(described_class).to receive(:user_timeline!).once.ordered.with(user_id, '2022-01-01', '2022-01-11')
        expect(described_class).to receive(:user_timeline!).once.ordered.with(user_id, '2022-01-11', '2022-01-21')
        expect(described_class).to receive(:user_timeline!).once.ordered.with(user_id, '2022-01-21', '2022-01-31')

        described_class.all_tweets!(user_id, interval: interval, wait: wait) do |_|
          # Ignore
        end
      end

      it 'ブロックで与えられた処理を正しく呼び出すこと' do
        expect { |block| described_class.all_tweets!(user_id, interval: interval, wait: wait, &block) }.to yield_control.exactly(3)
      end
    end
  end
end
