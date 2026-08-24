---
layout: post
title: 개발 일지
permalink: /docs/devlog.html
date: 2026-08-24
categories: [dev-log, hackathon]
tags: [FastAPI, Next.js, Phaser, pgvector, RAG, DDD, Hexagonal]
---

> **프로젝트:** 라이프 튜토리얼 — AI 기반 게임형 실전 생활법률·금융 교육 플랫폼.
> 수능 직후 고3~사회초년생이 악덕 사장·중개인·보이스피싱범을 상대로 실전 리허설하며 노동·생활법률을 체득하는 AI 시뮬레이션 게임.
> **스택:** 백엔드 FastAPI + PostgreSQL(pgvector) / 프론트 Next.js 16 + React 19 + Phaser 4 + zustand + MSW.
> **아키텍처:** Hexagonal + Clean Architecture + DDD 기반 모듈러 모놀리스, "1 ERD 테이블 = 1 Fractal 11-File Set = 1 AI 위임 단위" 원칙으로 AI 하네스 엔지니어링.

---

## 2026-06-27 — 팀 구성

- 팀 프로필 문서 작성(`팀프로필.md`). 해커톤 예선 대비 팀 체계 정리.

## 2026-07-06 — 기획 문서 3종 확정 (v1.2)

- **PSST 사업계획서 v1.2**: 예비/초기창업패키지 표준 양식 기반. 교사용 대시보드 폐기 → 교사 관여 제로 B2G(기관 구매·바우처·자동 집계 리포트) 재구조화, 콜드스타트 해법을 또래 바이럴(결과 카드 공유·친구 대결)로 교체.
- **개발 정의서(DEVELOPMENT_SPEC) v1.2**: 기술 요구사항·ERD 초안·Decision Log(D-01~) 체계 수립.
- **UI/화면 정의서 v1.2**: 학생판 MVP 화면 설계(알바 연대기 챕터), 가드 촬영 품질 게이트, 또래·사전예약 화면.

## 2026-07-09 ~ 07-10 — 시스템 설계 다이어그램

- 시스템 아키텍처·플로우 다이어그램(drawio/png), MVP 플로우 별도 작성.
- 기술 스택 정리(`tech_life.md`), 워크플로 정리(`workflow_life.md`).

## 2026-07-28 ~ 07-31 — 예선 통과, 본선 대응 설계

- **해커톤 본선 대응 통합 정리서 v0.1** (7/28): 본선 일정이 '26.11 → **'26.9 첫 주로 당겨져 개발 기간 약 5주 확정**. 현장 로컬 평가 확정 → 웹 데모 필수(D-36). 심사 배점(참신성 30/구현 가능성 30/현장 실효성 30/보안성 10) 대응 전략과 검증 통계(임금체불 2조 678억, 청소년 알바 19.5% 근로계약서 미작성 등) 원출처 확보.
- **핵심 콘텐츠 설계서 4종** (7/31):
  - A1 퀘스트 상세설계서 — "근로계약서 쓰기" 퀘스트(대화 방어전 3단 방어선)
  - A2 판정 프롬프트 스펙 — LLM 판정 verdict 체계
  - A4 Fake 어댑터 데모 시나리오 — 오프라인 데모용 표준 시퀀스
  - A5 미니게임 콘텐츠
- 서비스 핵심 정리(데이터·게임·가드·리포트 4축) 문서화.

## 2026-08-02 — 백엔드 착수: core 인프라 + ontology BC (v0.1.0 ~ v0.5.0)

5주 실행 계획 v0.2 확정("3분 데모 시나리오에 나오는 것만 만든다" — 가드·리포트는 문서/목업으로 전환)과 함께 백엔드 개발 시작. 하루 만에 v0.1.0 → v0.5.0.

- **v0.1.0** — `core/matrix/` 전역 인프라 첫 파일: Seraph 인증 매니저(bcrypt 해싱 + JWT HS256, 테스트 7건).
- **v0.2.0~v0.2.1** — Keymaker 시크릿 매니저(시크릿 단일 서빙 지점), Oracle DB 매니저(공통 declarative Base + 트랜잭션 경계 세션), 의존성 정비.
- **v0.3.0** — 전 패키지 버전 고정, SQLModel 제거(Boundary Gate 원칙과 상충 → SQLAlchemy 2.0 단일화).
- **v0.4.0** — Alembic 마이그레이션 환경 구축(시크릿은 .env에서 주입, ini 미포함).
- **v0.5.0** — **ontology BC 첫 구현 (Fractal 파일 세트 풀 배선)**: 법제처 DRF API 법령 수집 게이트웨이 → Law/LawArticle/LawChunk 애그리거트 → pgvector cosine 검색까지. EmbeddingPort 어댑터 패턴(Gemini 온라인 / 로컬 오프라인 스텁, `.env` 한 줄로 전환). 근로기준법 132개 조문 → 284청크 수집·임베딩 E2E 실측. Docker Compose로 pgvector/pg17 DB(포트 5433) 기동.

