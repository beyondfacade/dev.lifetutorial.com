#!/usr/bin/env bash
# 본선 대비 자료가 공개 사이트(지킬)에 섞여 들어갔는지 검사한다.
# com.lifetutorial/docs/시연대비/ 는 비공개 자료다 — 파일도, 내용도 이 저장소에 있으면 안 된다.
# 통과 = exit 0 / 유출 발견 = exit 1
#
# 사용: bash scripts/check-no-demo-prep.sh   (지킬 발행 전 필수)
set -uo pipefail

cd "$(dirname "$0")/.."

SELF="$(basename "$0")"

# ① 이름 표지 — 폴더·파일 이름. 규칙 문서(CLAUDE.md)는 이 이름을 적어야 하므로 예외.
NAME_MARKERS=(
  "시연대비"
  "예상질문"
)

# ② 내용 표지 — 비공개 문서 본문에만 나오는 문구. 규칙 문서를 포함해 어디에도 있으면 안 된다.
# 일반 기획 문서에도 나오는 말(심사위원·리허설·골든패스 등)은 오탐이 나므로 넣지 않는다.
CONTENT_MARKERS=(
  "D-Day 타임라인"
  "한 부 받아야 해요"
  "시작하기 전에 쓰는 게 원칙"
  "표준근로계약서 양식을 제가"
  "통과하는 표현"
)

# _site 는 빌드 산출물이라 원본을 고치면 함께 사라진다 — 검사 대상에서 제외
COMMON=(--binary-files=without-match -rn
        --exclude-dir=_site --exclude-dir=.git --exclude-dir=node_modules
        --exclude="$SELF")

found=0

scan() { # scan <마커> <추가 exclude...>
  local marker="$1"; shift
  local hits
  hits=$(grep "${COMMON[@]}" "$@" -- "$marker" . 2>/dev/null || true)
  if [ -n "$hits" ]; then
    echo "❌ 비공개 자료 표지 발견: '$marker'"
    echo "$hits" | sed 's/^/     /'
    found=1
  fi
}

for m in "${NAME_MARKERS[@]}"; do scan "$m" --exclude=CLAUDE.md; done
for m in "${CONTENT_MARKERS[@]}"; do scan "$m"; done

# 파일·디렉터리 이름으로도 확인
names=$(find . -path ./_site -prune -o -path ./.git -prune -o \
          \( -iname "*시연대비*" -o -iname "*예상질문*" \) -print 2>/dev/null || true)
if [ -n "$names" ]; then
  echo "❌ 비공개 자료 파일명 발견:"
  echo "$names" | sed 's/^/     /'
  found=1
fi

if [ "$found" -ne 0 ]; then
  echo
  echo "본선 대비 자료는 공개 사이트에 올리지 않는다. 해당 내용을 지우고 다시 실행할 것."
  exit 1
fi

echo "✅ 비공개 자료 유출 없음"
