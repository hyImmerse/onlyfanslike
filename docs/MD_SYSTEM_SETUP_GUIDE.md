# MD 시스템 적용 가이드

## 📌 개요
프로젝트에 MD 파일 표준 시스템을 적용하기 위한 단계별 가이드입니다.

## 🎯 목표
- 일관된 문서 구조 확립
- AI 도구와의 효율적인 협업
- 팀 전체의 문서화 품질 향상

## 📋 전제 조건

### 필수 도구
- VS Code 또는 Cursor IDE
- Git (버전 관리)
- Node.js (선택: 자동화 도구용)

### 권장 VS Code 확장
```bash
# 필수 확장
code --install-extension yzhang.markdown-all-in-one
code --install-extension DavidAnson.vscode-markdownlint

# 선택 확장
code --install-extension shd101wyy.markdown-preview-enhanced
code --install-extension bierner.markdown-mermaid
```

## 🚀 시스템 적용 단계

### 1단계: 기본 구조 생성

```bash
# 프로젝트 루트에서 실행
mkdir -p docs
touch docs/MD_STANDARDS.md
touch docs/MD_SYSTEM_SETUP_GUIDE.md
touch docs/README.md
touch CLAUDE.md
touch TODO.md
touch CHANGELOG.md
touch TEAM_SETUP.md
```

### 2단계: IDE 설정 (.cursor-settings)

`.cursor-settings` 파일 생성:
```json
{
  "context_files": [
    "CLAUDE.md",
    "docs/MD_STANDARDS.md",
    "TODO.md"
  ],
  "auto_context": true,
  "markdown": {
    "auto_format": true,
    "lint_on_save": true,
    "toc_update": true
  },
  "rules": {
    "always_read_claude_md": true,
    "follow_md_standards": true,
    "update_todo_on_change": true
  }
}
```

### 3단계: VS Code 설정

`.vscode/settings.json` 생성:
```json
{
  "files.defaultLanguage": "markdown",
  "markdown.extension.toc.levels": "2..6",
  "markdown.extension.toc.updateOnSave": true,
  "markdown.extension.list.indentationSize": "adaptive",
  "markdown.extension.preview.autoShowPreviewToSide": true,
  "markdownlint.config": {
    "MD033": false,
    "MD041": false,
    "MD024": false,
    "MD025": {
      "front_matter_title": ""
    }
  },
  "[markdown]": {
    "editor.formatOnSave": true,
    "editor.wordWrap": "on",
    "editor.quickSuggestions": {
      "comments": "on",
      "strings": "on",
      "other": "on"
    }
  }
}
```

### 4단계: Git 설정

`.gitignore` 업데이트:
```gitignore
# MD 시스템 임시 파일
*.md.backup
*.md.tmp
.markdownlint-cli2-cache

# IDE 설정 (팀 공유 시 제거)
# .cursor-settings
# .vscode/settings.json
```

`.gitattributes` 생성:
```gitattributes
# MD 파일 설정
*.md text eol=lf
*.md linguist-detectable=true
*.md linguist-documentation=false

# 특별 파일
CLAUDE.md linguist-generated=false
TODO.md linguist-generated=false
```

### 5단계: 자동화 스크립트 (선택)

`scripts/md-check.js`:
```javascript
#!/usr/bin/env node
const fs = require('fs');
const path = require('path');

// 필수 MD 파일 체크
const requiredFiles = [
  'CLAUDE.md',
  'TODO.md',
  'docs/MD_STANDARDS.md'
];

const checkFiles = () => {
  const missing = [];
  requiredFiles.forEach(file => {
    if (!fs.existsSync(path.join(process.cwd(), file))) {
      missing.push(file);
    }
  });
  
  if (missing.length > 0) {
    console.error('❌ 필수 MD 파일 누락:', missing.join(', '));
    process.exit(1);
  }
  console.log('✅ 모든 필수 MD 파일 존재');
};

checkFiles();
```

`package.json` 스크립트 추가:
```json
{
  "scripts": {
    "md:check": "node scripts/md-check.js",
    "md:lint": "markdownlint '**/*.md' --fix",
    "md:toc": "markdown-toc -i README.md && markdown-toc -i docs/*.md"
  }
}
```

## 📁 권장 폴더 구조