## 2026-08-03 — 백엔드 데이터·판정 파이프라인 완성 (v0.6.0 ~ v0.9.0)

- **v0.6.0** — quest·npc BC 스캐폴딩(myself 엔드포인트 배선 검증, TDD). 시행령·시행규칙 추가 수집 → 총 11개 법령 1,051청크.
- **v0.7.0** — **로컬 임베딩 어댑터**(Qwen3-Embedding-4B, 1536차원 → 스키마 무변경) + provider별 벡터 공존 컬럼(온/오프라인 전환 1분 요건의 의도적 역정규화). 로컬 재임베딩 1,051청크 GPU 38초. **판정 API 1차** `POST /npc/judge` — Gemini Flash-Lite / EXAONE 7.8B(Ollama) 이중 어댑터, 안전장치 3종. A/B 1차에서 제재 주체 오인 케이스에 Gemini 오판정·EXAONE 정답 확인.
- **v0.8.0** — 행정규칙(admrul)·법령 별표 수집: 2026년 최저임금 고시(시간급 10,320원), 단순노무직종 지정 고시(수습 감액 함정 근거), 시행령 별표 7종. 첨부 PDF 본문 추출 폴백.
- **v0.9.0** — 고용노동부 수동 수집 문서 ingestion: 근로기준법 질의회시집 회시 399건 + 통상임금 노사지도 지침. **총 1,593청크 × 2개 벡터 공간(Gemini/로컬) 완성.**
- **실현가능성 검증 문서** 작성: "이미 돌아가고 수치로 측정했다" 원칙으로 전 파이프라인 실측 기록(RTX 5060 Ti 16GB). 계획 대비 W1 완료 + W2 조기 달성.
- **AI 모델 구성 v1 확정**: 온라인 Gemini / 오프라인 Qwen3-Embedding-4B + EXAONE 7.8B, 대사 생성만 외부 API(VRAM 16GB 예산).

## 2026-08-04 — ERD v1.0

- 서비스 4개 축(메인게임·미니게임·가드·리포트)을 테이블 구조로 번역한 **ERD v1.0** 확정. 설계 규칙: 1NF→3NF 정규화, 고립 테이블 금지, 1 테이블 = 1 Fractal 11-File Set.
- 기획서 보강(`4개층원리.md`, 주요특징·핵심기술).

## 2026-08-23 — 프론트엔드 집중 개발일: v0.1.0 → v0.6.3 하루 완주

FE-brief 확정(웹 데스크톱 퍼스트, Phaser는 허브맵만·나머지는 React DOM — 한글 IME 안전 설계)과 함께 프론트 스캐폴딩부터 게임 화면까지 하루에 구축.

- **v0.1.0 — 스캐폴딩**: Next.js + React 19 + TS strict + Tailwind 4. Phaser 4 안전 통합(EventBus 싱글턴, StrictMode 이중 마운트 가드), feature-sliced 디렉토리 골격, 포트 3100 고정, 하드코딩 localhost 0건.
- **v0.1.1 — Next.js 16.3.2 업그레이드**: Phaser 4.2.1 + Turbopack 조합 검증 통과, npm audit 0건.
- **v0.2.0 — 폰트·테마**: Galmuri11(픽셀) + Pretendard(법령 조문) self-host — 외부 CDN 참조 0건(폐쇄망 시연 요건). 게임 톤/유틸리티 톤 CSS 변수 체계.
- **v0.3.0 — API 계약 v1 + MSW 목 서버**: 엔드포인트 5종·이벤트 17종 계약(계약 우선 방식, 백엔드 구현 스펙의 원본). 키워드 판정기 + 실제 조문 원문(법제처 API 현행 기준) 목 데이터. `npm run check:contract` 10스텝 자동 검증 PASS.
- **v0.4.0 ~ v0.4.1 — 대화 방어전 화면**: useBattle 상태 머신(세션 멱등 시작·체크포인트 재개·판정 루프·방어선 돌파), **한글 IME 조합 중 Enter 가드**, 방어선 게이지 3단, 타이프라이터 대사, 근거 카드(조문 원문 렌더링). 팀장 지시로 웹 퍼스트 원칙 명문화 + 풀스크린 스테이지 레이아웃 재구성.
- **v0.5.0 — 허브맵(Phaser 4, D-37)**: ASCII 배열 맵 + 격자 이동(방향키/WASD)·벽 충돌·노드 상호작용. 진행 상태 SSOT는 zustand, 씬은 상태 미소유(`map:hydrate` 주입). EventBus 이중 인스턴스 번들 사고·StrictMode 리스너 전역 삭제 사고 두 건 해결.
- **v0.6.0 — 결과 화면**: 스탯 변동 카드 + "지켜낸 돈" 카운트업 연출, 체크포인트 localStorage 영속(새로고침 복귀), 클리어 시 다음 퀘스트 언락. check:contract 11스텝 PASS.
- **v0.6.1 ~ v0.6.3 — 실제 스프라이트 파이프라인**: 3면도 시트 크롭 → 마젠타 키잉 → 캔버스 정규화 → 48×48 네이티브 픽셀 퍼펙트 세트 교체. 허브맵 격자를 48px 기준(타일 32px, 맵 36×16 확장)으로 전환. 캐릭터 스프라이트 제작 규격 가이드 문서화.

