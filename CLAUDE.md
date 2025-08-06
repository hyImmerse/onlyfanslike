# CLAUDE.md

Claude Code 프로젝트 컨텍스트 파일 - Flutter 크리에이터 구독 플랫폼

## 프로젝트 핵심 정보

- **프레임워크**: Flutter 3.32.5 (FVM 사용 필수)
- **아키텍처**: Clean Architecture (Domain/Data/Presentation)
- **상태 관리**: Riverpod 2.4.9
- **라우팅**: go_router 13.2.0
- **타겟**: Web (PWA) 우선, Mobile 지원

## 주요 명령어

```bash
# 개발 실행
fvm flutter run -d chrome --hot

# 코드 생성 (모델 수정 후 필수)
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

## 핵심 패턴

### Repository Pattern
- **Interface**: `lib/domain/repositories/` - Repository 계약 정의
- **Implementation**: `lib/data/repositories/` - Mock 구현체
- **Provider**: `lib/presentation/providers/repository_providers.dart` - DI 관리
- **Firebase Ready**: 코드 준비됨, 주석 처리 상태

### State Management
- **중앙 관리**: `repository_providers.dart`에 모든 Provider 집중
- **StateNotifier**: 복잡한 비즈니스 로직용
- **AutoDispose**: 메모리 누수 방지

### 주의사항
1. **FVM 필수**: 모든 Flutter 명령어 앞에 `fvm` 붙이기
2. **코드 생성**: 모델 수정 후 반드시 `build_runner` 실행
3. **Mock 우선**: 개발 시 Mock Repository 사용
4. **Web 최적화**: 기본 타겟은 웹, 모바일은 추후 최적화

## 문서 참조
- 개발 가이드: `docs/DEVELOPMENT.md`
- 기능 명세: `docs/FEATURES.md`
- Firebase 설정: `FIREBASE_SETUP.md`