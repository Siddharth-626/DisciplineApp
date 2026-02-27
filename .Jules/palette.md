## 2025-05-22 - [Accessibility & Safety Improvements]
**Learning:** Icon-only buttons without tooltips are a significant accessibility barrier and can lead to user confusion. Destructive actions like deletion should always have a confirmation step to prevent accidental data loss. Color pickers using empty placeholders are inaccessible; descriptive labels and tooltips are required.
**Action:** Always provide `tooltip` to `IconButton` and `FloatingActionButton`. Implement `showDialog` for deletions. Use meaningful `label` and `tooltip` for `ChoiceChip` selection.
