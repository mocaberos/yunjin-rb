# frozen_string_literal: true

require 'yunjin'
require 'typhoeus'

RSpec.describe YunJin::V1APIs::Sys do
  let :base_url do
    "#{YunJin::BASE_URL}/yunjin/api/v1/sys/health"
  end

  let :options do
    {
      method:         :get,
      headers:        YunJin::HEADERS,
      followlocation: true
    }
  end

  let :request do
    Typhoeus::Request.new(base_url, **options)
  end

  let :response do
    Typhoeus::Response.new
  end

  before :each do
    allow(Typhoeus::Request).to receive(:new).with(base_url, **options).and_return(request)
    allow(request).to receive(:run).and_return(response)
  end

  describe '#health?' do
    subject do
      described_class.health?
    end

    context 'ヘルスチェックが通る場合' do
      before :each do
        allow(response).to receive(:success?).and_return(true)
      end

      it 'trueを返すこと' do
        expect(subject).to be true
      end
    end

    context 'ヘルスチェックが通らない場合' do
      before :each do
        allow(response).to receive(:success?).and_return(false)
      end

      it 'falseを返すこと' do
        expect(subject).to be false
      end

      it 'ワーニングログが記録されること' do
        expect(YunJin.logger).to receive(:warn).once

        subject
      end
    end
  end

  describe '#health!' do
    subject do
      described_class.health!
    end

    context 'ヘルスチェックが通る場合' do
      before :each do
        allow(response).to receive(:success?).and_return(true)
      end

      it '例外が発生しないこと' do
        expect { subject }.not_to raise_error
      end
    end

    context 'ヘルスチェックが通らない場合' do
      before :each do
        allow(response).to receive(:success?).and_return(false)
      end

      it '例外(YunJin::RequestError)が発生すること' do
        expect { subject }.to raise_error(YunJin::RequestError)
      end

      it 'ワーニングログが記録されること' do
        expect(YunJin.logger).to receive(:warn).once

        begin
          subject
        rescue YunJin::RequestError
          # Ignore
        end
      end
    end
  end
end
