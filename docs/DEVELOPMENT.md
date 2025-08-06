# 개발 가이드

## 🚀 빠른 시작

### 필수 요구사항
- Flutter 3.32.5 (FVM으로 관리)
- Dart 3.8.1+
- Chrome (웹 개발용)
- VS Code 또는 Android Studio

### 개발 환경 설정

```bash
# 1. FVM 설치 (Flutter 버전 관리)
dart pub global activate fvm

# 2. Flutter 3.32.5 설치
fvm install 3.32.5
fvm use 3.32.5

# 3. 의존성 설치
fvm flutter pub get

# 4. 코드 생성 (Freezed/JsonSerializable)
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

## 🏗️ 아키텍처

### Clean Architecture 구조

```
lib/
├── domain/           # 비즈니스 로직 (순수 Dart)
│   ├── entities/     # 비즈니스 객체 (Freezed 사용)
│   ├── repositories/ # Repository 인터페이스
│   └── usecases/     # 비즈니스 로직 캡슐화
│
├── data/            # 데이터 레이어
│   ├── models/      # DTO, JSON 직렬화
│   ├── repositories/# Repository 구현체 (Mock/Firebase)
│   └── datasources/ # 외부 데이터 소스
│
└── presentation/    # UI 레이어
    ├── pages/       # 화면 컴포넌트
    ├── widgets/     # 재사용 가능한 위젯
    └── providers/   # Riverpod 상태 관리
```

### 주요 기술 스택

| 분야 | 기술 | 버전 | 용도 |
|------|------|------|------|
| **상태 관리** | Riverpod | 2.4.9 | 반응형 상태 관리 |
| **라우팅** | go_router | 13.2.0 | 선언적 라우팅 |
| **코드 생성** | Freezed | 2.4.6 | 불변 객체 생성 |
| **직렬화** | JsonSerializable | 6.7.1 | JSON 변환 |
| **HTTP** | Dio | 5.4.0 | REST API 통신 |
| **영상** | video_player | 2.8.2 | 비디오 재생 |
| **차트** | fl_chart | 0.66.0 | 데이터 시각화 |

## 💻 개발 명령어

### 실행 및 빌드

```bash
# 웹 개발 서버 실행 (hot reload)
fvm flutter run -d chrome --hot

# 웹 프로덕션 빌드
fvm flutter build web

# 릴리즈 모드 실행
fvm flutter run -d chrome --release

# 프로파일 모드 (성능 분석)
fvm flutter run -d chrome --profile
```

### 코드 품질

```bash
# 정적 분석
fvm flutter analyze

# 코드 포맷팅
fvm flutter format lib/

# 테스트 실행
fvm flutter test

# 테스트 커버리지
fvm flutter test --coverage
```

### 코드 생성

```bash
# Freezed/JsonSerializable 코드 생성
fvm flutter pub run build_runner build --delete-conflicting-outputs

# 변경 감지 모드 (자동 재생성)
fvm flutter pub run build_runner watch --delete-conflicting-outputs

# 캐시 정리 후 재생성
fvm flutter pub run build_runner clean
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

## 🔧 개발 가이드라인

### 1. 레이어별 개발 순서
1. **Domain Layer** → 엔티티 및 Repository 인터페이스 정의
2. **Data Layer** → Repository 구현 및 모델 생성
3. **Presentation Layer** → UI 및 상태 관리 구현

### 2. 상태 관리 패턴

```dart
// Provider 정의 (repository_providers.dart)
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return MockUserRepository(); // 또는 FirebaseUserRepository()
});

// StateNotifier 사용 (복잡한 상태)
class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier(this._repository) : super(const AuthState());
  
  final UserRepository _repository;
  
  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true);
    // 로직 구현
  }
}

// Provider 사용 (UI에서)
class LoginScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateNotifierProvider);
    // UI 구현
  }
}
```

### 3. 라우팅 설정

```dart
// go_router 설정 (app_router.dart)
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateNotifierProvider);
  
  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      // 인증 기반 리다이렉트 로직
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      // 추가 라우트
    ],
  );
});
```

### 4. Freezed 모델 생성

```dart
// 1. 엔티티 정의 (user.dart)
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    String? displayName,
    @Default(false) bool isCreator,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

// 2. 코드 생성 실행
// fvm flutter pub run build_runner build
```

## 🐛 디버깅

### Chrome DevTools 사용
1. 앱 실행 중 `F12` 또는 우클릭 → 검사
2. Flutter Inspector 활성화
3. Network 탭에서 API 호출 확인
4. Console에서 로그 확인

### VS Code 디버깅
1. `.vscode/launch.json` 설정
2. `F5`로 디버그 모드 실행
3. 중단점 설정 및 변수 검사

### 유용한 디버그 명령어

```bash
# 위젯 트리 출력
fvm flutter inspector

# 성능 프로파일링
fvm flutter run --profile

# 메모리 사용량 분석
fvm flutter analyze --memory
```

## 📝 코드 컨벤션

### 네이밍 규칙
- **파일명**: snake_case (예: `user_repository.dart`)
- **클래스명**: PascalCase (예: `UserRepository`)
- **변수/함수**: camelCase (예: `getUserById`)
- **상수**: SCREAMING_SNAKE_CASE (예: `MAX_RETRY_COUNT`)

### 폴더 구조 규칙
- 기능별로 그룹화 (feature-first)
- 공통 컴포넌트는 `shared/` 폴더
- 유틸리티는 `core/utils/` 폴더

### 주석 작성
- 복잡한 로직에는 설명 주석 필수
- TODO 주석으로 추후 작업 표시
- 공개 API는 문서화 주석 작성

## 🔄 Git 워크플로우

```bash
# 기능 브랜치 생성
git checkout -b feature/기능명

# 변경사항 커밋
git add .
git commit -m "feat: 기능 설명"

# 메인 브랜치 머지
git checkout main
git merge feature/기능명

# 원격 저장소 푸시
git push origin main
```

### 커밋 메시지 규칙
- `feat:` 새로운 기능
- `fix:` 버그 수정
- `docs:` 문서 수정
- `style:` 코드 포맷팅
- `refactor:` 리팩토링
- `test:` 테스트 추가/수정
- `chore:` 빌드 설정 등

## 🚨 주의사항

1. **FVM 사용 필수**: 모든 Flutter 명령어 앞에 `fvm` 붙이기
2. **코드 생성**: 모델 수정 후 반드시 `build_runner` 실행
3. **Provider 관리**: Repository Provider는 `repository_providers.dart`에 집중
4. **Mock 우선**: 개발 시 Mock Repository 사용, 프로덕션에서 Firebase 전환
5. **웹 최적화**: 기본 타겟은 웹, 모바일은 추후 최적화