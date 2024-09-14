#!/usr/bin/env zsh

# エラーが発生した場合，その瞬間止める
set -e

if [ -d .git ]; then
  # カレントブランチを取得
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  if [ $current_branch = "main" ]; then
    exit 0
  fi
  # リモートレポジトリが存在するか確認
  git remote get-url origin > /dev/null 2>&1
  if git remote get-url origin > /dev/null 2>&1; then
    # キャッシュ
    if [ -e /tmp/current_pr_state ]; then
      cache_current_branch="$(cat /tmp/current_branch)"
      if [ $cache_current_branch = $current_branch ]; then
        echo -e "$(cat /tmp/current_pr_state)"
        exit 0
      fi
    fi

    # プルリクエストの番号と状態を取得
    pr=$(gh pr view $current_branch --json number,state > /dev/null 2>&1)

    # 変数に代入
    read number state <<< $(gh pr view $current_branch --json number,state --template '{{ .number }} {{ .state }}')
    
    if [ "$state" = "OPEN" ]; then
      state="\e[32m Open"
    elif [ "$state" = "MERGED" ]; then
      state="\e[35m Merged"
    elif [ "$state" = "CLOSED" ]; then
      state="\e[31m Closed"
    fi

    echo "${current_branch}" > /tmp/current_branch
    echo -e "${state} #${number}\e[m" > /tmp/current_pr_state
    echo -e "${state} #${number}\e[m"
  fi
fi

