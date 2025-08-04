# 구독형 플랫폼 MVP 데모 구현 가이드

## 🎯 프로젝트 목표
크리에이터와 팬 간의 구독형 플랫폼 핵심 기능을 Flutter로 구현하고, PWA 방식으로 고객에게 시연

## 📱 핵심 데모 시나리오

### 1. 팬 사용자 경험
1. 간단한 회원가입/로그인
2. 크리에이터 탐색 및 검색
3. 크리에이터 프로필 확인
4. 구독 신청 및 결제 UI (시뮬레이션)
5. 구독자 전용 콘텐츠 열람

### 2. 크리에이터 경험  
1. 크리에이터 프로필 생성
2. 구독 요금제 설정
3. 콘텐츠 업로드 (사진/영상)
4. 구독자 현황 대시보드

## 🛠️ SuperClaude 명령어 실행 순서

### 1단계: Flutter 프로젝트 생성 및 초기 설정 ✅
```bash
# Flutter 프로젝트 생성 ✅
/sc:implement "Flutter 프로젝트 생성 - creator_platform_demo" --persona-frontend --c7
# ✅ Flutter 프로젝트 생성 완료 (creator_platform_demo)
# ✅ FVM 설정 파일 생성 (.fvm/fvm_config.json) - Flutter 3.32.5
# ✅ 기본 프로젝트 구조 및 설정 파일 생성

# 필요한 패키지 추가 (pubspec.yaml) ✅
/sc:implement "Flutter 패키지 설정 - riverpod, go_router, video_player 등" --persona-backend --c7 --validate
# ✅ pubspec.yaml 패키지 추가 완료:
#   - flutter_riverpod: ^2.4.9 (상태 관리)
#   - go_router: ^13.2.0 (라우팅)
#   - freezed: ^2.4.6 (코드 생성)
#   - json_serializable: ^6.7.1 (JSON 직렬화)
#   - video_player: ^2.8.2 (비디오 재생)
#   - chewie: ^1.7.4 (비디오 플레이어 UI)
#   - cached_network_image: ^3.3.1 (이미지 캐싱)
#   - shimmer: ^3.0.0 (로딩 효과)
#   - flutter_svg: ^2.0.9 (SVG 지원)
#   - intl: ^0.18.1 (국제화)
#   - shared_preferences: ^2.2.2 (로컬 저장소)
#   - url_strategy: ^0.2.0 (URL 전략)

# 프로젝트 구조 분석 및 설계 ✅
/sc:load @specs/customer_req.md
# ✅ customer_req.md 파일 로드 완료
# ✅ 구독형 플랫폼 요구사항 분석 완료

/sc:design "구독형 플랫폼 아키텍처" --scope system --persona-architect --c7
# ❌ 아키텍처 설계 문서 별도 생성하지 않음

# Clean Architecture 기반 프로젝트 구조 생성 ✅
/sc:implement "Flutter Clean Architecture 구조" --persona-architect --c7 --seq
# ✅ Clean Architecture 디렉토리 구조 생성 완료:
#   - lib/core/ (constants, router, theme, utils)
#   - lib/data/ (datasources, models, repositories)
#   - lib/domain/ (entities, repositories, usecases)
#   - lib/presentation/ (pages, providers, widgets)
# ✅ 도메인 엔티티 생성 (user.dart, creator.dart, content.dart, subscription.dart)
# ✅ 라우터 설정 (app_router.dart) - go_router 중첩 라우팅 구현
# ✅ 테마 설정 (app_theme.dart) - Material 3 디자인
# ✅ 상수 정의 (app_constants.dart)
# ✅ 기본 화면 스켈레톤 생성 (splash, login, home, profile, search 등)
```

