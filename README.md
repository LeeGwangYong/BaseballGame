# BaseBall Game

- 모든 데이터는 Immutable하게 사용하도록 한다.

- [Game Runner](#Game\ Runner)
  - [Input](#Input)
  - [Processor](#Processor)
  - [Output](#Output)

## Game Runner

```swift
// 최초 구동에 대한 책임을지니고 있다.
func run() {
    let hitter = Hitter()
    let scoreBoard = ScoreBoard()
    let gameProgress = GameProgress(hitter: hitter, scoreBoard: scoreBoard, isOvered: false)
    output(.gameStart)
    output(.firstHitter)
    output(.empty)
    recursivelyRun(gameProgress)
}
```

```swift
// 실질적인 게임의 구동에 대한 책임을 지고 있다.
// Input(`hitterState`)를 받아, Processor(`process`)를 진행한다.
private func recursivelyRun(hitterState: HitterState = hitterState(),
                            _ progress: GameProgress) {
    guard !progress.isOvered else {
      	// 3 아웃이 될 경우 전체 안타수를 출력하고 경기가 종료된다.
        output(.finalScore(scoreboard: progress.scoreBoard))
        output(.gameOver)
        return
    }
    let processedProgress = process(hitterState: hitterState, progress: progress)
    output(.currentProgress(progress: processedProgress))
    output(.empty)
    recursivelyRun(processedProgress)
}
```

## Input

```swift
// "경기가 진행되면 랜덤하게 스트라이크 / 볼 / 안타 / 아웃 네 가지"의 책임을 가지고 있다.
func hitterState() -> HitterState {
    return HitterState.allCases.randomElement() ?? .strike
}
```

## Processor

```swift
// `hitterState`에 따라 게임 진행 상황을 업데이트하는 책임을 가지고 있다.
func process(hitterState: HitterState, progress: GameProgress) -> GameProgress {
    switch hitterState {
    case .hit:
        output(types: [.hit, .nextHitter])
        return hitted(progress)
    case .ball:
        output(.ball)
        return balled(progress)
    case .strike:
        output(.strike)
        return striked(progress)
    }
}
```

```swift
// 안타의 처리에 대한 책임을 지니고 있다.
private func hitted(_ progress: GameProgress) -> GameProgress {
	  // 다음 타자의 차례에서 현재의 안타, 아웃 카운트는 유지되고, 스트라이크와 볼 카운트는 초기화된다.
    return GameProgress(hitter: Hitter(),
                        scoreBoard: ScoreBoard(hit: progress.scoreBoard.hit + 1,
                                               out: progress.scoreBoard.out),
                        isOvered: progress.isOvered)
}
```

```swift
private let maximumBall = 4
// 볼의 처리에 대한 책임을 지니고 있다.
private func balled(_ progress: GameProgress) -> GameProgress {
    let hitter = Hitter(strike: progress.hitter.strike,
                        ball: progress.hitter.ball + 1)
  	// 볼이 4회 누적되면 1 안타가 된다.
    return hitter.ball >= maximumBall ?
        process(hitterState: .hit, progress: progress) : GameProgress(hitter: hitter, scoreBoard: progress.scoreBoard, isOvered: progress.isOvered)
}

```

```swift
private let maximumStrike = 3
private let maximumOut = 3
private func striked(_ progress: GameProgress) -> GameProgress {
    let hitter = Hitter(strike: progress.hitter.strike + 1,
                        ball: progress.hitter.ball)
		// 스트라이크가 3회 누적되면 1 아웃이다.
    if hitter.strike >= maximumStrike {
        let scoreBoard = ScoreBoard(hit: progress.scoreBoard.hit, out: progress.scoreBoard.out + 1)
        let isGameOvered = scoreBoard.out >= maximumOut
        isGameOvered ? output(.out) : output(types: [.out, .nextHitter])
      	// 다음 타자의 차례에서 현재의 안타, 아웃 카운트는 유지되고, 스트라이크와 볼 카운트는 초기화된다.
        return GameProgress(hitter: Hitter(),
                            scoreBoard: scoreBoard,
                            isOvered: isGameOvered)
    } else {
        return GameProgress(hitter: hitter,
                            scoreBoard: progress.scoreBoard,
                            isOvered: progress.isOvered)
    }
}

```



## Output

```swift
enum OutputType: CustomStringConvertible {
    case gameStart
    case gameOver

    case firstHitter
    case nextHitter

    case hit
    case ball
    case strike
    case out

    case currentProgress(progress: GameProgress)
    case finalScore(scoreboard: ScoreBoard)

    case empty

    var description: String {
        switch self {
        case .gameStart:
            return "신나는 야구 게임!"
        case .gameOver:
            return "GAME OVER"
        case .firstHitter:
            return "첫 번째 타자가 타석에 입장했습니다."
        case .nextHitter:
            return "다음 타자가 타석에 입장했습니다."
        case .hit:
            return "안타!"
        case .ball:
            return "볼!"
        case .strike:
            return "스트라이크!"
        case .out:
            return "아웃!"
        case .currentProgress(let progress):
            return "\(progress.hitter.strike)S, \(progress.hitter.ball)B, \(progress.scoreBoard.out)O"
        case .finalScore(let scoreboard):
            return "최종 안타수: \(scoreboard.hit)"
        case .empty:
            return ""
        }
    }
}

// Output을 단일로 출력하는 책임을 가지고 있다.
func output(_ type: OutputType) {
    print(type.description)
}

// 다수의 Ouput을 일렬로 출력하는 책임을 가지고 있다.
func output(types: [OutputType]) {
    print(types.map { $0.description }.joined(separator: " "))
}

```

