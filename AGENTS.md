# Project Agent Rules

## Flutter State Management

- Use Riverpod for all app state management.
- Add state through providers, not local mutable globals or singleton state.
- Use `ConsumerWidget`, `ConsumerStatefulWidget`, `Consumer`, `ref.watch`, `ref.read`, and `ref.listen` consistently with the existing codebase.
- Use `AsyncNotifierProvider` or `FutureProvider` for async feature state.
- Use `StateProvider` only for simple UI state such as selected tab, visibility toggles, filters, and selected category.
- Keep providers close to their feature unless they are shared infrastructure providers.

## Constants

- Use values from `lib/core/constants/constants.dart` for padding, gaps, opacity, border radius, shadows, and app delays.
- Do not hardcode opacity values such as `0.1`, `0.2`, `0.6`, or `0.8` in widgets. Use `opacityLow`, `opacityMedium`, `opacityStrong`, or `opacityHigh`.
- Do not hardcode common padding values such as `2`, `4`, `8`, `16`, `25`, `32`, or `64`. Use `paddingTiny`, `paddingSmall`, `padding`, `paddingLarge`, `middlePadding`, `paddingXL`, or `paddingXXL`.
- Do not hardcode common gaps with `Gap(...)`. Use `gapTiny`, `gapSmall`, `gap`, `gapLarge`, `gapXL`, or `gapXXL`.
- If a new reusable spacing or opacity value is needed, add a named constant to `lib/core/constants/constants.dart` first, then use that constant.
- Prefer `const EdgeInsets` when using constants, for example `const EdgeInsets.all(paddingLarge)`.

## Styling Examples

```dart
color: AppColors.primaryColor.withValues(alpha: opacityLow),
padding: const EdgeInsets.symmetric(horizontal: paddingLarge),
child: gapLarge,
```