## 2026-08-24 — 인증 풀스택 구현일: 백엔드 auth BC + 프론트 auth feature

설계서 승인 → 백엔드 → 프론트 → 실연동 검증까지 인증 기능을 하루에 관통. 게임 API 백엔드 이관 설계서도 확정.

- **설계 문서 2종 확정** (brainstorming 스킬 산출물, 사용자 승인):
  - 로그인·회원가입·구글 연동 설계서 + 구현 플랜 — 가입 필드(아이디·생년월일·비밀번호), 구글 로그인 후 생년월일 1회 온보딩, 게임 라우트 로그인 필수, access JWT는 메모리만·refresh는 HttpOnly 쿠키, DB에는 `birth_year`(연도)만 저장.
  - 게임 플레이 API 백엔드 이관 설계서 — quest BC 오케스트레이션 + npc `LlmJudgePort` 재사용, `JUDGE_PROVIDER=fake|gemini|exaone` Factory, `quest_session`/`player_stat` DB 영속, 콘텐츠 4테이블 + Q-ALBA-001~003 시드. (구현은 다음 단계)
- **백엔드 v0.10.0 — auth BC**: 아이디·생년월일·비밀번호 가입/로그인, 구글 OAuth(생년월일 1회 온보딩), access JWT(15분) + refresh HttpOnly 쿠키(7일, 매 갱신 rotate). 테이블 3종(`player`/`player_oauth`/`refresh_token`, Alembic), API 8종(`/api/v1/auth/*`), CORS localhost:3100 + credentials, **테스트 15건**.
- **백엔드 v0.10.1** — 구글 OAuth 실연동 준비: Keymaker `GOOGLE_*`/`FRONTEND_ORIGIN` 시크릿, CSRF `lt_oauth_state` 쿠키, 미설정 시 `GOOGLE_DENIED` 안전 폴백.
- **프론트 v0.7.0 — auth feature**: 로그인/회원가입/생년월일 온보딩/구글 버튼 UI, `AuthGate`로 게임 라우트 보호, `authStore`(accessToken 메모리 only — persist 금지) + `apiFetch` 401→refresh 자동 재시도, MSW auth 핸들러(`FALLBACK_MODE=1`에서도 전체 목 플로우).
- **프론트 v0.7.1** — 허브맵 헤더 로그아웃 버튼(access 폐기 + `/login` 이동).
- **프론트 v0.7.2** — `FALLBACK_MODE=0` 퀘스트 세션 404 수정: 게임 API는 MSW 유지, auth만 실백엔드 bypass하는 **하이브리드 모드** — 게임 API 이관 전까지의 과도기 구성.
- **개발 일지 워크플로 구축**: 전체 개발 이력을 본 문서로 정리하고 dev.lifetutorial.com 저장소로 이관, 일자별 자동 기록 크론 잡 가동.
- 다음 단계: 게임 플레이 API 백엔드 이관 구현(MSW 제거), 미니게임(CALC/DOC), 신규 캐릭터 에셋 파이프라인.

---

### 한눈에 보는 마일스톤

| 기간 | 단계 | 산출물 |
|---|---|---|
| 6/27 ~ 7/10 | 기획·설계 | 사업계획서·개발/UI 정의서 v1.2, 시스템 다이어그램 |
| 7/28 ~ 8/1 | 본선 대응 | 통합 정리서, 콘텐츠 설계서 A1~A5, 5주 실행 계획 |
| 8/2 ~ 8/4 | 백엔드 스프린트 | core 인프라 + ontology/quest/npc BC, 법령 1,593청크 × 2벡터 공간, 판정 API, ERD v1.0 |
| 8/23 | 프론트 스프린트 | 스캐폴딩 → API 계약/MSW → 방어전 → 허브맵 → 결과 화면 (v0.1.0→v0.6.3) |
| 8/24 | 인증 풀스택 | auth BC(BE v0.10.0~v0.10.1, 테스트 15건) + auth feature(FE v0.7.0~v0.7.2), 게임 API 이관 설계서 |