```
프로젝트루트/
├── 📄 CLAUDE.md           # AI 컨텍스트 (필수)
├── 📄 TODO.md             # 작업 목록 (필수)
├── 📄 CHANGELOG.md        # 변경 이력
├── 📄 TEAM_SETUP.md       # 팀 온보딩
├── 📄 README.md           # 프로젝트 소개
├── 📁 docs/               # 문서 폴더
│   ├── 📄 MD_STANDARDS.md      # MD 표준
│   ├── 📄 MD_SYSTEM_SETUP_GUIDE.md  # 이 파일
│   ├── 📄 README.md            # 문서 인덱스
│   ├── 📄 DEVELOPMENT.md       # 개발 가이드
│   ├── 📄 API.md              # API 문서
│   └── 📄 FEATURES.md         # 기능 명세
├── 📁 guides/             # 가이드 문서
│   ├── 📄 USER_GUIDE.md
│   └── 📄 ADMIN_GUIDE.md
├── 📁 specs/              # 명세 문서
│   ├── 📄 REQUIREMENTS.md
│   └── 📄 ARCHITECTURE.md
└── 📁 .vscode/            # IDE 설정
    └── 📄 settings.json
```

## 🔄 워크플로우 통합

### 1. 일일 워크플로우
```markdown
# 작업 시작
1. TODO.md 확인 및 업데이트
2. CLAUDE.md 컨텍스트 확인
3. 작업 진행

# 작업 종료
1. TODO.md 진행 상황 업데이트
2. CHANGELOG.md 업데이트 (필요시)
3. 커밋 메시지에 MD 파일 참조
```

### 2. 주간 워크플로우
```markdown
1. 모든 MD 파일 린트 체크
2. 깨진 링크 확인
3. TODO.md 정리 (완료 항목 아카이브)
4. CHANGELOG.md 업데이트
```

### 3. 릴리즈 워크플로우
```markdown
1. 모든 문서 버전 확인
2. CHANGELOG.md 릴리즈 노트 작성
3. README.md 업데이트
4. 문서 태그 생성
```

## 🤖 AI 도구 활용

### Claude/Cursor 활용
```markdown
# CLAUDE.md 활용
- 프로젝트 컨텍스트 자동 로드
- 일관된 코딩 스타일 유지
- 프로젝트별 특수 규칙 적용

# 효과적인 프롬프트
"CLAUDE.md를 참고하여 [작업] 수행"
"TODO.md의 [항목] 구현"
"MD_STANDARDS.md 규칙에 따라 문서 작성"
```

### SuperClaude 명령어
```bash
# 문서 분석
/analyze "@docs/" --focus documentation

# 문서 생성
/document --persona-scribe=ko --follow-standards

# 문서 개선
/improve "@docs/*.md" --focus readability
```

## 🔍 검증 체크리스트

### 초기 설정 검증
- [ ] 모든 필수 MD 파일 생성됨
- [ ] .cursor-settings 설정 완료
- [ ] VS Code 설정 적용됨
- [ ] Git 설정 업데이트됨

### 일일 검증
- [ ] CLAUDE.md 최신 상태 유지
- [ ] TODO.md 정기적 업데이트
- [ ] 새 문서가 표준 준수

### 주간 검증
- [ ] 모든 MD 파일 린트 통과
- [ ] 링크 유효성 확인
- [ ] 문서 일관성 유지

## 🚨 일반적인 문제 해결

### 문제 1: MD 파일 포맷 불일치
```bash
# 해결책
npx markdownlint '**/*.md' --fix
```

### 문제 2: 목차 업데이트 누락
```bash
# 해결책
npx markdown-toc -i README.md
```

### 문제 3: CLAUDE.md 동기화 문제
```markdown
# 해결책
1. 프로젝트 주요 변경사항 확인
2. CLAUDE.md 수동 업데이트
3. AI 도구 재시작
```

### 문제 4: 팀원 간 문서 충돌
```markdown
# 해결책
1. MD_STANDARDS.md 팀 리뷰
2. 공통 규칙 합의
3. 자동화 도구 통일
```

## 📊 성과 측정

### 정량적 지표
- 문서 커버리지 (목표: 80%+)
- MD 린트 통과율 (목표: 95%+)
- 문서 업데이트 주기 (목표: 주 1회+)

### 정성적 지표
- 팀 피드백 만족도
- 온보딩 시간 단축
- 문서 검색 효율성

## 🔗 참고 자료

### 내부 문서
- [MD 표준 가이드](./MD_STANDARDS.md)
- [프로젝트 README](../README.md)
- [개발 가이드](./DEVELOPMENT.md)

### 외부 자료
- [Markdown Guide](https://www.markdownguide.org/)
- [VS Code Markdown](https://code.visualstudio.com/docs/languages/markdown)
- [GitHub Docs](https://docs.github.com/en/get-started/writing-on-github)

## 🎯 다음 단계

1. **기본 설정 완료 후**
   - 팀 전체 교육 실시
   - 문서화 프로세스 정립
   - 자동화 확대

2. **운영 안정화 후**
   - CI/CD 통합
   - 문서 버전 관리
   - 다국어 지원

3. **성숙 단계**
   - 문서 자동 생성
   - AI 기반 문서 검토
   - 지식 베이스 구축

---
*이 가이드는 지속적으로 개선됩니다.*
*최종 수정: 2024-01-15*