### 2단계: 데이터 모델 및 Repository 구현 ✅
```bash
# 도메인 엔티티 정의 ✅
/sc:implement "User, Creator, Content, Subscription 엔티티" --persona-backend --c7 --validate
# ✅ 도메인 엔티티 이미 생성됨 (1단계에서 완료)
# ✅ Freezed 코드 생성 완료 (build_runner 실행)
# ✅ 생성된 파일들:
#   - lib/domain/entities/user.freezed.dart, user.g.dart
#   - lib/domain/entities/creator.freezed.dart, creator.g.dart
#   - lib/domain/entities/content.freezed.dart, content.g.dart
#   - lib/domain/entities/subscription.freezed.dart, subscription.g.dart

# Repository 인터페이스 및 구현 ✅
/sc:implement "UserRepository, ContentRepository 구현" --persona-backend --seq --validate
# ✅ Repository 인터페이스 생성 완료 (lib/domain/repositories/):
#   - user_repository.dart (로그인, 회원가입, 프로필 관리)
#   - creator_repository.dart (크리에이터 목록, 검색, 프로필 관리)
#   - content_repository.dart (콘텐츠 목록, 업로드, 구독자 전용 콘텐츠)
#   - subscription_repository.dart (구독 관리, 구독자 현황, 수익 통계)
# ✅ 데이터 모델 생성 시작 (lib/data/models/):
#   - user_model.dart (UserModel with fromEntity/toEntity)

# 가상 데이터 생성
/sc:implement "Mock 데이터 및 더미 콘텐츠 생성" --persona-backend --c7
```

### 3단계: 콘텐츠 Assets 준비
```bash
# 무료 콘텐츠 다운로드 및 준비
/sc:implement "무료 동영상 콘텐츠 다운로드 스크립트" --persona-backend --c7

# 콘텐츠 메타데이터 생성
/sc:implement "동영상 썸네일 및 메타데이터 생성" --persona-backend --seq

# assets 폴더 구조 설정
/sc:implement "콘텐츠 assets 폴더 구조화" --persona-architect --validate

# Mock 크리에이터 프로필 이미지 준비
/sc:implement "크리에이터 프로필 이미지 및 배너 준비" --persona-frontend --c7
```

### 4단계: 상태 관리 설정 (Riverpod)
```bash
# 전역 상태 관리 설정
/sc:implement "AuthProvider, UserProvider 구현" --persona-backend --c7 --seq

# 화면별 StateNotifier 구현
/sc:implement "CreatorListNotifier, SubscriptionNotifier" --persona-backend --c7 --validate
```

### 5단계: 라우팅 설정 (go_router) ✅
```bash
# 라우팅 구조 설정 ✅
/sc:implement "go_router 라우팅 설정 - 중첩 라우팅 포함" --persona-backend --c7 --validate
# ✅ go_router 라우팅 설정 완료 (lib/core/router/app_router.dart)
# ✅ 구현된 라우트:
#   - / (스플래시 화면)
#   - /login (로그인 화면)
#   - /signup (회원가입 화면)
#   - /onboarding (온보딩 화면)
#   - /home (메인 화면) + 중첩 라우팅:
#     - /home/explore (크리에이터 탐색)
#     - /home/subscriptions (구독 목록)
#     - /home/profile (프로필)
#   - /creator/:creatorId (크리에이터 상세)
#   - /content/:contentId (콘텐츠 뷰어)
#   - /subscribe/:creatorId (구독 신청)
#   - /search (검색 화면)
#   - /creator-dashboard (크리에이터 대시보드)
#   - /upload (콘텐츠 업로드)
# ✅ main.dart에 라우터 연결 완료

# 라우트 가드 및 리다이렉트 설정
/sc:implement "인증 기반 라우트 가드 구현" --persona-backend --seq
```

### 6단계: 핵심 화면 UI 구현

#### 6-1. 스플래시 및 온보딩 ✅
```bash
# 스플래시 화면 ✅
/sc:implement "Flutter 스플래시 화면 - 로고 애니메이션" --persona-frontend --c7 --validate
# ✅ 스플래시 화면 스켈레톤 생성 완료 (lib/presentation/pages/splash/splash_screen.dart)

# 온보딩 가이드 ✅
/sc:implement "온보딩 슬라이드 화면 - 주요 기능 소개" --persona-frontend --c7 --seq
# ✅ 온보딩 화면 스켈레톤 생성 완료 (lib/presentation/pages/onboarding/onboarding_screen.dart)
```

#### 6-2. 인증 화면 ✅
```bash
# 로그인/회원가입 화면 ✅
/sc:implement "Flutter 로그인 화면 - 이메일/SNS 로그인" --persona-frontend --c7 --validate
# ✅ 로그인 화면 스켈레톤 생성 완료 (lib/presentation/pages/auth/login_screen.dart)

# 회원가입 플로우 ✅
/sc:implement "회원가입 단계별 화면" --persona-frontend --c7 --seq
# ✅ 회원가입 화면 스켈레톤 생성 완료 (lib/presentation/pages/auth/signup_screen.dart)
```

