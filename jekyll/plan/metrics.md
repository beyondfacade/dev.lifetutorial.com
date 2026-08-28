---
layout: default
title: 평가 지표 대시보드
permalink: /docs/metrics.html
nav_order: 10
---

# 평가 지표 대시보드

> **Status:** v0.1 (2026-08-28). 데이터 소스는 `_data/metrics.yml` (실측값 기반).
> 잔여 WIP·TODO 지표는 9/3 해커톤 전날인 **9/2까지 전부 산출 완료 예정** (매트릭스 셀의 `(~날짜)`가 마감일).
> 스타일: [Astryx](https://astryx.atmeta.com/) Neutral 테마 토큰 적용.

<div class="mx-eli5">
  <div class="mx-eli5-title">이 페이지 3줄 요약</div>
  <ol>
    <li>기능(게임·가드·리포트)마다 평가셋(시험 문제 모음)을 구축했다.</li>
    <li>지표마다 게이트(합격 기준선)를 정했다. 결과는 통과/미달로만 말한다.</li>
    <li>게이트를 통과할 때까지 수정하고 재평가했다. 아래 <span class="mx-badge mx-badge--pass">✓ PASS</span>는 게이트 통과, <span class="mx-badge mx-badge--progress">WIP</span>·<span class="mx-badge mx-badge--todo">TODO</span>는 산출 진행·예정이라는 뜻.</li>
  </ol>
</div>

{% assign cells = site.data.metrics.cells %}
{% assign pass_n = cells | where: "status", "pass" | size %}
{% assign prog_n = cells | where: "status", "progress" | size %}
{% assign todo_n = cells | where: "status", "todo" | size %}

<div class="mx-tiles">
  <div class="mx-tile">
    <div class="mx-tile-label">측정 셀</div>
    <div class="mx-tile-value">{{ cells | size }}</div>
  </div>
  <div class="mx-tile">
    <div class="mx-tile-label">게이트 통과</div>
    <div class="mx-tile-value">{{ pass_n }}</div>
  </div>
  <div class="mx-tile">
    <div class="mx-tile-label">산출 진행 (WIP)</div>
    <div class="mx-tile-value">{{ prog_n }}</div>
  </div>
  <div class="mx-tile">
    <div class="mx-tile-label">계측 예정 (TODO)</div>
    <div class="mx-tile-value">{{ todo_n }}</div>
  </div>
</div>

## 1. 지표 × 카테고리 매트릭스

행은 심사 지표, 열은 서비스 카테고리다. 같은 지표라도 카테고리마다 측정 대상이 다르다. "N/A" 셀도 일부러 내린 설계 결정이다. 예를 들어 실전 가드는 LLM을 배제한 결정론적 Rule 파이프라인이라, hallucination 계측 자체가 성립하지 않는다.

<div style="overflow-x: auto;">
<table>
  <thead>
    <tr>
      <th>심사 지표</th>
      {% for c in site.data.metrics.categories %}<th>{{ c.name }}<span class="mx-sub">{{ c.desc }}</span></th>{% endfor %}
    </tr>
  </thead>
  <tbody>
    {% for m in site.data.metrics.metrics %}
    <tr>
      <td><strong>{{ m.name }}</strong><span class="mx-sub">{{ m.eli5 }}</span></td>
      {% for c in site.data.metrics.categories %}
        {% assign cell = cells | where: "metric", m.id | where: "category", c.id | first %}
        <td>
          {% if cell == nil %}<span style="color: var(--mx-text-disabled);">·</span>
          {% elsif cell.status == "pass" %}<span class="mx-badge mx-badge--pass">✓ PASS</span><div class="mx-note">{{ cell.note | default: cell.name }}</div>
          {% elsif cell.status == "progress" %}<span class="mx-badge mx-badge--progress">WIP</span><div class="mx-note">{{ cell.plan }}{% if cell.deadline %} (~{{ cell.deadline | date: "%-m/%-d" }}){% endif %}</div>
          {% elsif cell.status == "todo" %}<span class="mx-badge mx-badge--todo">TODO</span><div class="mx-note">{{ cell.plan }}{% if cell.deadline %} (~{{ cell.deadline | date: "%-m/%-d" }}){% endif %}</div>
          {% elsif cell.status == "na" %}<span class="mx-badge mx-badge--na">N/A</span><div class="mx-note">{{ cell.note }}</div>
          {% endif %}
        </td>
      {% endfor %}
    </tr>
    {% endfor %}
  </tbody>
</table>
</div>

<details class="mx-glossary">
  <summary>표에 나오는 용어 풀이 (처음 보는 분용)</summary>
  <dl>
    <dt>게이트</dt>
    <dd>합격선. 시험 전에 "이 점수를 넘어야 통과"라고 미리 정해둔 기준. 느낌이 아니라 통과/미달로만 말하기 위한 장치다.</dd>
    <dt>오CLEAR</dt>
    <dd>게임이 틀린 발화를 정답으로 인정해버리는 것. 플레이어가 잘못된 법률 지식을 배우게 되므로 우리 서비스에서 가장 치명적인 오류로 취급한다.</dd>
    <dt>TRAP (날조 함정)</dt>
    <dd>시험지에 일부러 지어낸 정보를 섞어두고, AI가 속아서 그걸 사실처럼 말하는지 확인하는 함정 문제.</dd>
    <dt>v1 → v7</dt>
    <dd>같은 시험을 7번 봤다는 뜻. 회차마다 무엇을 고쳤는지가 아래 3번 섹션 표에 적혀 있다.</dd>
    <dt>페르소나 E2E</dt>
    <dd>가상의 사용자(페르소나)가 서비스를 처음부터 끝까지(End-to-End) 실제처럼 써보는 통합 시험.</dd>
    <dt>Historical Replay (소급 산출)</dt>
    <dd>과거의 실제 사용 기록을 다시 돌려서, 그때는 안 쟀던 점수를 지금 계산해내는 방법.</dd>
    <dt>RAG</dt>
    <dd>AI가 답하기 전에 관련 법령 원문을 먼저 찾아와 그 근거 안에서만 답하게 하는 기술. 지어내기를 구조적으로 막는다.</dd>
  </dl>
</details>

## 2. 게이트 대비 현황

정량 계측된 셀만 모아 "현재 실측값 / 게이트"와 진행률을 보여준다.

{% assign goal_cells = "" | split: "" %}
{% for cell in cells %}{% if cell.goal and cell.value != nil %}{% assign goal_cells = goal_cells | push: cell %}{% endif %}{% endfor %}

<div style="overflow-x: auto;">
<table>
  <thead>
    <tr><th>측정 항목</th><th>카테고리</th><th>현재 / 게이트</th><th style="min-width: 160px;">진행률</th></tr>
  </thead>
  <tbody>
    {% for cell in goal_cells %}
    {% assign cat = site.data.metrics.categories | where: "id", cell.category | first %}
    <tr>
      <td><strong>{{ cell.name }}</strong></td>
      <td>{{ cat.name }}</td>
      <td>{{ cell.value }}{{ cell.unit }} / {% if cell.direction == "down" %}≤{% endif %}{{ cell.goal }}{{ cell.unit }}{% if cell.gate %} <span class="mx-note" style="display: inline;">({{ cell.gate }})</span>{% endif %}</td>
      <td>
        {% if cell.direction == "down" %}
          {% if cell.value <= cell.goal %}<span class="mx-badge mx-badge--pass">✓ PASS</span>{% else %}<span class="mx-badge mx-badge--progress">초과</span>{% endif %}
        {% else %}
          {% assign pct = cell.value | times: 100.0 | divided_by: cell.goal | at_most: 100 | round %}
          <div class="mx-bar-row">
            <div class="mx-bar"><div class="mx-bar-fill" style="width: {{ pct }}%;"></div></div>
            <span class="mx-bar-pct">{{ pct }}%</span>
          </div>
        {% endif %}
      </td>
    </tr>
    {% endfor %}
  </tbody>
</table>
</div>

## 3. 평가 시계열 — 기능별 검증 이력

### 3-1. 상담 리포트 추출 정확도: 평가 v1→v7

계약서·인터뷰에서 핵심 필드(시급, 근무시간 등)를 얼마나 정확히 추출하는지 7회 평가한 기록이다. 게이트는 90%. 정체 구간(v2~v4)을 곡선으로 확인하고서야 모델을 교체했고(v5), 교체 직후 게이트를 통과했다. **"느낌으로 바꾼 게 아니라 정체 곡선을 보고 바꿨다."**

{% assign curve = cells | where: "metric", "accuracy" | where: "category", "report" | first %}
```mermaid
---
config:
  themeVariables:
    xyChart:
      plotColorPalette: "#2a78d6"
---
xychart-beta
  title "추출 값 일치율 (%), 게이트 90"
  x-axis [{% for h in curve.history %}{{ h.label }}{% unless forloop.last %}, {% endunless %}{% endfor %}]
  y-axis "값 일치 (%)" 0 --> 100
  line [{% for h in curve.history %}{{ h.value }}{% unless forloop.last %}, {% endunless %}{% endfor %}]
```

| 회차 | 점수 | 무슨 일이 있었나 |
|---|---|---|
{% for h in curve.history %}| {{ h.label }} | {{ h.value }}% | {{ h.note }} |
{% endfor %}

### 3-2. 메인게임 방어전 판정: 검증 배터리 이력

판정(CLEAR/HINT)의 치명 오류는 오CLEAR — 틀린 발화를 통과시켜 잘못된 법률 지식을 학습시키는 것이다. 정형 평가셋에서 시작해 실사용자 자연어 분포로 커버리지를 넓혀도 **오CLEAR 0이 유지**되는지가 게이트다. 수치가 전부 통과라 곡선 대신 배터리별 이력으로 기록한다.

{% assign judge = cells | where: "metric", "accuracy" | where: "category", "game" | first %}

| 날짜 | 평가셋 | 결과 | 비고 |
|---|---|---|---|
{% for b in judge.battery %}| {{ b.date }} | {{ b.set }} | **{{ b.result }}** | {{ b.note }} |
{% endfor %}

정형 평가셋(8/25)이 못 덮는 실사용자 자연어 분포를 8/27 배터리가 직접 플레이로 검증했다 — 두 층이 합쳐져 "오CLEAR 0"이 셋업된 수치가 아님을 증명한다 (§2).

### 3-3. 실전 가드 위반 검출: 룰 리그레션 6라운드

위반 검출은 오탐 1건이 서비스 신뢰를 무너뜨리는 영역이라 LLM 없이 결정론적 룰 19종으로 고정했다. 6라운드 전부 "실제 문서에서 실패 발견 → 원인 분석 → 룰 수정 → 회귀 테스트 고정"의 반복 — **LLM 없는 영역에서도 같은 개선 루프가 돈다** (§3).

{% assign rules = cells | where: "metric", "accuracy" | where: "category", "guard" | first %}

| 라운드 | 실패 (실측 증상) | 수정 | 유형 |
|---|---|---|---|
{% for r in rules.rounds %}| {{ r.round }} | {{ r.fail }} | {{ r.fix }} | {{ r.type }} |
{% endfor %}

---

**작동 방식**: 평가를 돌릴 때 `_data/metrics.yml`의 해당 셀 `history`에 한 줄을 추가하면, 이 페이지의 타일·매트릭스·차트가 전부 자동으로 갱신된다.
