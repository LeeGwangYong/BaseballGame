# BaseBall Game

- 모든 데이터는 Immutable하게 사용하도록 한다.

- [Game Runner](#Game\ Runner)
  - [Input](#Input)
  - [Processor](#Processor)

## Game Runner

```swift
// 최초 구동에 대한 책임을지니고 있다.
func gameStart() throws
```

```swift
// 실질적인 게임의 구동에 대한 책임을 지고 있다.
private func run(teams: [Team]) throws
```

## Input

```swift
// Member의 hitAverage의 분포에 따라 추출된 난수를, HitterState로 반환한다.
// -안타: h, 0.1 < h < 0.5
// -스트라이크: (1 - h) / 2 - 0.05
// -볼: (1 - h) / 2 - 0.05
// -아웃: 0.1
func hitterState(of member: Member) throws -> HitterState
```

## Processor

```swift
// Round와 초 / 말 진행 상황을 업데이트하는 책임을 가지고 있다.
// 최종적으로 각 팀에 대한 진행 상황을 반환한다.
func process(about round: Int,
             topTeam: Team, topProgress: GameProgress,
             bottomTeam: Team, bottomProgress: GameProgress) throws 
-> (GameProgress, GameProgress)
```

```swift
// Team의 진행 상황에 대한 책임을 지니고 있다.
// 다음 맴버(타자)를 결정하며, 맴버(타자)에 대하여 수행하도록 한다.
private func process(about team: Team, progress: GameProgress) throws -> GameProgress
```

```swift
// Member의 진행상황에 대한 책임을 지니고 있다.
// hitterState(of:)를 이용하여 현재 Member의 state를 생성하며,
// 게임을 진행시킨다.
private func process(about member: Member, progress: GameProgress) throws -> GameProgress
```

```swift
// HitterState에 대하여 알맞은 처리가 이루어질 수 있도록 한다.
private func process(hitterState: HitterState, progress: GameProgress) -> GameProgress
```

```swift
// 안타의 처리에 대한 책임을 지니고 있다.
private func hitted(_ progress: GameProgress) -> GameProgress
```

```swift
// 볼의 처리에 대한 책임을 지니고 있다.
private func balled(_ progress: GameProgress) -> GameProgress
```

```swift
// 스트라이크의 처리에 대한 책임을 지니고 있다.
private func striked(_ progress: GameProgress) -> GameProgress
```

```swift
// 아웃의 처리에 대한 책임을 지니고 있다.
private func outed(_ progress: GameProgress) -> GameProgress
```