#### 6-3. 메인 화면 ✅
```bash
# 크리에이터 탐색 화면 ✅
/sc:implement "크리에이터 목록 화면 - 카드형 레이아웃" --persona-frontend --c7 --validate
# ✅ 홈 화면 스켈레톤 생성 완료 (lib/presentation/pages/home/home_screen.dart)

# 검색 및 필터 ✅
/sc:implement "크리에이터 검색 및 카테고리 필터" --persona-frontend --c7 --seq
# ✅ 검색 화면 스켈레톤 생성 완료 (lib/presentation/pages/search/search_screen.dart)
```

#### 6-4. 크리에이터 프로필 ✅
```bash
# 프로필 상세 화면 ✅
/sc:implement "크리에이터 프로필 화면 - 구독 버튼 포함" --persona-frontend --c7 --validate
# ✅ 크리에이터 프로필 화면 스켈레톤 생성 완료 (lib/presentation/pages/creator/creator_profile_screen.dart)

# 콘텐츠 미리보기
/sc:implement "무료 콘텐츠 미리보기 그리드" --persona-frontend --c7 --seq
```

#### 6-5. 구독 및 결제 ✅
```bash
# 구독 플랜 선택 ✅
/sc:implement "구독 요금제 선택 화면" --persona-frontend --c7 --validate
# ✅ 구독 화면 스켈레톤 생성 완료 (lib/presentation/pages/subscription/subscription_screen.dart)

# 결제 UI (시뮬레이션)
/sc:implement "결제 정보 입력 화면 - UI만 구현" --persona-frontend --c7 --seq
```

#### 6-6. 구독자 전용 콘텐츠 ✅
```bash
# 콘텐츠 뷰어 ✅
/sc:implement "구독자 전용 콘텐츠 뷰어 - 이미지/영상" --persona-frontend --c7 --validate
# ✅ 콘텐츠 뷰어 화면 스켈레톤 생성 완료 (lib/presentation/pages/content/content_viewer_screen.dart)

# 콘텐츠 보안
/sc:implement "콘텐츠 보안 기능 - 우클릭 방지, 워터마크" --persona-frontend --c7 --seq
```

#### 6-7. 크리에이터 대시보드 ✅
```bash
# 크리에이터 홈 ✅
/sc:implement "크리에이터 대시보드 - 수익/구독자 현황" --persona-frontend --c7 --validate
# ✅ 크리에이터 대시보드 화면 스켈레톤 생성 완료 (lib/presentation/pages/creator/creator_dashboard_screen.dart)

# 콘텐츠 업로드
/sc:implement "콘텐츠 업로드 화면 - 이미지/영상 선택" --persona-frontend --c7 --seq
```

### 7단계: 가이드 시스템 구현
```bash
# 인터랙티브 가이드
/sc:implement "화면별 툴팁 및 하이라이트 가이드" --persona-frontend --c7 --validate

# 데모 시나리오 모드
/sc:implement "데모 모드 - 자동 진행 시나리오" --persona-frontend --c7 --seq

# 도움말 오버레이
/sc:implement "컨텍스트 도움말 오버레이" --persona-frontend --c7 --validate
```

### 8단계: PWA 설정 및 빌드
```bash
# PWA 설정
/sc:implement "Flutter Web PWA 설정 - manifest.json" --persona-frontend --c7 --validate

# 반응형 웹 최적화
/sc:improve "반응형 레이아웃 최적화" --focus performance --persona-frontend --c7

# 웹 빌드
/sc:build --target web --production --persona-frontend --validate
```

### 9단계: 성능 최적화 및 테스트
```bash
# 성능 분석
/sc:analyze --focus performance --persona-performance --think-hard

# UI/UX 개선
/sc:improve "사용자 경험 최적화" --persona-frontend --c7 --loop

# 통합 테스트
/sc:test --type integration --persona-qa --validate
```

## 📋 가이드 시나리오 예시

