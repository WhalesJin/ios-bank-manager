
# 🏦 은행 창구 매니저 _ 웰시코딩🐶


## 📖 목차
🍀 [소개](#소개) </br>
👨‍💻 [팀원](#팀원) </br>
⏱️ [타임라인](#타임라인) </br>
👀 [시각화된 프로젝트 구조](#시각화된_프로젝트_구조) </br>
💻 [실행 화면](#실행_화면) </br>
🧨 [트러블 슈팅](#트러블_슈팅) </br>
📚 [참고 링크](#참고_링크) </br>

</br>

## 🍀 소개<a id="소개"></a>
한 명의 직원을 가진 은행이 10 ~ 30명의 고객을 받아 응대하는 프로그램입니다.

</br>

## 👨‍💻 팀원<a id="팀원"></a>
| 🐬Whales🐬 | 🍎Zion🍎 |
| :--------: | :--------: |
| <Img src = "https://hackmd.io/_uploads/rkhLfDCYh.png" width="180"> | <Img src = "https://hackmd.io/_uploads/ry9ZHwRt2.png" width="200"> |
|[Github Profile](https://github.com/WhalesJin) |[Github Profile]() |

</br>

## ⏱️ 타임라인<a id="타임라인"></a>
|날짜|내용|
|:--:|--|
|2023.07.10| - Node 클래스 생성 <br> - LinkedList 구조체 생성 <br> - LinkedList Test 진행 |
|2023.07.11| - Queue 구조체 생성 |
|2023.07.12| - Client 구조체 생성 <br> - BankManager 구조체 생성 <br> - Bank 클래스 생성 |
|2023.07.13| - 업무완료 메세지 로직 추가 <br> - 파일 구조정리 |
|2023.07.14| - usleep 메서드를 Thread.sleep 메서드로 수정 |
|2023.07.15| - WorkType 중첩 열거형 생성 |
|2023.07.20| - WorkType을 BankType으로 네이밍 수정 및 파일 분리 <br> - Bank 클래스의 startTask 메서드가 은행 업무 종류별로 수행할 수 있도록 수정 |

</br>

## 👀 시각화된 프로젝트 구조<a id="시각화된_프로젝트_구조"></a>

### ℹ️ File Tree
    ┌── ios-bank-manager
    │   ├── BankManagerConsoleApp
    │   │   ├── Model
    │   │   │   ├── Queue
    │   │   │   │   ├── Node
    │   │   │   │   ├── LinkedList
    │   │   │   │   ├── Queue
    │   │   │   └── Bank
    │   │   │       ├── BankingType
    │   │   │       ├── Client
    │   │   │       ├── BankManger
    │   │   │       └── Bank
    │   │   └── main
    │   └── Tests
    └── README.md

### 📐 Diagram
<p align="center">
    
<img width = "600" src = "https://hackmd.io/_uploads/BkHhdPDc3.png"> <br>

</p>

## 💻 실행 화면<a id="실행_화면"></a>
<img src = "https://hackmd.io/_uploads/BJQvBwRFn.gif" width = "450">
</br>
<img src = "https://hackmd.io/_uploads/Bk90PKL52.gif" width = "455">


## 🧨 트러블 슈팅<a id="트러블_슈팅"></a>
### 1️⃣ `Escaping closure captures mutating 'self' parameter` Error
🚨 **문제점** <br>
Bank Type을 struct로 설정하여 Closure 내부에서 Capture시 Closure내부의 Bank와 클로저 외부의 Bank가 동일하지 않아 경고 문구가 노출 되었습니다.
<br>

💡 **해결방법** <br>
```swift
DispatchQueue.global().async(group: group) {
                self.bankManger.work(client: client)
                semaphore.signal()
            }
```
현재 `Bank Type`의 `startTask` 로직 내부에서는 `Bank Type`의 내부 변수에 접근하는 `async`로직이 존재합니다. 따라서 `Bank Type`을 `struct`로 설정하게 된다면 `async`가 등록될 때의 `Bank`와 `async block` 내에서 `capture` 될 때에의 `Bank`가 서로 다른 `Bank` 일 수 있습니다. 

그 이유는 일반적으로 클로저 내에서 값을 캡쳐했을 때에는 값 타입이든 참조 타입이든 `Strong Reference` 형태로 값을 참조하지만 값 타입의 경우에는 복사된 값에 대한 주소 값을 참조하기 때문에 `async`로 등록할 때의 `Bank`와 실질적으로 `async block`이 실행될 때의 `Bank`가 같은 `Bank`임을 보장할 수 없기 때문입니다. 

따라서 `Bank`를 `Class` 참조 타입으로 설정하여 참조할 수 있도록 변경했습니다. 또한 `Strong Reference` 참조를 하게된다면 순환참조의 가능성에대해 고민해봤지만 위와 같은 경우에서는 `async block`에서는 `Bank`를 참조하고 있지만 `Bank`에서는 해당 `async block`을 직접적으로 참조하고 있지않으므로 순환참조가 발생하지않기 때문에 `[weak self]`의 캡쳐키워드는 생략했습니다.

<br>

### 2️⃣ `DispatchQueue vs OperationQueue`
🚨 **문제점** <br>
DispatchQueue와 OpeartionQueue 중 어떤 방식으로 문제를 해결할지 고민했습니다.
<br>

💡 **해결방법** <br>
조금 더 객체지향적인 프로그램의 동작을 위해 `DispatchQueue`를 사용하여 구현했습니다.

`DispatchQueue`을 활용해 해당 요구사항을 구현하는 방법으로는 `DispatchGroup` 및 `DispatchSemaphore`를 활용하는 방법이 있었고 `OperationQueue`를 활용한다면 `maxConcurrentOperationCount` property 및 `waitUntilAllOperationsAreFinished` 메서드의 활용으로 과제를 해결할 수 있었습니다.

하지만 `Bank`, `BankManager`, `Client`가 코드를 읽는 입장에서 조금 더 자연스럽게 객체지향적으로 의사소통할 수 있는 설계에 대해 고민했고 `Operation`을 상속받는 `Type`을 만들어서 `OperationQueue`에 넣어주는 방법보다는 `DispatchQueue async` 로직 내부에서 `BankManager`가 직접적으로 업무를 실행하고 그 업무를 실행하는 데 있어서 `customer`를 주입 받는 방식을 사용했습니다.

물론 같은 결과물을 나타냈겠지만 조금 더 객체지향에 대해서 고민해볼 수 있어서 좋았습니다.

<br>

### 3️⃣ 값 타입이 `Mutating`이 될 때 수정된 값으로 재할당이 이뤄지는가
🚨 **문제점** <br>
값 타입에서 `Mutating` 키워드가 붙을 때 즉, 타입 내부에서의 값이 수정되었을 때 실질적으로 메모리에 메모리에 저장되는 방식을 고민했습니다.
</br>

💡 **해결방법** </br>
`Mutating`을 나타내는 공식문서에서는 
> The method can then mutate (that is, change) its properties from within the method, and any changes that it makes are written back to the original structure when the method ends. The method can also assign a completely new instance to its implicit self property, and this new instance will replace the existing one when the method ends.

위와 같이 표현되어있지만 해당 글만으로는 확실히 `mutating`이 수정된 값을 반드시 재할당하는 지에 대한 답이 충분히 되지 않았습니다. 조금은 애매한 표현이었다고 생각합니다. 따라서 조금더 해당 관련 지식에 확신을 줄 수 있는 자료를 찾아보던 중 https://github.com/apple/swift/blob/main/docs/MutationModel.rst
`swift`의 `openSource`에 나와있는 자료를 찾게 되었고 그 결과
> The implicit self parameter of a struct or enum method is semantically an inout parameter if and only if the method is attributed with mutating. Read-only methods do not "write back" onto their target objects.

`mutating`이 발생하는 `값 타입(struct, enum)`은 명시적으로 `inout` 키워드가 붙는다.

따라서 `inout`의 경우
> In-out parameters are passed as follows:
> 1. When the function is called, the value of the argument is copied.
> 2. In the body of the function, the copy is modified.
> 3. When the function returns, the copy’s value is assigned to the original argument.

해당 순서로 수정된 값을 재할당 하고 있으므로 `값타입(struct, enum)` 또한 수정된 값을 재할당한다는 결론을 얻었습니다.

<br>

### 4️⃣ BankingType 위치
🚨 **문제점** <br>
- 처음 step3 구현을 할 때는 `Client` 타입이 은행 업무를 알고 있어야 한다고 판단하여 `Client` 타입의 중첩타입으로 `BankingType`을 구현하였습니다.
```swift
struct Client {
    enum BankingType: String, CaseIterable {
        case deposit = "예금"
        case loan = "대출"

        var taskTime: Double {
            switch self {
            case .deposit:
                return 0.7
            case .loan:
                return 1.1
            }
        }
    }

    let turn: Int
    let banking: BankingType

    init(_ turn: Int, _ bankingType: BankingType) {
        self.turn = turn
        self.banking = bankingType
    }
}
```
<br>

💡 **해결방법** <br>

- 하지만 객체 지향적으로 현실 세계와 접목시켜 생각했을 때, 은행업무를 고객(`Client`)과 은행원(`BankManager`) 모두 알아야한다고 생각했고, `work` 메서드를 구현하는 중에도 필요하다고 생각하여 파일분리를 해서 따로 열거형으로 구현하였습니다.
```swift
enum BankingType: String, CaseIterable {
    case deposit = "예금"
    case loan = "대출"

    var taskTime: Double {
        switch self {
        case .deposit:
            return 0.7
        case .loan:
            return 1.1
        }
    }
}
```    

<br>


### 5️⃣ `taskTime`의 위치
🚨 **문제점** <br>
- `taskTime` 프로퍼티는 업무 소요시간으로 객체 지향적으로 두가지 방향을 고민하였습니다.
    - 해당 일을 수행하는 객체는 `BankManager`이므로 `BankManager`가 업무 소요 시간을 가지고 있는 것이 좀 더 객체지향적으로 옳은 설계가 아닐까?
    - 같은 업무라 하더라도 은행별로 절차가 다르기 때문에 정해진 순서대로 일을 하면 `BankManager`가 다르더라도 같은 업무라면 소요 시간이 같을 수 있지 않을까?

<br>

💡 **해결방법** <br>
- 두 가지 의견 다 근거가 충분하다고 생각이 되어 고민하다가 상의 끝에, 현재 프로젝트는 후자로 선택하여 진행하였습니다.
<br>


### 6️⃣ `BankOpenable` 프로토콜의 유무
🚨 **문제점** <br>

- Bank 클래스의 open 메서드는 모든 은행이 가지고 있는 기능이기 때문에 프로토콜 기본 구현을 이용해볼까 고민했습니다.
    ```swift
    // Bank
    protocol BankOpenable {
        func openOrClose()
        func openBanking()
    }

    extension BankOpenable {
        func openOrClose() {
            print("1 : 은행개점\n2 : 종료\n입력", terminator: " : ")
            let input = readLine()

            switch input {
            case "1":
                openBanking()
            default:
                return
            }
        }
    }

    // main
    let weatherBank: BankOpenable = Bank()
    weatherBank.openOrClose()
    ```
    이렇게 쓰게 된다면 `weatherBank`는 `BankOpenable`에서 구현하라고 명시해주었던 `openOrClose`와 `openBanking` 메서드만 알고 있게되고, 구체적 타입에 의존하는게 아니라 추상적인 프로토콜에 의존할 수 있습니다. 즉, 채택할 수 있는 객체라면 어떤 것이든 대체될 수 있으면 테스터블하고 유연한 코드가 될 수 있습니다.
<br>

💡 **해결방법** <br>

- 하지만 `openOrClose` 메서드가 `openBanking` 메서드를 호출하여 불필요한 `openBanking` 또한 프로토콜이 가지고 있게 되면서 `main`이 `openBanking`을 알고 있어야만 하는 추상화가 덜 된 듯한, 불필요한 접근이 느껴져 프로토콜 구현을 삭제하였습니다.

<br>

## 📚 참고 링크<a id="참고_링크"></a>

- [🍎Apple Docs: DispatchSemaphore](https://developer.apple.com/documentation/dispatch/dispatchsemaphore)
- [🍎Apple Docs: Thread Sleep](https://developer.apple.com/documentation/foundation/thread/1413673-sleep)
- [🍎Apple Docs: ModifyingValueTypes](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/methods/#Modifying-Value-Types-from-Within-Instance-Methods)
- [🍎Apple Docs: functions - InOutParameters](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/functions/#In-Out-Parameters)
- [🍎Apple Docs: declarations - InOutParameters](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/declarations/#In-Out-Parameters)
- <Img src = "https://github.com/WhalesJin/ios-bank-manager/assets/124643545/d1df2d8a-6667-438d-9643-aab8a83a4754" width="20"/> [Apple Github: MutationModel](https://github.com/apple/swift/blob/main/docs/MutationModel.rst)
- <Img src = "https://github.com/mint3382/ios-calculator-app/assets/124643545/56986ab4-dc23-4e29-bdda-f00ec1db809b" width="20"/> [야곰닷넷: 동시성프로그래밍](https://yagom.net/courses/동시성-프로그래밍-concurrency-programming/lessons/동시성-프로그래밍/)
- <Img src = "https://hackmd.io/_uploads/ByTEsGUv3.png" width="20"/> [blog: StrongReferenceCycle](https://medium.com/@LeeZion94/strong-reference-cycle-8a88bdd8424b)
