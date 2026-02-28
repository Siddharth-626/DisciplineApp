## 2025-05-14 - [A11y/UX in Flutter]
**Learning:** Accessibility in Flutter goes beyond ARIA labels. Icon-only buttons MUST have a 'tooltip' property which serves as the accessibility label for screen readers. ChoiceChips with empty labels are inaccessible; providing text labels and tooltips significantly improves the experience for users with visual impairments.
**Action:** Always include tooltips for icon-only buttons and meaningful labels for selection widgets in Flutter.
