---
layout: default
title: 단계별 개발 일정
permalink: /docs/sprint.html
parent: 일정 로드맵
has_children: true
nav_order: 1
---

## 스크럼 운영 방식

- **스프린트**: 1주 단위. 매주 일요일 회고에서만 범위 이동을 결정하며 P0(필수 범위)에 추가하는 것은 금지 — 범위는 줄이기만 가능.
- **데일리 공유**: 부트캠프 병행 특성상 비동기로 운영 — 커밋 로그와 [개발 일지]({{ "/docs/devlog.html" | relative_url }}) 일자별 자동 기록으로 대체.
- **역할**: 김충식(PM·기획·서류·발표) / 이은상(풀스택·QA) / 신채연(풀스택·디자인). 인원이 적고 일정이 짧아 프론트·백엔드 담당을 나누지 않고 교차로 작업했다. 아래 담당 표기는 해당 작업을 주도한 사람 기준.

## 스프린트 목록

각 스프린트를 클릭하면 일자별 업무 진행사항을 볼 수 있습니다.

| 스프린트 | 기간 | 목표 | 상태 |
|---|---|---|---|
| [Sprint 0 — 기획·설계]({{ "/docs/sprints/s0.html" | relative_url }}) | 6/27 ~ 7/29 | 기획 문서 3종, 시스템 설계, 본선 대응 설계 | ✅ 완료 |
| [Sprint 1 — 개발 씨앗]({{ "/docs/sprints/s1.html" | relative_url }}) | 7/30 ~ 8/3 | 백엔드 core 인프라 + RAG 파이프라인 + 판정 API | ✅ 완료 |
| [Sprint 2 — 예선 서류]({{ "/docs/sprints/s2.html" | relative_url }}) | 8/4 ~ 8/10 | ERD v1.0, 예선 기획서 완성·제출 | ✅ 완료 |
| [Sprint 3 — 예선 대기]({{ "/docs/sprints/s3.html" | relative_url }}) | 8/11 ~ 8/17 | 부트캠프 병행, 본선 대비 자산 정리 | ✅ 완료 |
| [Sprint 4 — 본선 개발 재개]({{ "/docs/sprints/s4.html" | relative_url }}) | 8/18 ~ 8/24 | 본선 확정(8/21) → 프론트 스프린트 + 인증 풀스택 | ✅ 완료 |
| [Sprint 5 — 통합·폴리싱]({{ "/docs/sprints/s5.html" | relative_url }}) | 8/25 ~ 8/31 | 게임 API 이관, 미니게임, 통합 리허설 | ✅ 완료 |
| [Sprint 6 — 제출·대회]({{ "/docs/sprints/s6.html" | relative_url }}) | 9/1 ~ 9/2 | 최종 결과물 제출, 발표·실제 플레이 시연 | ✅ 완료 |

## 칸반 보드 (9/1 기준)

<div class="kanban-wrap">
<div class="kanban-board">

<div class="kanban-col">
<h4>Backlog <span class="count">— 정식 출시 범위로 이월</span></h4>
<div class="kanban-card"><p class="card-title">2차 방어전 퀘스트 · 공유 카드 · 모바일 앱</p><div class="card-meta"><span class="tag tag-p2">P2</span></div></div>
</div>

<div class="kanban-col">
<h4>To Do</h4>
<div class="kanban-card"><p class="card-title">선택지 시뮬레이션 (부당해고)</p><div class="card-meta"><span class="tag tag-kim">김충식</span><span class="tag tag-shin">신채연</span><span class="tag tag-p1">P1</span></div></div>
<div class="kanban-card"><p class="card-title">외부망(집 와이파이 밖) 실동작 확인 · 긴 요청(리포트 ~30초) 터널 통과 — 본선 1일차</p><div class="card-meta"><span class="tag tag-lee">이은상</span><span class="tag tag-p0">P0</span></div></div>
<div class="kanban-card"><p class="card-title">실제 폰 사진으로 문서 점검 왕복 재확인 — OCR 상한 적용 후 인식 품질</p><div class="card-meta"><span class="tag tag-lee">이은상</span><span class="tag tag-p1">P1</span></div></div>
</div>

<div class="kanban-col">
<h4>In Progress</h4>
<div class="kanban-card"><p class="card-title">발표자료 · 시연 시나리오</p><div class="card-meta"><span class="tag tag-kim">김충식</span><span class="tag tag-p0">P0</span></div></div>
<div class="kanban-card"><p class="card-title">연출 폴리싱 — 잔여: 응답 스트리밍 · 클리어 사운드</p><div class="card-meta"><span class="tag tag-shin">신채연</span><span class="tag tag-p1">P1</span></div></div>
<div class="kanban-card"><p class="card-title">백엔드 안정화 — 잔여: 폴백 전환 절차 결함(리포트 모델 언로드) 반영</p><div class="card-meta"><span class="tag tag-lee">이은상</span><span class="tag tag-p0">P0</span></div></div>
<div class="kanban-card"><p class="card-title">OCR 입력 상한 — 코드·테스트 통과, 커밋·버전 반영 후 Done</p><div class="card-meta"><span class="tag tag-lee">이은상</span><span class="tag tag-p0">P0</span></div></div>
</div>

