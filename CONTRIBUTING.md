
# Contributing

## Workflow Overview
1. Branch from stable to work on an issue branch.
2. Raise a pull request to merge the issue branch into stable when complete
3. Stable is later merged into master for "official" release.

### Branching from Stable

### Pull Request to Stable

### Pull Request to Master

## General Considerations

## Issue Tracking

## UI Changes
Whenever new UI features are added, this section should be referenced to ensure the contribution complies with the following standards.

### Accessibility
- All pages must facilitate keyboard-only navigation.
	- Pressing the tab key on any web page must result in a logical navigation flow, generally from top-to-bottom and left-to-right on the page.
	- The most important or frequently used features should be prioritized in the order of elements navigated via tabbing.
	- All modal windows should allow the user to exit the modal with the first tab.
- All links must be underlined, and links are the only form of text that should be underlined.

### Globalization
- All text displayed within the UI must be internationalized with i18n.
- Any features dealing with dates or times must support and include tests to accommodate multiple time zones.

## Styleguides

### Issues
Whenever applicable, use the following user story template:
As a *ROLE* I want *GOAL/FEATURE* so I can *BENEFIT*.

Consider placing an applicable emoji before the issue ID to give a general categorization of the task being performed:
* :pushpin: `:pushpin:` for administrative tasks.
* :gift: `:gift:` for new features.
* :white_check_mark: `:heavy_check_mark:` for adding tests.
* :memo: `:memo:` for documentation tasks.
* :bug: `:bug:` for bug fixes.
* :lock: `:lock:` for security considerations.
* :wheelchair: `:wheelchair:` for accessibility considerations.
* :earth_americas: `:earth_americas:` for globalization considerations.
* :shower: `:shower:` for code cleanup.
* :art: `:art:` for UI touch-ups.
* :iphone: `:iphone:` for mobile UI considerations.
* :racehorse: `:racehorse:` for performance improvements.
* :fire: `:fire:` for tasks primarily involving the removal of obsolete code or files.
* :arrow_up: `:arrow_up:` for dependency upgrades.
* :arrow_down: `:arrow_down:` for dependency downgrades.

Any issues that are blocked should have :no_entry: `:no_entry:` displayed after the issue ID.

### Commit Messages
* Use the present tense ("Add feature" not "Added feature").
* Use the imperative mood ("Add feature" not "Adds feature").
* Do not add a period at the end of the commit message.

### Rspec
- Use `describe` to express a noun.
- Use `context` to express a situation.
- Use `it` to express expected states or actions.
- Each assertion should be contained within an `it` block.
- Each `it` block is limited to one assertion.

#### Example
```ruby
describe 'a dog' do
  it 'barks' do
    # assertion here
  end
  context 'when the dog is happy' do
    it 'wags its tail' do
      # assertion here
    end
  end
end
```
