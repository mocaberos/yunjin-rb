# frozen_string_literal: true

require_relative 'lib/yunjin/version'

Gem::Specification.new do |spec|
  spec.name = 'yunjin-rb'
  spec.version = YunJin::VERSION
  spec.authors = ['mocaberos']
  spec.email = ['mocaberos@gmail.com']

  spec.summary = 'yunjinクライアントライブラリ'
  spec.description = 'yunjinクライアントライブラリ'
  spec.homepage = 'https://github.com/mocaberos/yunjin-rb'
  spec.required_ruby_version = '>= 3.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/mocaberos/yunjin-rb'
  spec.metadata['changelog_uri'] = 'https://github.com/mocaberos/yunjin-rb/blob/master/CHANGELOG.md'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split('\x0').reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'typhoeus'

  spec.add_development_dependency 'bundle-audit'
  spec.add_development_dependency 'codecov'
  spec.add_development_dependency 'json_expressions'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rake'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'simplecov'

  spec.metadata = {
    'rubygems_mfa_required' => 'true'
  }
end
