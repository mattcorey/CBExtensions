# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

CBExtensions is a Swift Package Manager library that provides utility extensions for Swift and SwiftUI development. The project uses Swift 6.0 and targets macOS 13+ and iOS 16+.

## Build and Development Commands

### Building and Testing
```bash
# Build the entire package
swift build

# Run all tests (uses Swift Testing, not XCTest)
swift test

# Run tests for a specific target
swift test --filter CommonExtensionsTests
swift test --filter DateTests

# Build for specific platforms
swift build --target CommonExtensions
swift build --target SwiftUIExtensions
swift build --target FittedSheet
```

## Architecture

The codebase follows a modular architecture with three distinct library targets:

### CommonExtensions
Core Swift extensions for fundamental data types like Date and Collection. This is the base layer with no dependencies.

### SwiftUIExtensions  
SwiftUI-specific utilities including:
- Environment variables for device detection (`@Entry` properties for `isPhone`, `isPad`, etc.)
- Optional presentation helpers for sheets/popovers
- Geometry reading utilities (`SizeReader`)
- Conditional view modifiers (`View+If`)

### FittedSheet
Adaptive UI component that renders as sheet on phones, popover on larger devices. Depends on SwiftUIExtensions for device detection via `@Environment(\.isPhone)`.

## Key Design Patterns

- **Extension-Based Design**: Functionality added via Swift extensions rather than inheritance
- **Environment-Driven Adaptivity**: Uses SwiftUI environment for device-specific behavior
- **Protocol-Oriented Programming**: Type-safe generics using protocols like `OptionalProtocol`
- **Swift 6 Concurrency**: Uses `@MainActor` annotations for UI thread safety

## Testing

The project uses **Swift Testing** (not XCTest):
- Use `@Test` attributes instead of `func test...`
- Use `#expect()` assertions instead of `XCTAssert...`
- Test files are in `Tests/` directory following target naming convention

## Important Notes

- Some SwiftUI features require iOS 17-18+ (check `@available` annotations)
- FittedSheet has dependency on SwiftUIExtensions - maintain this relationship
- Code includes educational warnings about proper usage patterns (preserve these)
- No external dependencies - keep it pure Swift/SwiftUI