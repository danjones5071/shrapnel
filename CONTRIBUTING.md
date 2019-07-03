  
# Contributing
This document outlines the most important requirements, expectations, and conventions for any contributions to the Shrapnel project. Adherence to these guidelines is critical for upholding quality and consistency throughout the codebase.

## Workflow
### Brief Overview
1. Identify an issue from the backlog you would like to work on.
2. Create an issue branch from master to perform your work.
3. Update the requirements/acceptance and testing criteria as needed.
4. Raise a pull request to merge your issue branch into master.
5. Master is later merged into the release branch for "official" release.

### Selecting an Issue
Until the Shrapnel project is deemed to be in a usable state, GitHub's built-in issue tracking system will be used. In the Shrapnel repository, click on the "Issues" tab to navigate to the list of currently open issues. Select any of these issues to view more details about the acceptance and testing criteria. If you decide to work on an issue, click on the gear icon next to the "Assignees" item for the issue and assign yourself.

### Branching from Master
If you have not done so already, clone the repository to your local machine by running the following in a terminal window:
```git clone https://github.com/danjones5071/shrapnel```

You may have noticed that each issue has a title beginning with `SHRPX-#`, which we call the "issue ID." This is done for the sake of traceability so every issue branch, pull request, and commit to master can be easily mapped to an issue in the backlog. You will use this issue ID as your branch name.

To create a new branch from master via a terminal, first run `git checkout master` to ensure you branch off of master. Then run `git checkout -b [SHRPX-#]` to create the new branch and switch to it locally, where `[SHRPX-#]` is replaced with your issue ID. 

To create a new branch from master via the GitHub interface, navigate to the [default page](https://github.com/danjones5071/shrapnel) of the repository. Above the message for the most recent commit, there is a pull-down menu specifying that the current branch is master. Click on this menu and enter the issue ID into the search field. Click on the option to "Create branch: [SHRPX-#]." If you already have a local clone of the repository on your system, running `git pull` will copy the newly created branch to your local repository, and you can switch to the new branch by running `git checkout [SHRPX-#]`.

At this point, you should move the issue's status from "Backlog" to "In Progress."

### Updating the Original Issue
As you work on your chosen issue, you may realize that requirements must be updated, an item should be removed from the acceptance criteria, or additional tests are needed to ensure adequate coverage. You are highly encouraged to update your issue's documentation as you work to reflect any of these findings. The requirements document can be found in [this](https://github.com/danjones5071/shrapnel-srs) repository.

### Raising a Pull Request to Master
Once your work is completed on your issue branch, the next step is to raise a pull request to have your contribution merged into the master branch so it can eventually be part of an official release.

Before raising your pull request, it is a good idea to merge the master branch into your issue branch to ensure it is up-to-date with any contributions to master since you first began working on the issue. Checkout the master branch and ensure it contains all the latest changes by running `git checkout master` and `git pull`. Navigate back to your issue branch by running `git checkout [SHRPX-#]` and merge the changes from master into it with `git merge master`.

Run all of the necessary tests to ensure no functionality has been changed after merging master into the issue branch. 

If all of these tests pass, it will be an indication that there are no conflicts between the master code and the code from your issue branch, so merging into master should be safe.

### Raising Pull Request to Release
**Pull requests to the release branch should only be raised by repository administrators.** Other contributors should only raise pull requests to the master or issue branches.

When the contents of the master branch are ready for official release, one of the repository administrators will raise a pull request to merge it into the release branch. This is done for a number of reasons. For quality and security purposes, additional tests can be run for the pull request before merging to release. This process also helps to provide a cleaner history of the changes for each release, and simplifies the task of reverting to previous versions if ever necessary.

## Issue Tracking
### Submitting a New Issue
### Minor Changes
In situations where only extremely minor fixes are needed such as correcting a typo in documentation, it may not be necessary to create an entirely new issue. Instead, a new branch can be created using the same issue ID listed in the commit that introduced the mistake. In the commit message and pull request, be sure to include the flag `[MINOR]` to clarify that the contribution contains only a minor fix for a previous issue. For example, if a typo is introduced to the README after the issue `SHRPX-123` is merged into master, the commit message for a minor fix might look like:

```SHRPX-123 [MINOR] Fix typo in README.md```

The following requirements should be met in order to submit a minor correction:
1. You are able to provide the issue ID of the commit from which the mistake originated.
2. The correction does not change more than one or two lines of code.
3. The correction does not introduce any change to functionality.

## UI Changes
Whenever new UI features are added or old ones are modified, this section should be referenced to ensure the contribution complies with the following standards.

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
As a *ROLE*, I want *GOAL/FEATURE* so I can *BENEFIT*.

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

### Linters

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
