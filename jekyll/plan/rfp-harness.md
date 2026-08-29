# 📋 공공 SW사업 RFP 기반 클로드 코드(Claude Code) 실행 하네스

> **프로젝트명**: 법령 원문 RAG와 LLM 대화 시뮬레이션 기술을 활용한 고3~사회초년생 실전 생활법률 '행동 훈련' 및 근로계약서 AI 진단 서비스 — 라이프 튜토리얼(Life Tutorial)
> **수행 주체**: 팀 BeyondFacade (2026년 제8회 K-디지털 트레이닝 해커톤 본선 출품)
> **규격 가이드**: 정보관리기술사 기준 공공 SW사업 제안요청서(RFP) 상세 요구사항 표준 준용

---

## 🎯 1. 하네스 목적 및 AI 행동 규칙

본 문서는 Claude Code가 라이프 튜토리얼 개발 환경(FastAPI + PostgreSQL/pgvector, Next.js 16 + Phaser 4)에서 코드 및 산출물을 생성할 때 **요구사항의 명확성, 추적성, 검증성**을 보장하기 위한 실행 가이드이다.

### Claude Code 필수 준수 규칙 (Rule Set)

1. **[명확성]** 모호한 표현 금지. "빠르게 처리" → "오프라인 폴백 전환 1분 이내", "잘 검색" → "'주휴수당' 검색 시 근로기준법 제55조 top-1".
2. **[원자성]** **"1 ERD 테이블 = 1 프랙탈 11-파일 세트 = 1 AI 위임 단위"** — 복합 기능은 BC(Bounded Context)·요구 ID 단위로 독립 검증 가능하도록 모듈화 작성.
3. **[추적성]** 생성되는 모든 코드/테스트/설정 파일 상단에 관련 `요구 ID`를 주석으로 명시.
4. **[검증성]** 요구사항별 검수 기준(Acceptance Criteria)에 명시된 테스트 코드를 함께 생성. 백엔드 PyTest, 프론트 `check:contract` 계약 검증.
5. **[경계 규칙]** 타입 변환(mapper)은 Router·Repository 경계에서만 수행(Boundary Gate). UseCase~Repository 구간에 Schema/ORM 객체 진입 금지.

---

## 🏗️ 2. 시스템 아키텍처 및 3인 R&R 구성

```
[ Frontend ]                          [ Backend: 모듈러 모놀리스 ]

Next.js 16 (App Router)  --Proxy-->   FastAPI (Hexagonal + DDD)
├── React 19 / Tailwind 4 / TS       ├── ontology BC — 법령 수집·RAG 검색
├── Phaser 4 (허브맵 전용)            ├── npc BC — LLM 판정 (Gemini/EXAONE 이중화)
├── zustand (상태 SSOT)              ├── quest BC — 방어전 오케스트레이션
└── MSW (계약 우선 목 서버)           └── auth BC — JWT/구글 OAuth

                                      PostgreSQL 17 + pgvector (벡터 공간 2종)
```

### 3인 개발 R&R 및 모듈 디렉토리

- **김충식 (PM/설계·콘텐츠)**: 퀘스트 상세설계서(A1)·판정 프롬프트 스펙(A2), ERD·Decision Log, 시나리오 콘텐츠, 통합 QA, 서류·발표
- **이은상 (BE/RAG·QA)**: `backend/` — ontology·quest·npc·auth BC, 법령 ingestion 파이프라인, 판정 API, 테스트
- **신채연 (FE/디자인)**: `frontend/` — 대화 방어전·허브맵·결과 화면, 스프라이트 에셋 파이프라인, 연출 폴리싱

---

## 📊 3. 상세 요구사항 명세표 (RFP Requirement Traceability)

### 3.1 기술·기능 영역 (SFR)

