#!/usr/bin/env bash
#
# テストを実行する
#
set -e;

bundle exec rspec;
bundle exec rubocop;
bundle exec bundle-audit check "$(dirname "${0}")/../" --update;

# テストの終了
echo -e "";
echo -e "\n  =========================\n";
echo -e "         TEST PASSED";
echo -e "\n  =========================\n";
echo -e "";
exit 0;
