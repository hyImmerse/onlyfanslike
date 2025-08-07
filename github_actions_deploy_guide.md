# 🚀 Flutter 루트폴더 프로젝트 GitHub Actions 배포 가이드

**작성일**: 2025-08-07  
**프로젝트**: Contents (Flutter 앱이 루트 폴더에 위치)  
**대상**: GitHub Pages PWA 자동 배포

---

## 📋 프로젝트 구조 분석

### 현재 구조
```
contents/
├── lib/                    # Flutter 소스코드
├── web/                    # 웹 설정 파일
├── pubspec.yaml           # Flutter 설정
├── analysis_options.yaml
├── build/                 # 빌드 출력 (build/web/)
└── assets/               # 리소스 파일
```

### DEF 프로젝트와의 차이점
| 구분 | DEF 프로젝트 | Contents 프로젝트 |
|------|-------------|------------------|
| Flutter 앱 위치 | `/def_order_app/` (서브폴더) | `/` (루트폴더) |
| 빌드 출력 | `def_order_app/build/web/` | `build/web/` |
| working-directory | 필요함 | 불필요함 |

---

## ⚙️ GitHub Actions 워크플로우 설정

### 1️⃣ 워크플로우 파일 생성

`.github/workflows/flutter-web-deploy.yml` 생성:

```yaml
name: Contents Flutter Web Deploy to GitHub Pages

on:
  push:
    branches: [ main ]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.32.5'
          channel: 'stable'
      
      - name: Get dependencies
        run: flutter pub get
      
      - name: Build web
        run: |
          flutter build web --release \\
            --base-href "/contents/"
      
      - name: Setup Pages
        uses: actions/configure-pages@v4
      
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: 'build/web'
      
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

### 🔍 **핵심 차이점 설명**

#### DEF 프로젝트 vs Contents 프로젝트

**DEF (서브폴더) 설정**:
```yaml
- name: Get dependencies
  run: fvm flutter pub get
  working-directory: def_order_app  # 서브폴더 지정

- name: Build web
  working-directory: def_order_app  # 모든 단계에 필요

- name: Upload artifact
  with:
    path: 'def_order_app/build/web'  # 서브폴더 경로
```

**Contents (루트폴더) 설정**:
```yaml
- name: Get dependencies
  run: flutter pub get              # working-directory 불필요

- name: Build web
  run: flutter build web --release  # working-directory 불필요

- name: Upload artifact
  with:
    path: 'build/web'               # 루트에서 바로 접근
```

---

## 📱 GitHub Pages 설정

### 1️⃣ 저장소 Public 변경 (필요시)
무료 계정에서 GitHub Pages 사용하려면 저장소가 Public이어야 합니다.

### 2️⃣ GitHub Pages 설정
1. **GitHub 저장소** → **Settings** → **Pages**
2. **Source**: **"GitHub Actions"** 선택 ⭐
3. **Branch 설정 불필요** (GitHub Actions가 자동 처리)

### 3️⃣ 배포 URL
```
https://[username].github.io/contents/
```

---

## 🔧 프로젝트별 커스터마이징

### base-href 설정
```yaml
# 저장소명이 'contents'인 경우
--base-href "/contents/"

# 저장소명이 다른 경우 (예: 'my-flutter-app')
--base-href "/my-flutter-app/"
```

### Flutter 버전 지정
```yaml
# 프로젝트에서 사용하는 Flutter 버전에 맞게 수정
- name: Setup Flutter
  uses: subosito/flutter-action@v2
  with:
    flutter-version: '3.32.5'  # 프로젝트 버전에 맞게 변경
    channel: 'stable'
```

### 환경 변수 추가 (필요시)
```yaml
- name: Build web
  run: |
    flutter build web --release \\
      --dart-define=ENVIRONMENT=production \\
      --dart-define=API_URL=https://api.example.com \\
      --base-href "/contents/"
```

---

## 🚨 주의사항 및 문제 해결

### 💡 **루트폴더 프로젝트의 장점**
1. **설정 단순화**: working-directory 설정 불필요
2. **경로 간소화**: 모든 경로가 루트 기준
3. **빠른 설정**: 표준 Flutter 프로젝트 구조

### ⚠️ **체크리스트**

#### 빌드 전 확인사항
- [ ] `pubspec.yaml` 파일이 루트에 있는지 확인
- [ ] `lib/main.dart` 파일 존재 확인
- [ ] `web/index.html` 및 `web/manifest.json` 확인

#### 배포 전 확인사항
- [ ] 저장소가 Public인지 확인 (무료 계정)
- [ ] GitHub Pages Source가 "GitHub Actions"로 설정
- [ ] base-href가 저장소명과 일치하는지 확인

### 🐛 **흔한 문제 해결**

#### 1. 404 오류
```yaml
# base-href 설정 확인
--base-href "/올바른-저장소명/"
```

#### 2. 빈 화면 표시
```html
<!-- web/index.html에 base 태그 확인 -->
<base href="/contents/">
```

#### 3. Flutter 빌드 오류
```bash
# dependencies 확인
flutter pub get
flutter doctor -v
```

#### 4. Actions 권한 오류
```yaml
# 워크플로우 파일에 권한 확인
permissions:
  contents: read
  pages: write
  id-token: write
```

---

## 🎯 실행 단계

### 1️⃣ 워크플로우 생성
```bash
# contents 프로젝트 루트에서
mkdir -p .github/workflows
# 위의 워크플로우 파일 내용을 복사하여 저장
```

### 2️⃣ GitHub에 Push
```bash
git add .github/workflows/flutter-web-deploy.yml
git commit -m "feat: GitHub Actions Flutter 웹 배포 워크플로우 추가"
git push origin main
```

### 3️⃣ GitHub Pages 설정
1. GitHub 저장소 → Settings → Pages
2. Source: "GitHub Actions" 선택

### 4️⃣ 배포 확인
- Actions 탭에서 빌드 진행 상황 확인
- 완료 후 `https://[username].github.io/contents/` 접속

---

## 📊 성능 최적화 옵션

### PWA 최적화
```yaml
- name: Build web
  run: |
    flutter build web --release \\
      --base-href "/contents/" \\
      --web-renderer html
```

### 빌드 캐싱 (빌드 속도 향상)
```yaml
- name: Cache Flutter dependencies
  uses: actions/cache@v3
  with:
    path: |
      ~/.pub-cache
      **/.dart_tool
    key: ${{ runner.os }}-pub-${{ hashFiles('**/pubspec.lock') }}
    restore-keys: |
      ${{ runner.os }}-pub-
```

---

## ✅ 완료 체크리스트

### 설정 완료
- [ ] `.github/workflows/flutter-web-deploy.yml` 생성
- [ ] 저장소 Public 변경 (무료 계정)
- [ ] GitHub Pages Source 설정 완료
- [ ] 첫 번째 배포 성공

### 테스트 완료
- [ ] 웹사이트 접속 확인
- [ ] PWA 설치 테스트
- [ ] 모바일 반응형 확인
- [ ] 오프라인 기능 테스트

---

## 🎉 배포 완료!

성공적으로 설정되면 다음 URL에서 접속 가능합니다:
```
https://[your-username].github.io/contents/
```

**루트폴더 Flutter 프로젝트의 GitHub Pages 배포가 완료되었습니다!** 🚀

---

**작성**: Claude Code Assistant  
**검증**: 2025-08-07  
**프로젝트**: Contents Flutter App (루트폴더 구조)