| 요구 ID | 요구 분류 | 정의 및 세부 내용 | 산출 정보 / 코드 위치 | 검수 기준 |
| :--- | :--- | :--- | :--- | :--- |
| **SFR-001** | 법령 수집 | 법제처 DRF API 법령·행정규칙·별표 수집, 조문 청킹·임베딩 | `backend/` ontology BC | **11개 법령 1,593청크** 임베딩 완료, "주휴수당" 검색 시 제55조 **top-1** |
| **SFR-002** | RAG 검색 | pgvector cosine 검색, 온라인(Gemini)/오프라인(Qwen3-Embedding-4B) 이중 벡터 공간 | ontology BC 검색 어댑터 | `.env` 1줄로 provider 전환, 재임베딩 없이 즉시 동작 |
| **SFR-003** | LLM 판정 | 자유 텍스트 발화 → ONGOING/CLEAR/HINT_NEEDED 판정, 근거 조문 반환 | npc BC `POST /npc/judge` | 판정 평가셋(방어선별 라벨 발화) 정확도 실측 리포트, 애매 발화 정답 처리 **0건**(보수 판정) |
| **SFR-004** | 방어전 UI | 방어선 3단 게이지, 근거 조문 카드, 타이프라이터 대사, 3턴 힌트 폴백 | `frontend/` 방어전 feature | 웹에서 1퀘스트 **E2E 클리어**, 한글 IME 조합 중 Enter 오전송 **0건** |
| **SFR-005** | 허브맵·결과 | Phaser 격자 이동·노드 상호작용, 스탯 상승·"지켜낸 돈" 카운트업, 체크포인트 | `frontend/` 허브맵·결과 feature | 새로고침 후 체크포인트 복귀, 클리어 시 다음 퀘스트 언락 |
| **SFR-006** | 인증 | 아이디·생년월일 가입/로그인, 구글 OAuth(생년월일 1회 온보딩), 게임 라우트 보호 | auth BC + `frontend/` AuthGate | 테스트 **15건 통과**, 비로그인 게임 라우트 접근 차단 |

### 3.2 품질·검증 영역 (PER / SEC / QUA)

| 요구 ID | 요구 분류 | 정의 및 세부 내용 | 산출 정보 / 코드 위치 | 검수 기준 |
| :--- | :--- | :--- | :--- | :--- |
| **PER-001** | 시연 안정성 | 인터넷 차단 시 Fake 어댑터로 동일 시연 (P0-4) | npc BC Fake 어댑터 + FE FALLBACK_MODE | 네트워크 차단 리허설 통과, 전환 **1분 이내** |
| **PER-002** | 응답 체감 | 판정 응답 스트리밍 및 대사 타이프라이터 연출로 대기 체감 제거 | npc BC + 방어전 화면 | 판정 1턴 왕복 curl 검증, 스트리밍 렌더 확인 |
| **SEC-001** | 통신 보안 | access JWT(15분) 메모리 보관, refresh HttpOnly 쿠키(7일, rotate), CORS credentials 제한 | auth BC + `frontend/` apiFetch | 미인증 요청 **401 차단**, refresh rotate 동작, CSRF state 쿠키 검증 |
| **SEC-002** | 개인정보 | 최소 수집 원칙 — 생년월일은 `birth_year`(연도)만 저장, 대화 로그 PII 마스킹 | auth BC 스키마, dialogue_turn 로깅 | DB에 연도 외 생년월일 원본 **부재**, 로그 마스킹 확인 |
| **QUA-001** | 테스트 | BC별 TDD, 프론트 API 계약 자동 검증 | `backend/tests/`, `check:contract` | auth BC 테스트 15건 등 기능별 테스트 동반, 계약 검증 **11스텝 PASS** |
| **QUA-002** | 오입력 내성 | 욕설·"ㅋㅋ"·무관 발화·빈 입력에 NPC가 자연스럽게 대응 (심사위원 직접 타이핑 대비) | npc BC 판정 프롬프트 | 오입력 **10케이스 통과** |

---

## 💻 4. 클로드 코드 태스크 프롬프트 (Execution Directives)

