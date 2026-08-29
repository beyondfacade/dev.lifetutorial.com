# CLAUDE.md

## 0. 발행 경계 — 비공개 자료 반입 금지 (최우선)

**이 저장소는 공개 사이트다. `com.lifetutorial/docs/시연대비/` 는 본선 대비용 비공개 자료이며, 파일도 내용도 여기로 옮겨오지 않는다.**

- 대상: `시연대비/` 폴더 전체 — `시연대비.md`(골든패스·런북·장애 대응), `예상질문.md`, `메인게임.md`(단계별 정답·통과 표현), 이후 추가되는 모든 파일
- 금지 범위는 파일 복사뿐 아니라 **요약·인용·부분 발췌**까지 포함한다. 개발일지에 "리허설했다"는 사실은 적어도 되지만, **대본 문장·정답·예상질문 답변은 옮기지 않는다**
- 개발일지(`jekyll.md`)를 채울 때 `docs/시연대비/`를 출처로 삼지 않는다. 출처는 코드·커밋·버전 로그다
- **발행 전 필수**: `bash scripts/check-no-demo-prep.sh` 를 실행해 통과(exit 0)를 확인한다. 실패하면 해당 내용을 지우고 다시 실행한다

과거에 이 자료가 이 저장소로 넘어온 적이 있다. 규칙을 기억에 의존하지 말고 위 스크립트로 확인할 것.

---

Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

---

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.