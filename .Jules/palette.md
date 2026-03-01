## 2025-05-15 - [Destructive Action Confirmation]
**Learning:** In mobile-first tracking applications, destructive actions like task deletion should always be guarded by a confirmation dialog to prevent accidental data loss from "fat-finger" errors.
**Action:** Implement `showDialog` confirmation for all delete operations and ensure critical icon-only buttons have descriptive tooltips for accessibility.