Sprint 5(8/25~8/31)에 투입한 실행 지시문이다. 아래 Task 1~3은 모두 완료됐다 — 게임 API 이관 8/24, 계산 미니게임 8/25, 판정 평가셋 실측 8/27~8/28.

### [Task 1] 게임 플레이 API 백엔드 이관 (MSW 제거)

```bash
claude "docs/rfp-harness.md와 게임 API 이관 설계서에 따라 게임 플레이 API를 백엔드로 이관해줘.
1. quest BC 오케스트레이션 + npc LlmJudgePort 재사용, JUDGE_PROVIDER=fake|gemini|exaone Factory 구성
2. quest_session / player_stat DB 영속화 (Alembic 마이그레이션 포함)
3. 콘텐츠 4테이블 + Q-ALBA-001~003 시드 데이터
4. 프론트 하이브리드 모드 해제 — 게임 API의 MSW 의존 제거
5. 모든 생성 파일 상단에 [SFR-003][SFR-004] 요구 ID 주석, BC별 PyTest 동반 (QUA-001)"
```

### [Task 2] 판정 평가셋 실측 (SFR-003 / QUA-002 검수)

```bash
claude "SFR-003 검수 기준에 따라 판정 품질을 실측해줘.
1. 방어선 3단별 라벨 발화 20~30개 평가셋 구성 (CLEAR/ONGOING/HINT_NEEDED 라벨)
2. Gemini/EXAONE 각각 정확도 측정 스크립트 작성 및 결과 리포트 생성 — 수치는 발표자료 인용용
3. 오입력 10케이스(욕설·ㅋㅋ·무관 발화·빈 입력) 통과 여부 포함 (QUA-002)
4. 불확실 판정은 HINT_NEEDED로 폴백하는 보수 판정 원칙 준수 확인"
```

### [Task 3] 계산 미니게임 — 주휴수당 던전 (P1-1)

```bash
claude "A5 미니게임 설계서에 따라 주휴수당 계산 미니게임을 구현해줘.
- 조건 제시 → 숫자 입력 → 정오 판정 + 근거 해설 (LLM 호출 불요, 순수 로직)
- frontend/ 미니게임 feature로 구현, 허브맵 노드에서 진입·복귀
- 계산 로직 단위 테스트 동반, 파일 상단 [SFR-005] 주석 (QUA-001)"
```

---

## 🔍 5. RFP 기반 추적성 검증 체크리스트 (Verification Matrix)

개발 완료 후 Claude Code가 스스로 수행할 검증 루틴:

- [ ] **[추적성 검사]** 구현된 모든 소스 파일 상단에 `# Requirement ID: SFR-XXX` 주석이 작성되어 있는가?
- [ ] **[모의 검수]** `pytest` 수행 시 SFR-003·SFR-006·QUA-001 검수 기준 통과 여부가 출력되는가?
- [ ] **[계약 검증]** `npm run check:contract`가 전 스텝 PASS인가? (프론트-백엔드 API 계약 일치)
- [ ] **[오프라인 리허설]** 네트워크 차단 상태에서 방어전→결과 화면 E2E 시연이 되는가? (PER-001)
- [ ] **[보안 검사]** 비로그인 게임 라우트 접근이 차단되고, 미인증 API 요청이 401로 떨어지는가? (SEC-001)
- [ ] **[문서화]** `.env.example`에 법제처 API·GOOGLE_*·JUDGE_PROVIDER·EMBEDDING_PROVIDER·DB 접속 정보가 빠짐없이 정의되어 있는가?

---

### 💡 사용 방법 안내

1. 본 문서는 dev.lifetutorial.com의 `docs/rfp-harness.md`로 관리하며, 개발 리포에서는 CLAUDE.md와 함께 참조한다.
2. 터미널에서 Claude Code 실행 시 아래와 같이 프롬프트를 전달하면 위 명세를 준수하며 코드를 작성한다:

```bash
claude "docs/rfp-harness.md를 읽고 [Task 1]을 먼저 수행해줘."
```
