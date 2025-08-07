# 📚 프로젝트 문서

## 📌 개요
Flutter 크리에이터 구독 플랫폼 프로젝트의 기술 문서 모음입니다.

## 📁 문서 구조

### 📋 MD 파일 시스템
- **[MD 표준 가이드](./MD_STANDARDS.md)** - Markdown 파일 작성 표준 및 스타일 가이드
- **[MD 시스템 적용 가이드](./MD_SYSTEM_SETUP_GUIDE.md)** - MD 파일 시스템 구축 및 적용 방법

### 🛠️ 개발 문서
- **[개발 가이드](./DEVELOPMENT.md)** - 개발 환경 설정 및 개발 프로세스
- **[기능 명세](./FEATURES.md)** - 주요 기능 및 구현 상세
- **[요구사항](./REQUIREMENTS.md)** - 프로젝트 요구사항 및 스펙

### 🔧 설정 및 배포
- **[Firebase 설정](../FIREBASE_SETUP.md)** - Firebase 프로젝트 설정 가이드

## 🎯 문서 작성 원칙

### 일관성
- 모든 문서는 [MD 표준 가이드](./MD_STANDARDS.md)를 준수
- 동일한 용어와 포맷 사용
- 계층적 정보 구성 유지

### 가독성
- 명확하고 간결한 문장 사용
- 적절한 예시와 코드 블록 포함
- 시각적 요소(이모지, 표, 다이어그램) 활용

### 유지보수성
- 정기적인 문서 업데이트
- 변경 이력 추적
- 깨진 링크 및 오래된 정보 정리

## 📝 문서 작성 워크플로우

### 1. 새 문서 작성
```bash
# 1. MD 표준 확인
cat docs/MD_STANDARDS.md

# 2. 템플릿 활용
cp docs/templates/TEMPLATE.md docs/NEW_DOC.md

# 3. 내용 작성
code docs/NEW_DOC.md

# 4. 린트 체크
markdownlint docs/NEW_DOC.md --fix
```

### 2. 문서 업데이트
```bash
# 1. 변경사항 확인
git diff docs/

# 2. 문서 수정
code docs/TARGET.md

# 3. 목차 업데이트 (필요시)
markdown-toc -i docs/TARGET.md

# 4. 변경 이력 기록
# 문서 하단 또는 CHANGELOG.md에 기록
```

### 3. 문서 검증
```bash
# 린트 검사
npm run md:lint

# 링크 확인
npm run md:check-links

# 포맷 검증
npm run md:format
```

## 🔗 빠른 참조

### 주요 명령어
```bash
# FVM Flutter 실행
fvm flutter run -d chrome --hot

# 코드 생성
fvm flutter pub run build_runner build --delete-conflicting-outputs

# 테스트 실행
fvm flutter test
```

### 프로젝트 구조
```
lib/
├── core/          # 핵심 유틸리티
├── data/          # 데이터 레이어
├── domain/        # 도메인 레이어
└── presentation/  # 프레젠테이션 레이어
```

## 🤝 기여 가이드

### 문서 기여 방법
1. [MD 표준 가이드](./MD_STANDARDS.md) 숙지
2. 브랜치 생성: `docs/기능명`
3. 문서 작성 또는 수정
4. 린트 검사 통과
5. PR 생성 및 리뷰 요청

### 문서 리뷰 체크리스트
- [ ] MD 표준 준수 여부
- [ ] 링크 유효성
- [ ] 코드 예제 정확성
- [ ] 목차와 내용 일치
- [ ] 변경 이력 기록

## 📊 문서 상태

| 문서명 | 최종 수정일 | 상태 | 담당자 |
|--------|------------|------|--------|
| MD_STANDARDS.md | 2024-01-15 | ✅ 완료 | - |
| MD_SYSTEM_SETUP_GUIDE.md | 2024-01-15 | ✅ 완료 | - |
| DEVELOPMENT.md | 2024-01-14 | ✅ 완료 | - |
| FEATURES.md | 2024-01-14 | ✅ 완료 | - |
| REQUIREMENTS.md | 2024-01-13 | ✅ 완료 | - |

## 🔍 검색 키워드

### 기술 스택
`Flutter`, `Riverpod`, `Clean Architecture`, `FVM`, `Firebase`

### 주요 기능
`구독`, `콘텐츠`, `크리에이터`, `결제`, `채팅`

### 문서 타입
`가이드`, `명세`, `설정`, `API`, `아키텍처`

## 📞 문의

문서 관련 문의사항이나 개선 제안은 다음 채널을 통해 연락주세요:
- GitHub Issues
- 프로젝트 Slack 채널
- 이메일: project@example.com

---
*문서는 지속적으로 업데이트됩니다.*
*최종 수정: 2024-01-15*