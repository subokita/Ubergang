# Ubergang [ˈyːbɐɡaŋ] - Version 0.3.2

Ubergang is a low level tweening engine for iOS.

## Features

- [x] Tween numeric values, UIColors and CGAffineTransforms
- [x] Tween along UIBezierPaths (Currently supporting paths containing 'moveToPoint(...)', 'addLineToPoint(...)' and 'addCurveToPoint(...)')
- [x] Cubic, Elastic and Linear easings
- [x] Generic tween setup
- [x] Repeat and Yoyo tween options
- [x] Memory management for strong and weak tween object references
- [x] Tween Timelines

## Installation

### [CocoaPods](http://cocoapods.org)
```ruby
platform :ios, '8.2'
use_frameworks!
pod 'Ubergang', '~> 0.2.0'
```

## Tween Configuration

```swift
.options(.Repeat(n))
.options(.Yoyo)
.options(.Repeat(1), .Yoyo)
```

> Using `options` you can let the Tween repeat n (Int) times, let it yoyo or combine both options.
- Repeat will restart the Tween n times where `repeatCycleChange` will be called with every cycle.
- Yoyo will reverse the Tween after it reaches the end value.

```swift
.memoryReference(.Strong)` //(default)
.memoryReference(.Weak)
```

> `memoryReference` determines how to handle the reference count for the tween. Ubergang will increase the reference count if the option is set to `.Strong` or won't increase it if it's set to `.Weak`. These two rules are valid for most cases:
- The Tween is not stored in a field variable -> `.Strong`
- The Tween is stored in a field variable -> `.Weak`

## Usage

### Start a simple numeric Tween (Double)

```swift
UTweenBuilder
  .to( 10.0, current: { 0.0 }, update: { value in print("test double: \(value)") }, duration: 5, id: "doubleTween")
  .start()
```
> This Tween with id 'doubleTween' goes from 0.0 to 10.0 over 5 seconds using a linear easing by default. The current value will be printed with every update.



### Start a weak numeric Tween (Int)

```swift
var tween: NumericTween<Int>?

func run() {
  tween = UTweenBuilder
      .to( 10, current: { 0 }, update: { value in print("test int: \(value)") }, duration: 5, id: "intTween")
      .ease(Elastic.easeOut)
      .memoryReference(.Weak)
      .start()
}
```
> This Tween with id 'intTween' goes from 0 to 10 over 5 seconds using an elastic easing. The current value will be printed with every update.
.memoryReference(.Weak) will store this tween weakly, Ubergang won't increment the reference count. It's up to you to keep the Tween alive.

### Start a numeric Tween repeating 5 times with yoyo

```swift
var tween: NumericTween<Int>?

func run() {
  tween = UTweenBuilder
      .to( 10, current: { 0 }, update: { value in print("test int: \(value)") }, duration: 5, id: "intTween")
      .ease(Elastic.easeOut)
      .options(.Repeat(5), .Yoyo)
      .memoryReference(.Weak)
      .start()
}
```

### Start a weak numeric Tween (CGAffineTransform)

```swift
@IBOutlet var testView: UIView!
var tween: TransformTween?

func run() {
    //declare the target values
    var to = testView.transform
    to.ty = 200.0
    
    tween = UTweenBuilder
        .to( to,
            current: { [weak self] in
                guard let welf = self else {
                    return CGAffineTransform()
                }
                return welf.testView.transform },
            update: { [weak self] value in
                guard let welf = self else {
                    return
                }
                welf.testView.transform = value },
            duration: 2.5,
            id: "testView")
        .memoryReference(.Weak)
    .start()
```
> This Tween with id 'testView' tweens a transform over 2.5 secondsg. The resulting tranform will be assigned to the testView with every update 'welf.testView.transform = value'.



### Start a Timeline containing three Tweens

```swift
var timeline: UTimeline = UTimeline(id: "timeline")

func run() {
  timeline.options(.Yoyo)
  timeline.ease(Cubic.easeInOut)
  timeline.memoryReference(.Weak)

  timeline.append(UTweenBuilder
    .to( 10, current: { 0 }, update: { value in print("0-10 value: \(value)") }, duration: 5, id: "intTween")
  )
  
  timeline.append(UTweenBuilder
    .to( 10.0, current: { 0.0 }, update: { value in print("0.0-10.0 value: \(value)") }, duration: 5, id: "floatTween1")
  )
  
  timeline.insert(UTweenBuilder
    .to( 0.0, current: { 10.0 }, update: { value in print("10.0-0.0 value: \(value)") }, duration: 5, id: "floatTween2"),
    at: 2.5
  )
  
  timeline.start()
}
```
> This Timeline controls one Tween starting at time 0.0 seconds, one Tween starting at time 5.0 seconds and the last one starting at 2.5 seconds. All Tweens are controlled by the timeline with the given easing and options - In this case the tween option `.Yoyo` with easing `Cubic.easeInOut`

## Todos

- Logging and log levels
- Color tweens
- Additional examples

Feedback is always appreciated
