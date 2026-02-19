## 2025-05-15 - [Consistent Navigation in GoRouter]
**Learning:** Mixing `Navigator.push` with `GoRouter` in a Flutter app creates inconsistent navigation patterns and can break routing state. Always define new screens as routes in the central router config.
**Action:** Check `main.dart` for existing routing architecture before implementing navigation to new or existing screens.

## 2025-05-15 - [Accessibility for Icon-only Chips]
**Learning:** Visual selection chips (like color pickers) that lack text labels are invisible to screen readers.
**Action:** Always provide `tooltip` and descriptive semantic labels for non-textual interactive elements.
