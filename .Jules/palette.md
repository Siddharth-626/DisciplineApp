## 2026-03-19 - Standard Confirmation Pattern
**Learning:** Destructive actions like task deletion should always be preceded by a confirmation dialog to prevent accidental data loss. Using a Material `AlertDialog` with a clear 'Delete' button styled with `Theme.of(context).colorScheme.error` provides a consistent and safe user experience.
**Action:** Always implement confirmation dialogs for destructive actions and use color scheme error for the delete button.
