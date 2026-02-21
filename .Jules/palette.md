## 2025-02-21 - [Accessibility] Tooltips for Icon-Only Navigation
**Learning:** In Flutter apps with many icon-only buttons (AppBar, FAB), tooltips are critical for both accessibility (Semantics) and discoverability. Without them, users must guess the action of an icon, especially for abstract icons like 'analytics_outlined'.
**Action:** Always include the `tooltip` property for any `IconButton` or `FloatingActionButton` that doesn't have a visible text label.

## 2025-02-21 - [UX] Standardized Deletion Confirmation
**Learning:** Users in this discipline app may accidentally delete recurring tasks due to the high-frequency interaction with task cards. A confirmation dialog with clear destructive color coding (using `colorScheme.error`) provides a necessary safety net.
**Action:** Use an `AlertDialog` for all destructive actions, ensuring the confirmation button uses the error color from the theme for consistent visual affordance.
