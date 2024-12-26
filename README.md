# PokeDex

// 완성 후 썸네일 추가

**🎯프로젝트 목적**: MVVM 패턴과 RxSwift를 활용하여 포켓몬 도감 앱 만들기

**⏰프로젝트 일정**: 2024.12.23(월) ~ 2024.01.06(월) 12:00

**🔗Reperance**: [PokeAPI](https://pokeapi.co/#google_vignette)

***

## 🍆 Git Flow

- `main`에서 프로젝트 기초 세팅하기
- `dev`에서 기능 구현하기
- `feat`에서 기능 추가하기
- `test`에서 전체 프로젝트 체크 및 버그 수정하기
- `hofix`에서 긴급한 버그 수정하기
- 기능구현 완료 후 `test` -> `main`으로 **스쿼시 머지**를 통해 ver1.0.0 완성하기

<img width="500" alt="Untitled (9)" src="https://github.com/user-attachments/assets/af6a03fd-eb72-4773-93df-01b6bdc9a3d6" />


***

## 📓 Pull Request 작성 규칙

1. **제목**: 작업한 내용에 대한 간단한 요약
     
2. **작업 세부 사항**:
  - ✨New Content✨: 새로 추가된 기능, 속성 등을 작성
  - ♻️Change Point♻️: 기존과 달라진 내용을 작성
  - 🚨Truble🚨: 작업 중 맞이한 문제, 해결하지 못한 점 등을 작성

3. **Github 커밋 컨벤션 가이드 (이모지 버전)**

  - 기본 커밋 타입
    - ⚒️ `proj` : 프로젝트 관련 설정
    - 📁 `file` : 단순 파일 추가 혹은 이동
    - ✨ `feat` : 새로운 기능 추가
    - 🐝 `fix` : 버그 수정 
    - 📝 `docs` : 문서 수정
    - 💄 `style` : 코드 포맷팅, 세미콜론 누락, 코드 변경이 없는 경우
    - ♻️ `refactor` : 코드 리팩토링
    - ✅ `test` : 테스트 코드, 리팩토링 테스트 코드 추가
    - 🎨 `chore` : 빌드 업무 수정, 패키지 매니저 수정
   
***

## 🌟 필수 구현 기능
- `MVVM` 아키텍처 패턴으로 프로젝트 구현하기
- `NetworkManager` 모델을 만들어 프로젝트 공용 API 담당 객체 생성
- `RxSwift`를 통한 데이터 바인딩
- `UICollectionView`로 포켓몬 이미지 표현하기
- 셀 선택시 `NavigationView`를 통해 `DetaileViewController`로 이동하기
- `DetaileViewController`에서 포켓몬의 상세정보 보여주기

### UI 구조

| UI Image | UI Structure |
| :-: | :-: |
| <img width="661" alt="Untitled" src="https://github.com/user-attachments/assets/5b3d47b7-93ae-4c8e-9a36-696a12c7e292" /> | <img width="704" alt="Untitled (1)" src="https://github.com/user-attachments/assets/34006226-5ac3-4d91-a568-6204655195b8" /> |

### MVVM 구조

<img width="1536" alt="Untitled (2)" src="https://github.com/user-attachments/assets/bb2767bb-8fe5-445b-aa2e-66dd4c6a1451" />

### 프로젝트 구조도

<img width="1536" alt="Untitled (3)" src="https://github.com/user-attachments/assets/6e076c77-f3bf-441f-ba29-cb1419b34c66" />

***

## 💪 도전 구현 기능
- `RxSwift`의 `Relay`를 활용해보기
- 이미지 라이브러리 `Kingfisher` 활용해보기
- `Seatch` 기능 구현하기
- 탭 구분하기
- `AVFoundation` 라이브러리를 활용하여 포켓몬 울음소리 구현하기

### UI 구조

| UI Image | UI Structure |
| :-: | :-: |
| <img width="896" alt="Untitled (4)" src="https://github.com/user-attachments/assets/1eb95133-4a5c-4315-b652-4abfc459b158" /> | <img width="1024" alt="Untitled (5)" src="https://github.com/user-attachments/assets/1d657787-131c-4329-9061-1486807cd4d2" /> |

### MVVM 구조

<img width="1536" alt="Untitled (6)" src="https://github.com/user-attachments/assets/832e84b1-8522-4d6c-b03b-38bd9ffd9548" />

### 프로젝트 구조도

<img width="1408" alt="Untitled (7)" src="https://github.com/user-attachments/assets/c37b7d1e-6738-47a4-89e9-603780d9ced0" />

## 🔥 프로젝트 구현 목표

- 필수기능, 도전기능 모두 구현 완료하기
- RxSwift에 대한 이해도를 높이고 사용 방법 익히기
- MVVM 아키텍처 패턴에 대한 이해도를 높이고 구조 익히기
- 깔끔한 코드와 주석을 작성하여 코드 가독성 높이기
- 예외상황에 대한 고민을 통해 UX 개선하기

## 💡 주요 기능

// 추후 업데이트

## 🤔 기능별 고민사항

// 추후 업데이트
