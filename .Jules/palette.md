## 2025-05-14 - Confirmation for Destructive Actions
**Learning:** Destructive actions like task deletion should always have a confirmation dialog to prevent accidental data loss. This is a fundamental UX pattern that improves user confidence.
**Action:** Always implement a confirmation dialog for delete operations, and ensure `context.mounted` is checked if the action is triggered after an `await` (like waiting for the dialog result).
