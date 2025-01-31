## Introduction

MemValue simplfies syntax for presistant values stored using SharedPrefrences (or similar packages). In addition, it provides a way to store and retrieve values while securing types. Meaning, when you define a MemValue of type int, only an int value will be stored. This is useful for ensuring that the value you are retrieving is the type you expect.

**Important:** You need to provider MemValue with storage method before using any MemValue.

### Define your MemValue like so:

```dart
var username = MemString('uniqueTag');
```

### Load your value like so:

```dart
await username.load();
```

### Then, write and read like so:

```dart
username.value = "Hello World";
print(username.value);
```

Assigning a value to `username.value` will automatically save the value to storage. To wait for the async operation, use `await username.setValue()`.

## Features

- Easy to use syntax.
- Use your perfered storage method.
- 20 Defined types (including custom).
- `MemChoices` wrapper to ensues only a set of values are storred.
- `MemCollection` to load/reset multiple values.

## Getting started

### 1. Define your `MemStorage` class:

```dart

class MyMemStorage extends MemStorage {
  Future<String?> read(String tag)async{
    // Your code here
  }
  Future<void> write(String tag, String value)async{
    // Your code here
  }
  Future<void> delete(String tag)async{
    // Your code here
  }
}
```

### Alternatively declare a `MemStorageDelegate`:

```dart
var memStorageDelegate = MemStorageDelegate(
  read: (tag) async {
    // Your code here
  },
  write: (tag, value) async {
    // Your code here
  },
  delete: (tag) async {
    // Your code here
  },
);
```

### 2. Setup Storage:

In `main`, call `MemValue.setup` to define storage

```dart
void main() async {
    /* .. .*/

    // Setting up MemStorage
    MemValue.setup(MyMemStorage());

    // --OR--

    // Setting up MemStorage using delegate
    MemValue.setup(memStorageDelegate);

    /* ... */

    runApp(MyApp());
}
```

### 3. Define MemValue:

```dart
var username = MemString('uniqueTag');
```

### 4. Load MemValue:

```dart
await username.load();
```

Note: you may also define `MemCollection` to load multiple values like so:

```dart
var memValue1 = MemString('uniqueTag1');
var memValue2 = MemString('uniqueTag2');

var memCollection = MemCollection([
    memValue1,
    memValue2,
]);

await memCollection.loadAll();
```

### Install package:

```
flutter pub add mem_value
```

## Usage

### Declare a MemValue with init value

```dart
var username = MemString('uniqueTag', initValue: "Hello");
```

### Reset MemValue

Resets value to it's inital value.

```dart
await username.reset();
```

### Declare a persist MemValue

Persist avoid resetting value when `reset` is called. Useful for storing values that should never be reset to inital value.

```dart
var username = MemString('uniqueTag', persist: true);
```

### Define MemValues

#### Non-nullable types:

- MemInt
- MemDouble
- MemString
- MemBool
- MemList
- MemSet
- MemMap
- MemObject
- MemCustom
- MemChoices

#### Nullable types:

- NMemInt
- NMemDouble
- NMemString
- NMemBool
- NMemList
- NMemSet
- NMemMap
- NMemObject
- NMemCustom
- NMemChoices

## Finally

Hope you find this package useful. I am open for suggestions and contributions. Please feel free to open an issue or pull request.
