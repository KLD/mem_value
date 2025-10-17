# MemValue Example App

This example demonstrates how to use the `mem_value` package in a Flutter application. The app showcases various types of MemValue implementations with a user-friendly interface.

## Features Demonstrated

- **MemString**: Storing and retrieving string values (username)
- **MemInt**: Storing and retrieving integer values (age)
- **MemDouble**: Storing and retrieving double values (height)
- **MemBool**: Storing and retrieving boolean values (login status)
- **MemList**: Storing and retrieving list values (favorite colors)
- **MemMap**: Storing and retrieving map values (settings)
- **MemDateTime**: Storing and retrieving date/time values (last login)
- **NMemString**: Nullable string values (nickname)
- **MemChoices**: Restricted value choices (theme selection)
- **MemGroup**: Loading and resetting multiple MemValues at once

## Storage Implementation

This example uses `shared_preferences` as the storage backend through `MemStorageDelegate`:

```dart
MemValue.setStorage(
  MemStorageDelegate(
    readValue: (tag) async => prefs.getString(tag),
    writeValue: (tag, value) async => await prefs.setString(tag, value),
    deleteValue: (tag) async => await prefs.remove(tag),
  ),
);
```

## Running the Example

1. Make sure you have Flutter installed and configured
2. Navigate to the example directory:
   ```bash
   cd example
   ```
3. Get the dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## App Structure

The example app consists of:

- **Main Screen**: Interactive cards showing different MemValue types
- **Edit Dialogs**: Simple interfaces to modify values
- **Automatic Persistence**: All changes are automatically saved to storage
- **Reset Functionality**: Reset all values to their initial state

## Key Learning Points

1. **Setup**: How to configure MemValue with a storage backend
2. **Declaration**: How to declare different types of MemValues
3. **Loading**: How to load values from storage using MemGroup
4. **Usage**: How to read and write values seamlessly
5. **Type Safety**: How MemValue ensures type consistency
6. **Choices**: How to restrict values to specific options
7. **Nullable Types**: How to work with nullable MemValues

## Code Highlights

### MemValue Declaration
```dart
final username = MemString('username', initValue: 'Guest');
final age = MemInt('age', initValue: 18);
final isLoggedIn = MemBool('isLoggedIn', initValue: false);
```

### MemChoices Usage
```dart
final theme = MemChoices<String>(
  MemString('theme_choice', initValue: 'light'),
  choices: ['light', 'dark', 'system'],
);
```

### MemGroup Loading
```dart
final memGroup = MemGroup([username, age, isLoggedIn, theme]);
await memGroup.loadAll();
```

### Reading and Writing
```dart
// Reading
String currentUsername = username.value;

// Writing (automatically saves)
username.value = "New Username";

// Or use async method to wait for save completion
await username.setValue("New Username");
```

This example provides a comprehensive demonstration of the mem_value package capabilities and serves as a practical reference for implementing similar functionality in your own applications.