### 시나리오 1: 팬 사용자 여정
```
1. 스플래시 화면 → "탭하여 시작" 가이드
2. 로그인 화면 → "데모 계정으로 로그인" 버튼 하이라이트
3. 메인 화면 → "인기 크리에이터를 확인해보세요" 툴팁
4. 크리에이터 프로필 → "구독하기 버튼을 눌러보세요" 가이드
5. 결제 화면 → "데모에서는 실제 결제가 되지 않습니다" 안내
6. 구독 완료 → "이제 전용 콘텐츠를 볼 수 있습니다" 축하 메시지
```

### 시나리오 2: 크리에이터 여정
```
1. 크리에이터 전환 → "크리에이터로 전환하기" 버튼
2. 프로필 설정 → "프로필을 꾸며보세요" 가이드
3. 요금제 설정 → "월 구독료를 설정하세요" 툴팁
4. 콘텐츠 업로드 → "첫 콘텐츠를 업로드해보세요" 가이드
5. 대시보드 → "구독자 현황을 확인하세요" 하이라이트
```

## 🎨 UI/UX 고려사항

### 차별화 포인트
1. **콘텐츠 보안**: 스크린샷 방지, 워터마크
2. **직관적 UI**: 온리팬스/팬트리 레퍼런스
3. **모바일 최적화**: 반응형 디자인
4. **가이드 시스템**: 단계별 툴팁과 하이라이트

### 가상 데이터 구성
- 5-10명의 다양한 크리에이터 프로필
- 각 크리에이터당 10-20개의 샘플 콘텐츠
- 구독자 수, 좋아요 등 현실적인 수치
- 다양한 카테고리 (음악, 예술, 피트니스 등)

### 📹 저작권 무료 콘텐츠 소스
데모용 동영상 콘텐츠는 저작권 문제를 피하기 위해 다음 무료 리소스를 활용:

#### 추천 무료 동영상 사이트
1. **Pexels Videos** (https://www.pexels.com/videos/)
   - 완전 무료, 상업적 이용 가능
   - 고품질 HD/4K 영상
   - 다양한 카테고리 (자연, 피트니스, 요리, 라이프스타일)

2. **Pixabay** (https://pixabay.com/videos/)
   - Pixabay License로 자유롭게 사용 가능
   - 다양한 장르의 영상 콘텐츠
   - 출처 표기 없이 사용 가능

3. **Videvo** (https://www.videvo.net/)
   - Free Stock Footage 섹션 활용
   - 모션 그래픽, 배경 영상 등
   - 라이선스 확인 후 사용

4. **Coverr** (https://coverr.co/)
   - 웹사이트용 배경 영상 특화
   - 무료 다운로드, 상업적 이용 가능
   - 라이프스타일, 자연, 비즈니스 카테고리

#### 데모용 콘텐츠 구성 예시
```bash
# 크리에이터별 콘텐츠 매핑
- 피트니스 크리에이터: Pexels의 운동/요가 영상
- 요리 크리에이터: Pixabay의 요리 과정 영상  
- 여행 크리에이터: Videvo의 여행지 풍경 영상
- 라이프스타일 크리에이터: Coverr의 일상 브이로그 스타일 영상
- 음악 크리에이터: 무료 음원 사이트의 공연 영상
```

## 🚀 배포 및 시연

### PWA 배포
```bash
# Firebase Hosting 배포
/sc:implement "Firebase Hosting 배포 설정" --persona-devops --c7 --validate

# 배포 스크립트
/sc:build --target web --production --deploy
```

### 시연 준비
1. 데모 URL 생성 (https://demo-creator-platform.web.app)
2. QR 코드 생성하여 모바일 접속 유도
3. 가이드 모드 기본 활성화
4. 샘플 계정 정보 제공

## 📝 추가 고려사항

### 기술 스택
- **Frontend**: Flutter 3.x
- **상태관리**: Riverpod 2.x
- **라우팅**: go_router
- **스토리지**: 로컬 assets (데모용)
- **PWA**: Flutter Web + manifest.json

### 데모 제약사항
- 실제 결제 연동 없음 (UI만 구현)
- 실제 서버 없음 (로컬 Mock 데이터)
- 실제 파일 업로드 없음 (미리 준비된 콘텐츠)
- 실시간 알림 없음 (UI 시뮬레이션)

이 가이드를 따라 순차적으로 SuperClaude 명령어를 실행하면, 고객에게 보여줄 수 있는 완성도 높은 MVP 데모를 구축할 수 있습니다.