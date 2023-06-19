<img src="https://github.com/heestand-xyz/ProCom/blob/main/Assets/ProCom.png?raw=true" width=128/>

# ProCom

Protocol Communication

## Swift Package

```swift
.package(url: "https://github.com/heestand-xyz/ProCom", from: "0.0.1")
```

## Send

```swift
import ProCom

let proCom = ProCom(over: .osc, io: .out)
        
let message = Message(value: 42, address: Address("test"))
try proCom.send(message, over: .osc)
```

## Receive

```swift
import ProCom

let proCom = ProCom(over: .osc, io: .in)

for await message in proComIn.receive(over: .osc) {
    print(message.address, message.values)
}
```
