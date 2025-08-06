# Creator Platform Demo

> 크리에이터와 팬을 연결하는 구독형 플랫폼 - Flutter PWA 데모

[![Flutter](https://img.shields.io/badge/Flutter-3.32.5-blue)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.8.1-blue)](https://dart.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Clean-green)](docs/DEVELOPMENT.md)
[![Status](https://img.shields.io/badge/Status-95%25_Complete-success)](docs/FEATURES.md)

## 🎯 프로젝트 소개

온리팬스와 팬트리를 벤치마킹한 크리에이터 구독 플랫폼의 Flutter 데모 애플리케이션입니다.
강력한 콘텐츠 보호 기능과 크리에이터 친화적인 수익 관리 시스템이 특징입니다.

### 핵심 특징
- 🔐 **업계 최고 수준 콘텐츠 보호** - 다층 보안 시스템
- 📊 **실시간 수익 분석** - 상세한 대시보드 제공
- 🎨 **Material 3 디자인** - 최신 UI/UX 트렌드 적용
- 📱 **PWA 지원** - 웹/모바일 통합 경험

## 🚀 빠른 시작

```bash
# 1. 의존성 설치
fvm flutter pub get

# 2. 코드 생성
fvm flutter pub run build_runner build --delete-conflicting-outputs

# 3. 웹 실행
fvm flutter run -d chrome --hot
```

## 📚 문서

| 문서 | 설명 |
|------|------|
| [개발 가이드](docs/DEVELOPMENT.md) | 개발 환경 설정, 아키텍처, 명령어 |
| [기능 명세](docs/FEATURES.md) | 구현 현황, 로드맵, 데모 시나리오 |
| [Firebase 설정](FIREBASE_SETUP.md) | Firebase 통합 가이드 |
| [고객 요구사항](specs/customer_req.md) | 원본 요구사항 명세 |

## 🎬 데모 계정

### 일반 사용자
- Email: `user@demo.com`
- Password: `demo1234`

### 크리에이터
- Email: `creator@demo.com`
- Password: `demo1234`

## 🏗️ 기술 스택

| 분야 | 기술 | 버전 |
|------|------|------|
| **Framework** | Flutter | 3.32.5 |
| **State** | Riverpod | 2.4.9 |
| **Routing** | go_router | 13.2.0 |
| **Architecture** | Clean Architecture | - |
| **Code Gen** | Freezed | 2.4.6 |
| **Backend** | Firebase Ready | - |

## 📂 프로젝트 구조

```
lib/
├── domain/          # 비즈니스 로직
│   ├── entities/    # 핵심 비즈니스 객체
│   └── repositories/# Repository 인터페이스
├── data/           # 데이터 레이어
│   ├── models/     # DTO 및 JSON 모델
│   └── repositories/# Repository 구현체
├── presentation/   # UI 레이어
│   ├── pages/      # 화면 컴포넌트
│   ├── widgets/    # 재사용 위젯
│   └── providers/  # 상태 관리
└── core/          # 공통 유틸리티
    ├── constants/  # 상수
    ├── theme/      # 테마 설정
    └── utils/      # 유틸리티
```

## 🤝 기여하기

이 프로젝트는 데모 목적으로 제작되었습니다. 
실제 서비스 구축 시 Firebase 통합 및 추가 개발이 필요합니다.

## 📄 라이센스

Copyright © 2024. All rights reserved.

---

<p align="center">
  Made with ❤️ using Flutter
</p>