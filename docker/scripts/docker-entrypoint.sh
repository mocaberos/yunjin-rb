#!/usr/bin/env bash
#
# Docker エントリーポイント
# @note 与えられた引数はシェルスクリプトとして実行される
#
set -e;

exec "$@";
