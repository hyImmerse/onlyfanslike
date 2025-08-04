# Creator Platform Demo

크리에이터와 팬을 연결하는 구독형 플랫폼 Flutter 데모 앱입니다.

## 🚀 시작하기

### 필수 요구사항
- Flutter 3.32.5 (FVM으로 관리)
- Dart 3.8.1+
- Chrome (웹 개발용)

### 설치 방법

1. 의존성 설치
```bash
fvm flutter pub get
```

2. 코드 생성 (Freezed/JsonSerializable)
```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

3. 웹에서 실행
```bash
fvm flutter run -d chrome
```

## 📱 주요 기능

### 팬 사용자
- 회원가입/로그인
- 크리에이터 탐색 및 검색
- 크리에이터 프로필 확인
- 구독 신청 및 결제 (UI 데모)
- 구독자 전용 콘텐츠 열람

### 크리에이터
- 프로필 관리
- 구독 요금제 설정
- 콘텐츠 업로드
- 구독자 현황 대시보드

## 🏗️ 프로젝트 구조

```
lib/
├── core/               # 핵심 기능
│   ├── constants/     # 상수 정의
│   ├── router/        # 라우팅 설정
│   ├── theme/         # 테마 설정
│   └── utils/         # 유틸리티 함수
├── data/              # 데이터 레이어
│   ├── datasources/   # 데이터 소스
│   ├── models/        # 데이터 모델
│   └── repositories/  # Repository 구현
├── domain/            # 도메인 레이어
│   ├── entities/      # 엔티티
│   ├── repositories/  # Repository 인터페이스
│   └── usecases/      # 유스케이스
└── presentation/      # 프레젠테이션 레이어
    ├── pages/         # 화면
    ├── providers/     # Riverpod Providers
    └── widgets/       # 재사용 위젯
```

## 🛠️ 기술 스택

- **Framework**: Flutter 3.32.5
- **State Management**: Riverpod 2.4.9
- **Navigation**: go_router 13.2.0
- **Code Generation**: Freezed, JsonSerializable
- **Video Player**: video_player, chewie
- **Image Caching**: cached_network_image

## 📝 데모 모드

이 앱은 데모 모드로 동작합니다:
- 실제 서버 연동 없음
- Mock 데이터 사용
- 결제는 UI만 구현

## 🌐 PWA 지원

웹 빌드 시 Progressive Web App으로 동작:
- 오프라인 지원
- 설치 가능
- 반응형 디자인