<div class="kanban-col kanban-done">
<h4>Done</h4>
<div class="kanban-card"><p class="card-title">법령 RAG 파이프라인 (1,593청크 × 2벡터)</p><div class="card-meta"><span class="tag tag-lee">이은상</span><span class="tag tag-p0">P0</span></div></div>
<div class="kanban-card"><p class="card-title">판정 API — Gemini/EXAONE 이중화</p><div class="card-meta"><span class="tag tag-lee">이은상</span><span class="tag tag-p0">P0</span></div></div>
<div class="kanban-card"><p class="card-title">ERD v1.0 · 설계 문서 체계</p><div class="card-meta"><span class="tag tag-kim">김충식</span><span class="tag tag-p0">P0</span></div></div>
<div class="kanban-card"><p class="card-title">방어전 → 허브맵 → 결과 화면 (FE v0.6.3)</p><div class="card-meta"><span class="tag tag-shin">신채연</span><span class="tag tag-p0">P0</span></div></div>
<div class="kanban-card"><p class="card-title">인증 풀스택 (BE v0.10 / FE v0.7)</p><div class="card-meta"><span class="tag tag-lee">이은상</span><span class="tag tag-shin">신채연</span><span class="tag tag-p0">P0</span></div></div>
<div class="kanban-card"><p class="card-title">예선 기획서 제출 → 본선 진출 확정</p><div class="card-meta"><span class="tag tag-kim">김충식</span></div></div>
<div class="kanban-card"><p class="card-title">게임 플레이 API 백엔드 이관 (MSW 제거)</p><div class="card-meta"><span class="tag tag-lee">이은상</span><span class="tag tag-p0">P0</span></div></div>
<div class="kanban-card"><p class="card-title">신규 캐릭터 에셋 파이프라인</p><div class="card-meta"><span class="tag tag-shin">신채연</span><span class="tag tag-p1">P1</span></div></div>
<div class="kanban-card"><p class="card-title">계산 미니게임 (주휴수당 던전)</p><div class="card-meta"><span class="tag tag-shin">신채연</span><span class="tag tag-p1">P1</span></div></div>
<div class="kanban-card"><p class="card-title">판정 평가셋 실측 · 오입력 내성</p><div class="card-meta"><span class="tag tag-lee">이은상</span><span class="tag tag-p1">P1</span></div></div>
<div class="kanban-card"><p class="card-title">통합 리허설 · 심사위원 타이핑 시나리오</p><div class="card-meta"><span class="tag tag-all">전원</span><span class="tag tag-p0">P0</span></div></div>
<div class="kanban-card"><p class="card-title">실전 가드 (계약서 AI 진단)</p><div class="card-meta"><span class="tag tag-lee">이은상</span><span class="tag tag-shin">신채연</span><span class="tag tag-p2">P2</span></div></div>
<div class="kanban-card"><p class="card-title">상담 준비 리포트</p><div class="card-meta"><span class="tag tag-lee">이은상</span><span class="tag tag-shin">신채연</span><span class="tag tag-p2">P2</span></div></div>
<div class="kanban-card"><p class="card-title">시연 배포 실행 (B안) — 실도메인 화면·API, CORS·쿠키·OAuth·노출 대응</p><div class="card-meta"><span class="tag tag-lee">이은상</span><span class="tag tag-p0">P0</span></div></div>
<div class="kanban-card"><p class="card-title">프론트 프로덕션 빌드 배포 (Vercel)</p><div class="card-meta"><span class="tag tag-shin">신채연</span><span class="tag tag-p0">P0</span></div></div>
<div class="kanban-card"><p class="card-title">방어전 턴 지연 제거 — 임베딩 429 지수 백오프 (28초 → 0.4초)</p><div class="card-meta"><span class="tag tag-lee">이은상</span><span class="tag tag-p0">P0</span></div></div>
<div class="kanban-card"><p class="card-title">상담 준비 리포트 PDF 인쇄 복구 (A4 전폭)</p><div class="card-meta"><span class="tag tag-shin">신채연</span><span class="tag tag-p1">P1</span></div></div>
<div class="kanban-card"><p class="card-title">최종 결과물 패키징 — 실도메인 배포로 갈음, 심사위원 직접 플레이</p><div class="card-meta"><span class="tag tag-kim">김충식</span><span class="tag tag-p0">P0</span></div></div>
</div>

</div>
</div>

> 8/30 기준 대비 이동: 8/30에 To Do로 올렸던 **시연 배포 실행·검증(B안)** 과 **프론트 프로덕션 빌드**는 8/31에 실도메인 배포까지 마쳐 Done으로 올라갔다(노출 대응 — 판정 API 인증·API 자동 문서 차단·CORS·쿠키 Secure·OAuth 리디렉트 포함). 9/1에는 **방어전 턴 지연(임베딩 429 고정 25초 대기 → 지수 백오프, 28초 → 중앙값 0.4초)** 과 **리포트 PDF 인쇄 복구**가 Done으로 들어왔고, **OCR 입력 상한**은 코드·테스트가 통과했으나 커밋·버전 반영 전이라 In Progress에 둔다. 배포가 끝나면서 To Do에는 **외부망 실동작 확인 + 긴 요청 터널 통과**(본선 1일차)와 **실제 폰 사진 문서 점검 왕복 재확인**이 새로 올라왔다. **최종 결과물 패키징**은 별도 빌드 산출물을 넘기는 대신 실도메인 배포로 갈음하기로 정리해 Done으로 옮겼다 — 심사위원이 브라우저에서 바로 플레이한다. 연출 폴리싱(응답 스트리밍·클리어 사운드)과 선택지 시뮬레이션은 그대로 잔여다.

담당 표기: <span class="tag tag-kim">김충식</span> PM·기획 / <span class="tag tag-lee">이은상</span> 풀스택·QA / <span class="tag tag-shin">신채연</span> 풀스택·디자인 — 작업을 주도한 사람 기준이며 프론트·백엔드 구분 없이 교차 작업. 우선순위: <span class="tag tag-p0">P0</span> 데모 필수 / <span class="tag tag-p1">P1</span> 여력분 / <span class="tag tag-p2">P2</span> 이월.

