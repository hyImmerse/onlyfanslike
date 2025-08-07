# 팀 온보딩 가이드

## 📌 개요
새로운 팀원이 프로젝트에 빠르게 적응할 수 있도록 돕는 온보딩 가이드입니다.

## 🎯 목표
- 개발 환경 빠른 설정
- 프로젝트 구조 이해
- 팀 협업 프로세스 숙지
- 첫 기여까지 1일 이내 완료

## 🚀 Day 1: 환경 설정

### 1단계: 필수 도구 설치

```bash
# 1. Flutter SDK (FVM 사용)
curl -fsSL https://fvm.app/install.sh | bash
fvm install 3.32.5
fvm use 3.32.5

# 2. IDE 설치 (택 1)
# VS Code
https://code.visualstudio.com/

# Cursor (권장 - AI 지원)
https://cursor.sh/

# 3. Git 설정
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### 2단계: 프로젝트 클론 및 설정

```bash
# 프로젝트 클론
git clone [프로젝트 URL]
cd contents

# FVM 설정
fvm use 3.32.5

# 의존성 설치
fvm flutter pub get

# 코드 생성
fvm flutter pub run build_runner build --delete-conflicting-outputs

# 개발 서버 실행
fvm flutter run -d chrome --hot
```

### 3단계: IDE 설정

#### VS Code 확장 설치
```bash
# 필수 확장
code --install-extension Dart-Code.flutter
code --install-extension Dart-Code.dart-code
code --install-extension yzhang.markdown-all-in-one
code --install-extension DavidAnson.vscode-markdownlint

# 권장 확장
code --install-extension usernamehw.errorlens
code --install-extension PKief.material-icon-theme
```

#### Cursor 설정
1. `.cursor-settings` 파일이 자동으로 로드됨
2. CLAUDE.md 파일이 컨텍스트로 자동 인식됨

## 📚 Day 2: 프로젝트 이해

### 필수 문서 읽기 순서

1. **[README.md](./README.md)** - 프로젝트 개요 (30분)
2. **[CLAUDE.md](./CLAUDE.md)** - AI 컨텍스트 파일 (15분)
3. **[docs/DEVELOPMENT.md](./docs/DEVELOPMENT.md)** - 개발 가이드 (45분)
4. **[docs/FEATURES.md](./docs/FEATURES.md)** - 기능 명세 (30분)
5. **[docs/MD_STANDARDS.md](./docs/MD_STANDARDS.md)** - 문서 작성 표준 (20분)

### 프로젝트 구조 이해

```
lib/
├── core/           # 공통 유틸리티
│   ├── constants/  # 상수 정의
│   ├── router/     # 라우팅 설정
│   ├── theme/      # 테마 설정
│   └── utils/      # 유틸리티 함수
│
├── data/           # 데이터 레이어
│   ├── datasources/# 데이터 소스
│   ├── models/     # 데이터 모델
│   └── repositories/# Repository 구현
│
├── domain/         # 도메인 레이어
│   ├── entities/   # 비즈니스 엔티티
│   ├── repositories/# Repository 인터페이스
│   └── usecases/   # 유즈케이스
│
└── presentation/   # 프레젠테이션 레이어
    ├── pages/      # 전체 화면
    ├── providers/  # Riverpod 프로바이더
    └── widgets/    # 재사용 위젯
```

### 핵심 기술 스택

| 기술 | 버전 | 용도 |
|------|------|------|
| Flutter | 3.32.5 | 프레임워크 |
| Riverpod | 2.4.9 | 상태 관리 |
| go_router | 13.2.0 | 라우팅 |
| Freezed | 2.4.6 | 코드 생성 |
| Firebase | 준비됨 | 백엔드 (주석 처리) |

## 🤝 Day 3: 첫 기여

### 작업 프로세스

```mermaid
graph LR
    A[TODO.md 확인] --> B[브랜치 생성]
    B --> C[코드 작성]
    C --> D[테스트]
    D --> E[PR 생성]
    E --> F[코드 리뷰]
    F --> G[머지]
```

### Git 브랜치 전략

```bash
# 기능 개발
git checkout -b feature/기능명

# 버그 수정
git checkout -b fix/버그명

# 문서 작업
git checkout -b docs/문서명

# 리팩토링
git checkout -b refactor/대상
```

### 커밋 메시지 규칙

```bash
# 형식
<타입>: <제목>

<본문> (선택)

<푸터> (선택)

