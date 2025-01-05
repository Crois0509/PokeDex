# <img width="30" alt="Untitled (0)" src="https://github.com/user-attachments/assets/b202673f-0784-4190-bf0c-559f0bb38189" /> PokeDex

![Group 9](https://github.com/user-attachments/assets/ea4b887b-c45a-4917-992d-8f732d479bb1)

**🎯프로젝트 목적**: MVVM 패턴과 RxSwift를 활용하여 포켓몬 도감 앱 만들기

**⏰프로젝트 일정**: 2024.12.23(월) ~ 2024.01.06(월) 12:00

**🔗Reperance**: [PokeAPI](https://pokeapi.co/#google_vignette)

***

## 📱 Preview

| | 시연 영상 | |
| :-: | :-------------------: | :-: |
| | ![무제](https://github.com/user-attachments/assets/7304c92a-7ba8-47c4-9628-1746486d8d1c) | |

| Icon | Lunch | Main |
| :-: | :-: | :-: |
| ![Group 4](https://github.com/user-attachments/assets/5278cc77-7663-4ec6-9374-1f32883dc260) | ![Simulator Screenshot - iPhone 16 Pro - 2025-01-03 at 16 45 38](https://github.com/user-attachments/assets/ff6be187-d771-404c-8372-e47f26e4677d) | ![Simulator Screenshot - iPhone 16 Pro - 2025-01-05 at 14 08 39](https://github.com/user-attachments/assets/50510f00-aba2-439b-8836-48b66b0d3f49) |


| Detail | Search | Search 2 |
| :-: | :-: | :-: |
| ![Simulator Screenshot - iPhone 16 Pro - 2025-01-05 at 14 09 26](https://github.com/user-attachments/assets/773b769b-bd06-4387-9675-2d659d73670b) | ![Simulator Screenshot - iPhone 16 Pro - 2025-01-03 at 16 46 42](https://github.com/user-attachments/assets/60ddd6a0-6729-4ef2-aca8-abe5531c11cd) | ![Simulator Screenshot - iPhone 16 Pro - 2025-01-05 at 14 08 25](https://github.com/user-attachments/assets/aa1f8dc2-c90e-4c13-b65b-a1bb77cc5cb3) |

| SideMenu | MyPokemon | Throw |
| :-: | :-: | :-: |
| ![Simulator Screenshot - iPhone 16 Pro - 2025-01-05 at 14 07 55](https://github.com/user-attachments/assets/e1a68e63-d0e3-4fde-834b-0f48a5db7a5b) | ![Simulator Screenshot - iPhone 16 Pro - 2025-01-05 at 14 11 16](https://github.com/user-attachments/assets/4fbf731a-650f-4b66-b703-ed53bd9a9892) | ![Simulator Screenshot - iPhone 16 Pro - 2025-01-05 at 14 08 05](https://github.com/user-attachments/assets/1194d66e-3c58-4570-9e8f-54b919986cad) |

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

***

## 💡 주요 기능

1. 모든 포켓몬의 목록 살펴보기

2. 포켓몬에 대한 상세 정보 확인하기

***

## 🤔 기능별 고민사항


### 1) 🚨 URL 관리

이번 과제에서 사용되는 URL은 2가지 이다. 하나는 포켓몬의 데이터를 불러오는 URL이고, 하나는 포켓몬의 이미지를 불러오는 URL이다.

처음에는 별 생각없이 필요한 곳에 URL을 직접 `String` 타입으로 작성하여 사용했는데, 이렇게 하니 코드가 너무 길어지고 관리가 어렵다는 문제가 있었다.
어떻게 하면 좋을까 고민하다가 URL을 `enum`으로 관리하자고 생각했다.

이 때, 문제가 되었던 점은 각각의 URL이 항상 고정된 값이 아니라 변동이 발생한다는 점이었다.
그러니까 Quary라고 하는 부분이 계속해서 바뀌어야 하는 상황이었기 때문에 이를 어떻게 구현할까 고민했다.

그러다가 연관값을 사용하면 쉽게 구현할 수 있을 것 같아서 한번 시도해 보았다.
```swift
enum URLManager {
    case pokemonData(limit: Int, offset: Int)
    case pokemonImage(id: Int)
}
```
이렇게 하면 특정 케이스를 선택했을 때 연관값을 입력해 주어야 하고, 이 연관값으로 Quary를 변경시키면 되겠다고 생각했다.
```swift
func sendURL() -> String {
     switch self {
     case .pokemonData(limit: let limit, offset: let offset):
          return "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)"
     case .pokemonImage(id: let id):
          return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
     }
}
```
이렇게 `enum` 안에 메소드로 구현해서 사용하니까 잘 작동하는 것을 볼 수 있었다.

그러나, 이렇게 하니까 URL을 사용할 때 코드가 안 이쁘다고 생각했다.
```swift
URLManager.pokemonData(limit: limit, offset: offset).sendURL()
```
위와 같은 형식이 되기 때문이다.

그래서 생각했다. 굳이 메소드로 구현하지 말고 계산 프로퍼티로 구현하자고

```swift
var sendURL: String {
     switch self {
     case .pokemonData(limit: let limit, offset: let offset):
          return "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)"
     case .pokemonImage(id: let id):
          return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
     }
}
```
이렇게 하니 크게 코드를 바꾸지 않고도 같은 동작을 구현할 수 있었고, 코드를 사용할 때 전보다 보기 좋아졌다는 생각이 들었다.

```swift
// 실사용 예시
URLManager.pokemonData(limit: limit, offset: offset).sendURL
```


### 2) 🚨 CompositionalLayout VS FlowLayout

메인 화면의 대부분을 차지하는 것은 `UICollectionView`이다. 때문에 이 뷰를 구현하고 나면 대부분의 UI 작업이 끝나는 것인데, 너무 간단히 끝내면 재미 없으니 이번에 새로 배운 `CompositionalLayout`을 사용해보자고 생각했다.

그러나 막상 구현할 때가 되니, 3*n 형식의 배열을 가지는 컬렉션뷰를 `FlowLayout`으로 간단히 구현할 수 있는데 `CompositionalLayout`을 써서 구현하는 것이 의미가 있을까 싶었다.

그래서 둘을 비교해 보았는데, 결론적으로는 `FlowLayout`을 사용하여 구현하기로 결정하였다.

그 이유는, 굳이 `CompositionalLayout`을 사용하지 않아도 될 정도로 단순하고 간단한 UI인 것과 스크롤 방향이 단방향인 점, 섹션의 구분이 없고 헤더나 푸터가 없는 점 등 꼭 `CompositionalLayout`을 사용하지 않아도 충분히 구현할 수 있었기 때문이다.
물론, `CompositionalLayout`을 사용하면 성능상의 이점이나 관리의 용이성이 있을 수 있지만, 이번 과제의 주요 목표가 RxSwift와 MVVM 패턴에 대해 숙달시키는 것이라고 생각했을 때, 굳이 여기서 시간을 낭비할 필요가 없다고 생각했다.

대신, 모든 기능을 완성하고도 시간이 남는다면 `CompositionalLayout`을 사용해서 리팩토링 해보자고 생각하였다.


### 3) 🚨 클래스의 역할과 책임

이번 과제의 필수 구현 항목 중 `NetworkManager`를 구현하는 항목이 있다.

말 그래도 네트워크와 관련된 작업들을 담당하는 클래스인데, 이 클래스를 싱글톤 패턴으로 만들어 다른 클래스에서도 사용할 수 있도록 구현하였다.
이 때, 네트워크 매니저가 가진 메소드는 특정 url을 JSON 모델 파일로 디코딩 해주는 메소드 뿐이었는데, 과제를 계속 구현하다보니 디코딩 없이 API 통신을 필요로 하는 부분이 있었다.

바로 포켓몬의 이미지를 불러오는 작업이었다. 당연히 기존 링크에서 이미지를 가져오는 줄 알았는데, 포켓몬 이미지는 완전 다른 url에서 직접 png 파일을 가져오는 형식이었기 때문에 별도로 디코딩이 필요하지 않았다. 그래서 MainViewModel에서 직접 url을 입력하고 API 통신을 통해 이미지를 불러왔는데, 나중에 다시 보니 API 통신이라는 작업은 네트워크 매니저가 해야하는 일이 아닌가? 하는 생각이 들었다.

네트워크 매니저의 역할이 API 통신 등의 네트워크와 관련된 작업을 하는 것인데, 그 작업을 다른 클래스에서 한다면 네트워크 매니저의 존재 의미가 퇴색되는게 아닌가 생각했다.

그럼 포켓몬 이미지를 불러오는 API 작업도 네트워크 매니저한테 일임하면 되는게 아닌가?

여기서 또 고민에 빠진 점은, 현재 상태에서 이미지를 불러오는 작업은 MainViewModel 외에 아무도 없다. 그런데 네트워크 작업이라는 이유로 MainViewModel 만을 위해 네트워크 매니저에게 작업을 일임하는게 맞는걸까 하는 의문이 생긴 것이다. 네트워크 매니저를 별도로 선언한 것은 결국 프로젝트 내에서 네트워크와 관련된 작업을 네트워크 매니저가 맡아 재사용성을 높이기 위해서인데, 재사용이 될지 안될지 불분명한 코드를 네트워크 매니저에게 일임하는 것이 맞는 것인가 하는 의문이었다.

주변 팀원들과 튜터님께 이에 대한 질문을 하고 답변을 구했는데, 다들 의견이 달랐다.
그렇지만 조언을 구한 덕분에 결론은 내릴 수 있었는데, 결론은 네트워크 매니저에게 작업을 일임하자는 것이었다.

그 이유는, 클래스와 각 메소드의 역할과 책임을 확실하게 나누기 위한 것과, 이미지를 불러오는 작업은 재활용될 가능성이 높다고 생각해서이다.
설령 MainViewModel에서만 사용되는 코드라고 하더라도, MainViewModel에서 직접 선언하여 사용하는 것보다는 네트워크 매니저를 통해서 API 작업을 하는 것이 역할 분리가 더 잘 된다고 생각했고, 이미지는 어디서든 재활용될 확률이 높기 때문에 재활용할 수 있도록 미리 구현해 두어서 나쁠 것이 전혀 없다고 생각했기 때문이다.

```swift
final class NetworkManager {
     func fetchImage(id: Int) -> UIImage? {
        var resultImage: UIImage?
        guard let url = URL(string: URLManager.pokemonImage(id: id).sendURL) else { return nil }
        
        DispatchQueue.global().sync {
            guard let imageData = try? Data(contentsOf: url) else {
                resultImage = nil
                return
            }
            
            guard let image = UIImage(data: imageData) else {
                resultImage = nil
                return
            }
            
            resultImage = image
        }
        
        return resultImage
    }
}
```


### 4) 🚨 데이터 바인딩 추상화하기

MainViewModel에서는 RxSwift를 활용하여 데이터 바인딩을 위한 비즈니스 로직을 작성해야 했다.
RxSwift는 아직 어려워서 일단 기능 구현을 목표로 열심히 코드를 작성했는데, 그 결과가 아래와 같다.

```swift
final class MainViewModel {
    private let limit: Int = 20
    private let offset: Int = 0

    let disposeBag = DisposeBag()

    let pokeDexData = BehaviorSubject(value: [PokemonData]())

    init() {
        fetchPokeDex(self.pokeDexData)
    }

    private func fetchData<T: Decodable>(url: URL, decodingType: T.Type) -> Single<T> {
        return NetworkManager.shared.fetch(url: url)
    }

    private func fetchPokeDex(_ subject: BehaviorSubject<[PokemonData]>) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)") else {
            print(NetworkError.invalidURL.errorDescription)
            return
        }

        fetchData(url: url, decodingType: PokemonDataModel.self)
            .subscribe(onSuccess: { data in
                subject.onNext(data.results)

            }, onFailure: { error in
                subject.onError(error)
                print(NetworkError.dataFetchFail.errorDescription)

            }).disposed(by: self.disposeBag)
    }
}
```

나름 재사용성을 높여서 작성한다고 작성했는데, 여전히 코드가 지저분하다고 느껴졌다.
어떻게 하면 더 깔끔한 코드를 작성할 수 있을까 리팩토링을 고민하다가, 다른 뷰 모델을 만들 때도 비슷한 메소드를 사용해야 한다는 사실을 깨닫게 되었다.

그럼 차라리 프로토콜로 필수 기능들을 선언해두고, 이 프로토콜을 채택하는 클래스를 만들어서 필수 기능을 구현하면 어떨까?
그리고 뷰 모델의 생성자를 만들어서 초기화할 때 클래스 인스턴스를 주입하도록 하면 기능의 추상화를 달성할 수 있지 않을까?

물론 코드를 완전 뒤엎어야 했지만... 시도할만한 가치가 있다고 생각하여 새로 파일을 만들고 바로 작업을 시작했다
```swift
protocol PokemonServiceProtocol {
    func fetchPokemonList(limit: Int, offset: Int) -> Single<PokemonDataModel>
    func fetchPokemonDetails(_ datas: [PokemonData]) -> Single<[PokemonDetailDataModel]>
}
```
먼저 뷰 모델이 필수로 가질 메소드는 포켓몬의 데이터를 받아오는 메소드와 디테일한 데이터로 변환하는 메소드이다. 이를 프로토콜에서 선언해주고 이 프로토콜을 채택하는 클래스를 생성해준다.
```swift
final class PokemonManager: PokemonServiceProtocol {
    func fetchPokemonList(limit: Int, offset: Int) -> Single<PokemonDataModel> {
        guard let url = URL(string: URLManager.pokemonData(limit: limit, offset: offset).sendURL) else {
            print(NetworkError.invalidURL.errorDescription)
            return Single.error(NetworkError.invalidURL)
        }
        
        return NetworkManager.shared.fetch(url: url)
    }
    
    func fetchPokemonDetails(_ datas: [PokemonData]) -> Single<[PokemonDetailDataModel]> {
        return Observable.from(datas)
            .flatMap { data -> Single<PokemonDetailDataModel> in
                guard let url = URL(string: data.url) else {
                    return Single.error(NetworkError.invalidURL)
                }
                return NetworkManager.shared.fetch(url: url)
            }
            .toArray()
    }
}
```
RxSwift 코드도 함께 사용하면 구독을 통한 기능의 확장성도 확보할 수 있기 때문에 재활용성도 좋다고 생각했다.
이렇게 하니 뷰 모델에 작성된 코드도 줄고, 추후 다른 뷰 모델을 구현할 때도 손쉽게 기능을 구현할 수 있어 무척 좋았다.

사실 추상화를 고민하여 겪은 시행착오가 무척 많은데, 기록을 하지 않으면서 코드를 작성한 탓에 내용이 휘발되어 버렸다...

커밋도 추상화를 완료한 뒤에 한 탓에 기록이 없다...

앞으로는 이런 작업을 할 때 기록을 남겨가며 작업해야겠다고 생각했다. 


### 5) 🚨 무한 스크롤 버그?

이번 과제의 마지막 단계에서는 '무한 스크롤'을 구현해야 한다. 사실 이전에 무한 스크롤이 어떻게 구현되는 것인지 궁금해서 찾아보고 연습한 적이 있었기 때문에 구현은 어렵지 않으리라고 생각했다.

우선, 무한 스크롤이 작동되는 지점을 설정해줘야 하는데, 컬렉션뷰의 델리게이트 메소드를 활용했다.
```swift
func scrollViewDidScroll(_ scrollView: UIScrollView) {
     let currentOffset = scrollView.contentOffset.y
     let visibleHeight = scrollView.contentSize.height
     let totalHeight = scrollView.frame.height
     let threshold = visibleHeight - totalHeight
        
     if currentOffset >= threshold && !self.didFeched {
          self.viewModel.reload()
          self.didFeched = true
          self.layoutIfNeeded()
     }
}
```
위 코드는 컬렉션뷰를 스크롤 중일 때, 현재 스크롤의 위치를 확인하여 스크롤의 위치가 컬렉션뷰의 컨텐츠뷰 최하단에 위치해 있는지 검증한다.
그 뒤, 만약 스크롤의 위치가 최하단에 있고, 현재 데이터를 패치하고 있지 않다면 `reload` 메소드를 호출한다.

`reload` 메소드는 현재까지 불려진 포켓몬 리스트의 다음 포켓몬 리스트를 API 통신을 통해 불러오는 메소드이다.
이 메소드를 통해 데이터를 새로 불러오면, 컬렉션뷰의 데이터 소스에 변화가 생기고 새롭게 추가된 포켓몬들이 셀에 표시되게 된다.

![무제3](https://github.com/user-attachments/assets/b39755c5-a83f-4017-bbe3-614bf111eb77)

이렇게 무한 스크롤을 구현하긴 했지만... 몇가지 문제가 발생했다.

첫 번째로, 포켓몬에 대한 데이터가 무작위로 들어오는 바람에 셀의 위치가 계속해서 뒤바뀌는 듯한 문제가 있었다. 보고있으면 어지럽고... 완성된 앱이라는 감상을 주지 못한다.

두 번째로, 데이터가 중첩되거나 스킵되는 문제가 발생했다. 스크롤을 계속 반복해서 계속 최하단을 유지하면, 이미 데이터를 불러오고 있는데도 또 새로운 데이터를 불러오는 탓에 일부 데이터가 스킵되거나 중첩되는 문제가 발생했다.
이 문제는 `didFetched`라는 `Bool` 타입의 변수를 만들어서 true라면 `reload`가 되지 않도록 하여 방지했다고 생각했는데, 여전히 문제가 발생하고 있었다.

마지막으로 ⚠️ Synchronization anomaly was detected. 라는 에러가 발생하는 문제이다.

이는 RxSwift에서 경고하는 에러로 무한 스크롤을 하다보면 때때로 발생했는데, 서로 다른 스레드에서 동시에 이벤트를 방출하거나 하는 경우 발생하는 에러라고 한다.
에러문구를 쭉 살펴보면 `.observe(on:MainScheduler.asyncInstance)`를 설정하여 해결하라고 나온다.

결과적으로 보면 위의 세 문제는 모두 같은 이유 때문에 발생하는 문제이다. **데이터를 로드하는 작업이 어딘가에서 동시에 이루어진다는 것이다.**

이를 어떻게 해결하면 좋을까. 그리고 어떻게 해결하면 UX도 개선할 수 있을까 고민하다가 생각한 것이 로딩의 구현이었다.

스크롤을 최하단으로 내리게 되면 데이터 로드가 발생하니까 그 동안은 스크롤을 못하도록 막고, 사용자에게는 데이터를 불러오는 중이라는 것을 알려주기 위해 `UIActiveIndicvatorView`를 사용하여 화면에 로딩바를 표현하는 것이다.
이렇게 하면 스크롤로 인한 데이터 로드가 딱 1번씩만 발생하게 되고, 이를 통해 중복 호출이나 데이터 중첩 등을 한 번에 해결할 수 있을 것이라고 생각했다.

구현은 간단했다. 먼저 `UIActiveIndicvatorView`의 객체를 만들어준다.
```swift
private var activityIndicator = UIActivityIndicatorView()
```
그리고 어떤 조건에서 이 객체가 작동될 것인지 메소드를 작성해주어야 하는데, 이미 만들어뒀던 `didFetched`를 활용하기로 했다.
```swift
func dataFetched() {
     switch self.didFeched {
     case true:
          self.activityIndicator.isHidden = false
          self.activityIndicator.startAnimating()
            
     case false:
          self.activityIndicator.isHidden = true
          self.activityIndicator.stopAnimating()
     }
}
```
위의 코드는 현재 `didFetched`의 상태에 따라 분기를 나눠 로딩바를 어떻게 표현할 것인지 결정하는 메소드이다.
만약 현재 데이터를 불러오고 있다면 로딩바가 표현되며 더이상 스크롤할 수 없게 되고, 데이터 패치가 완료되면 로딩바가 사라지며 다시 정상작동이 가능하도록 하였다.

| 로딩바 추가 전 | 로딩바 추가 후 |
| :-: | :-: |
| ![무제3](https://github.com/user-attachments/assets/c5e61f51-c0ad-4a17-b5ce-3e34f10d6819) | ![무제4](https://github.com/user-attachments/assets/1ef5981b-f451-4f64-9ede-90b8fd6bfd55) |

이렇게 구현하니 마치 실제 앱 같기도 하고... 안정성이 훨씬 커졌다.
다만, 이전보다 데이터를 불러오는 속도가 느리기 때문에 사용자에게 호불호가 갈릴 수 있다고 생각한다.

지금은 데이터를 한 번에 30개씩 불러오고 30개가 다 불러와지면 로딩이 끝나는 식으로 구현이 되어 있는데, 이것을 줄이면 더 빠른 작동도 가능할 것이다.
잦은 새로고침과 빠른 로딩, 비교적 적은 새로고침과 느린 로딩 둘 중 어느 것이 UX에 더 적합한지는 어려운 문제 같다.

### 6) 🚨 검색기능 버그
챌린지 구현으로 포켓몬 검색 기능을 만들던 중 버그(?)를 발견했다. 검색바에 포켓몬의 정보를 입력하면 해당 포켓몬이 표시는 되지만, 도감 번호가 잘못 표시되는 문제가 있었다.

예를 들어 피카츄의 도감 번호는 25여야 하는데, 검색 결과에서는 217로 나타나는 등 데이터가 제대로 정렬되어 있지 않는 문제가 있었다. 왜 이런 문제가 발생했는지 원인을 분석한 결과 검색 데이터의 기반이 된 `koreanNames` 라는 딕셔너리 구조가 원인임을 확인할 수 있었다.

#### 버그 영상

![1](https://github.com/user-attachments/assets/f6b87a1f-3c74-4984-89e1-4a87f8c95f11)

나는 검색 데이터를 `koreanNames`를 이용하여 아래와 같이 구현하였다.
```swift
typealias Names = (String, String)

private static let koreanNames: [String: String] = [ ... ]

static let pokemonList: [(id: String, name: Names)] = {
	var list = [(id: String, name: Names)]()

	for (index, data) in koreanNames.enumerated() {
		let names: Names = (data.key, data.value)
		let item = (id: "\(index + 1)", name: names)
		list.append(item)
	}

	return list
}()
```
딕셔너리의 인덱스를 이용해서 도감 번호를 작성하였는데, 문제는 딕셔너리가 데이터의 순서를 보장하지 않기 때문에 이를 배열로 변환하는 과정에서 순서가 뒤섞이며 도감 번호와 이름 간의 매핑이 잘못되는 것이었다.

이 문제를 해결하기 위해서 어떻게 해결할 수 있을지 고민을 하다가 API 통신을 이용하여 데이터 소스를 구현하기로 결정하였다.
기존에는 `forEach`를 통해 `pokemonList`를 구현했지만, 이는 데이터 관리와 검색의 정확성을 유지하기 어려운 방식이었다. 이에 따라, 포켓몬 정보를 API를 통해 가져오는 방식으로 전환하여 정확성을 높일 수 있도록 변경했다.
```swift
private var pokemonList: [PokemonData] = [] // 모든 포켓몬에 대한 정보가 담긴 배열

/// 모든 포켓몬의 정보를 불러오는 메소드
func dataLoad() {
	self.pokemonManager.fetchPokemonData(urlType: .pokemonList(limit: 1025, offset: 0), modelType: PokemonDataModel.self)
		.observe(on: ConcurrentDispatchQueueScheduler(qos: .default))
		.subscribe(onSuccess: { [weak self] data in
			guard let self else { return }
                
			self.pokemonList = data.results
                
		}, onFailure: { error in
        
			print(error)
                
		}).disposed(by: self.disposeBag)      
}
```
이 메소드는 API를 통해 1025개의 포켓몬 데이터를 정렬된 상태로 제공하여 정확한 도감 번호를 보장할 수 있다. 실제로 데이터가 잘 정렬이 되어 들어오는지 확인해보기 위해 브레이크 포인트를 걸고 확인한 결과 도감 순서대로 데이터가 들어오는 것을 확인할 수 있었다.

![스크린샷 2025-01-02 19 31 43](https://github.com/user-attachments/assets/22c97b25-df30-485f-84e1-bbf9fbb3a91b)

데이터 소스를 변경한 이후 검색 로직도 전면적으로 재구성 할 필요가 있었다.
검색창에 입력된 텍스트를 기반으로 포켓몬 이름과 도감 번호를 정확히 필터링할 수 있도록 로직을 설계했으며, 이 과정에서 API를 통해 가져온 데이터를 `PokemonData` 배열 형태로 정리했다. 이 배열에서 각 포켓몬의 이름(name)을 추출하고, 배열의 인덱스를 활용해 도감 번호(id)를 정확히 부여하는 방식으로 구현하였다.

또, 도감 번호, 영어 이름, 한국어 이름을 모두 대응할 수 있도록 메소드를 구현하여 기능을 확장하였다.
```swift
/// 검색한 값과 관련있는 포켓몬 데이터를 이벤트로 방출하는 메소드
/// - Parameter text: 검색창 입력 값
func search(text: String) {
	let list = containsSearchResult(text: text)
        
	guard list.count > 0 else { return }
        
	self.searchPokemonList.onNext(list)
}

/// 입력된 값과 연관된 포켓몬 리스트를 반환하는 메소드
/// - Parameter text: 입력 값
/// - Returns: 포켓몬 ID, Name 배열
func containsSearchResult(text: String) -> [(Int, String)] {
	var searchList: [(Int, String)] = []
        
	let list = self.pokemonList.enumerated().filter { index, data in
		PokemonTranslator.getKoreanName(for: data.name).contains(text) ||
		data.name.contains(text.lowercased()) ||
		(index + 1).contains(Int(text) ?? -1)
	}.map {
		($0.offset, $0.element)
	}
        
	searchList += addData(datas: list)
        
	return searchList
}
    
/// 포켓몬 데이터 배열을 ID, Name 배열로 반환하는 메소드
/// - Parameter datas: 포켓몬 ID와 포켓몬 데이터가 포함된 배열
/// - Returns: 포켓몬 ID와 포켓몬 이름을 담은 튜플 배열
func addData(datas: [(Int, PokemonData)]) -> [(id: Int, name: String)] {
	var result: [(Int, String)] = []
        
	datas.forEach { index, data in
		let id = index + 1
		let name = PokemonTranslator.getKoreanName(for: data.name)
		let item = (id, name)
		result.append(item)
	}
        
	return result
}

// MARK: - Int Extension Method
extension Int {
    /// Int 타입끼리의 contains 메소드
    /// - Parameter digit: 비교할 값
    /// - Returns: digit이 self에 포함된 경우 true, 그렇지 않은 경우 false
    func contains(_ digit: Int) -> Bool {
        let number = String(self)
        let digitNumber = String(digit)
        
        return number.contains(digitNumber)
    }
}
```

여기서 가공된 `[(id: Int, name: String)]` 타입의 배열을 RxSwift를 활용하여 테이블뷰와 바인딩 하였고, 값이 업데이트 되면 그 결과가 즉시 반영될 수 있도록 구현했다.

이렇게 구현된 최종 검색 기능은 사용자가 도감 번호, 한국어 이름, 영어 이름 중 어떤 것을 입력하더라도 정확한 포켓몬 정보를 보여줄 수 있게 되었다. API를 이용하여 검색 데이터를 구현했기 때문에 도감 번호 오류가 완전히 해결되었으며, 검색 기능의 안정성과 정확성이 크게 향상되었다.

다만 이를 구현하기 위해 고차함수를 많이 사용했는데... 이 탓에 시간 복잡도가 증가하는 문제가 있는 점이 신경 쓰인다.
어떤 코드가 더 좋은 코드일까? 실제로 검색바를 구현하는 방법들을 보고 비교해보며 더 나은 코드를 작성할 수 있도록 노력해 보아야겠다고 생각했다.

#### 구현 결과
![2](https://github.com/user-attachments/assets/d3784a6f-f3d5-4b5e-984f-a6a4661a1b9a)


