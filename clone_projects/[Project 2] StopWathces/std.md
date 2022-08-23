## 1. fileprivate

#### 접근 제한자

  - private : 같은 클래스

  - fileprivate : 같은 소스 파일(.swift)

  - internal : 같은 모듈(framework) or 같은 프로젝트

  - public : 모듈 외부까지 가능

  - open : 모듈 외부, 상속 및 override가능(확장 가능)
  
<br><br>


## 2. Timer()

#### https://developer.apple.com/documentation/foundation/timer

  - Timer() 클래스가 존재함
   
  - var timer: Timer()
  
<br><br>


## 3. weak vs unknown

#### 강한 순환 참조(Strong Reference Cycle)발생을 막기 위해 사용됨 ( closure 안에 )

  - weak 
    - weak는 옵셔널 타입 -> nil이 될 수 있음. 만약 참조하고 있는 인스턴스가 메모리에서 해제될 시, ARC가 nil로 참조값을 대체함.
    - 따라서 참조하고 있는 객체가 생명주기가 짧은 경우(weak를 선언한 scope의 객체보다) 사용합니다. (수명이 더 긴 쪽에서 선언)
    
  - unknown
    - weak와 달리 참조하고 있는 인스턴스가 메모리에서 해제될 시, nil이 되지 않음.
    - 만약 참조하고 있는 객체가 매모리에서 해제된 후 접근할 시, crash가 날 수 있.
    - 따라서 참조하고 있는 객체의 생명주기가 현재 scope의 객체보다 생명주기가 더 길거나 같을 경우 사용합니다. (수명이 더 짧은쪽에서 선언)
    
<br><br>


## 4. truncatingRemainder

#### https://developer.apple.com/documentation/swift/float/truncatingremainder(dividingby:)

  - %연산 할 때 두 수 다 Integer이면 상관 없지만, 둘 중 하나라도 Double 이거나 Integer이 아니라면 오류
  
  ```
  var a = 10.0.truncatingRemainder(dividingBy: 3)

  ```swift
  
    
    
    
    
    
    
    
    
    
