## 2025-05-15 - [Safety Confirmation Pattern]
**Learning:** Destructive actions like task deletion should always be preceded by a confirmation dialog to prevent accidental data loss. This pattern is consistent with standard UX best practices and reduces user frustration.
**Action:** Always implement a confirmation dialog for any irreversible data-modifying action. Use Flutter's showDialog with a context.mounted check afterwards to ensure widget state safety.