# 타입
feat: 새로운 기능
fix: 버그 수정
docs: 문서 수정
style: 코드 포맷팅
refactor: 리팩토링
test: 테스트 추가
chore: 빌드 업무, 패키지 매니저 설정

# 예시
feat: 크리에이터 프로필 페이지 구현

- 프로필 정보 표시
- 구독자 수 통계
- 콘텐츠 목록 연동

Closes #123
```

### PR 체크리스트

- [ ] 코드가 컴파일되고 실행됨
- [ ] 테스트 통과
- [ ] 문서 업데이트 (필요시)
- [ ] CHANGELOG.md 업데이트 (필요시)
- [ ] 코드 리뷰 요청

## 💡 팁과 트릭

### 개발 효율성 향상

```bash
# 자주 사용하는 명령어 별칭 설정
alias fr='fvm flutter run -d chrome --hot'
alias fpg='fvm flutter pub get'
alias fbr='fvm flutter pub run build_runner build --delete-conflicting-outputs'
alias ft='fvm flutter test'
```

### AI 도구 활용 (Cursor/Claude)

```markdown
# 효과적인 프롬프트 예시

"CLAUDE.md를 참고하여 [기능] 구현해줘"
"Clean Architecture 패턴에 맞게 [모듈] 작성"
"Riverpod을 사용하여 [상태관리] 구현"
"TODO.md의 [항목번호] 작업 진행"
```

### 디버깅 팁

```dart
// 1. Flutter Inspector 활용
// Chrome DevTools에서 Widget Tree 확인

// 2. Riverpod DevTools
// ProviderObserver로 상태 변화 추적

// 3. 로깅
import 'dart:developer' as dev;
dev.log('디버그 메시지', name: '카테고리');
```

## 🔍 문제 해결

### 자주 발생하는 문제

#### 1. FVM 버전 문제
```bash
# 해결책
fvm use 3.32.5 --force
fvm flutter clean
fvm flutter pub get
```

#### 2. 코드 생성 실패
```bash
# 해결책
fvm flutter clean
fvm flutter pub get
fvm flutter pub run build_runner clean
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

#### 3. 빌드 에러
```bash
# 해결책
rm -rf .dart_tool
rm pubspec.lock
fvm flutter pub get
```

## 📞 팀 연락처

### 커뮤니케이션 채널
- **Slack**: #project-channel
- **GitHub**: Issues & Discussions
- **이메일**: team@example.com

### 주요 담당자
| 역할 | 담당자 | 연락처 |
|------|--------|--------|
| 프로젝트 리드 | - | - |
| 프론트엔드 리드 | - | - |
| 백엔드 리드 | - | - |
| DevOps | - | - |

## 📋 온보딩 체크리스트

### Day 1 ✅
- [ ] 개발 환경 설정 완료
- [ ] 프로젝트 실행 성공
- [ ] IDE 설정 완료

### Day 2 ✅
- [ ] 필수 문서 읽기 완료
- [ ] 프로젝트 구조 이해
- [ ] 기술 스택 파악

### Day 3 ✅
- [ ] Git 브랜치 생성
- [ ] 첫 커밋 생성
- [ ] 첫 PR 생성

### Week 1 목표
- [ ] 간단한 버그 수정 1개
- [ ] 기능 구현 1개
- [ ] 코드 리뷰 참여
- [ ] 팀 미팅 참석

## 🎓 추가 학습 자료

### Flutter 학습
- [Flutter 공식 문서](https://flutter.dev/docs)
- [Riverpod 공식 문서](https://riverpod.dev/)
- [Clean Architecture in Flutter](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

### 프로젝트 특화
- [SuperClaude 사용법](./guides/scUsage.md)
- [Flutter SuperClaude 가이드](./guides/scUsageFlutter.md)

### 추천 코스
1. Flutter 기초 (이미 알고 있다면 스킵)
2. Riverpod 상태 관리
3. Clean Architecture 패턴
4. Firebase 통합 (예정)

## 🚀 다음 단계

온보딩을 완료한 후:

1. **심화 학습**
   - 복잡한 기능 구현 참여
   - 성능 최적화 작업
   - 테스트 작성

2. **팀 기여**
   - 문서 개선
   - 코드 리뷰 활발히 참여
   - 새로운 아이디어 제안

3. **전문성 개발**
   - 특정 영역 전문가 되기
   - 팀 내 지식 공유
   - 외부 발표/블로그 작성

---
*환영합니다! 궁금한 점이 있으면 언제든 팀에 문의하세요.*
*최종 수정: 2024-01-15*