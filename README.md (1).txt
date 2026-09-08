# Visual Studio Code 1.136

## Release Date

September 2, 2026

**Update 1.136.1:** The update addresses issues fixed in this release.

---

Welcome to the 1.136 release of Visual Studio Code. This release helps you finish pull requests with agents and manage agent work across complex workspaces and related chats.

### Highlights

* **Agent Merge (Preview):** Resolve review feedback, failed checks, and merge conflicts until your pull request is ready to merge.
* **Multi-root workspaces (Experimental):** Work with Copilot and Claude agent sessions across all folders in a multi-root workspace.
* **Chat backgrounds (Experimental):** Personalize the Agents window with built-in patterns or your own images.
* **Chat sessions:** Organize related chats in a session hierarchy and quickly see which ones need your attention.

Happy Coding!

VS Code is rolling out gradually to all users. Use **Check for Updates** in VS Code to get the latest version immediately.

To try new features as soon as possible, use the nightly Insiders build, which includes the latest updates as soon as they are available.

---

## In This Update

* The Story of VS Code: World Premiere
* Agents
* Chat
* Accessibility
* Editor Experience
* Code Editing
* Integrated Browser
* Terminal
* Deprecated Features and Settings
* Thank You

---

## The Story of VS Code: World Premiere

Discover the story behind VS Code, from its early beginnings to the platform millions of developers use today, and the community that helped shape it.

**Premiere: September 4 at 8:00 AM PT. Join us!**

---

# Agents

## Multi-root Workspaces in Editor Window — Experimental

**Settings:**

`chat.agentHost.copilotAgent.multiRootEnabled`

`chat.agentHost.claudeAgent.multiRootEnabled`

Copilot and Claude agent sessions in the editor window Chat view support multi-root workspaces.

This capability is currently scoped to the editor window.

Agent hooks remain scoped to a single workspace folder. If hooks are detected in multiple folders, VS Code prompts you to select the primary folder from which to load them.

---

## Redesigned New-Session Input

Start delegated work with less setup in the redesigned new-session input.

The updated experience brings the prompt, model selection, workspace selection, and other session controls together in one layout.

---

## Improved Workspace Resolution

Agents can resolve workspaces by their project name in addition to absolute paths and workspace URIs.

Session tools also preserve project URIs and all working directories for multi-root workspaces.

As a result, you can make requests such as:

**"Run this in the VS Code workspace."**

without providing a full path.

If multiple workspaces have the same name, the agent reports the possible matches instead of silently choosing one.

Remote workspace URIs are supported as well.

---

## Navigate Related Chats and Sessions

Keep related agent work organized and move between sessions and chats from the sessions list in the Agents window.

Chats appear as children of their parent session, so you can understand which chats belong together without managing a collection of unrelated sessions.

Each chat row shows its own title, status, and pending approvals, so you can see which chat needs your input.

You can expand or collapse the hierarchy and open, rename, move, or delete individual chats directly from the tree.

When an agent delegates independent work to multiple chats, each created chat gets a meaningful title and appears in this hierarchy.

The new session or chat is placed close to its source, and the receiving request includes a source indication such as:

* **Sent by another session**
* **Sent from another chat**

Select the source indication to return to the exact session or chat that initiated it.

---

## Readable Breadcrumbs for Session Files

Files created in the internal session state directory previously showed internal session identifiers in editor breadcrumbs.

Breadcrumbs now use stable provider and session labels, making it easier to identify the file location without exposing implementation details.

---

## Chat Backgrounds in the Agents Window — Experimental

**Settings:**

`chat.agentSessions.preferredDarkBackgroundImage`

`chat.agentSessions.preferredLightBackgroundImage`

`chat.agentSessions.backgroundImageLayout`

Personalize the Agents window with a decorative chat background.

You can choose either a theme-aware pattern of built-in VS Code icons or an image from your machine.

Run:

**Chat: Set Background...**

to choose between the Codicons pattern and an image from your machine.

The five images you used most recently are offered under **Recently Used**, and that list is kept on this machine only.

When you bring your own image, run:

**Chat: Change Background Layout...**

Eleven layouts are available:

* Repeat
* Stretch
* Center
* Edge layouts
* Corner layouts

Dark and light themes keep separate backgrounds.

Every dark theme shares:

`chat.agentSessions.preferredDarkBackgroundImage`

Every light theme shares:

`chat.agentSessions.preferredLightBackgroundImage`

Switching between a dark and a light theme swaps the background along with it.

High contrast themes suppress backgrounds entirely, and the background commands are unavailable there.

Chat content carries its own fill so that it stays readable over whatever sits behind it.

Your request remains fully opaque, agent responses fade out through the padding on either side, and wide content such as Markdown tables and terminal output stays fully backed.

---

## Agent Session Notifications

**Settings:**

`chat.notifyWindowOnConfirmation`

`chat.notifyWindowOnResponseReceived`

VS Code can notify you when an agent session needs your input or finishes its work.

This is especially useful when you delegate work across multiple sessions, workspaces, or VS Code windows.

By default, notifications only appear when the VS Code window is not focused.

You can configure notifications separately for sessions that need input and sessions that have received a response.

Notifications include a direct link back to the relevant session, so selecting one focuses the correct window and opens the session that needs attention.

---

## Agent Merge — Preview

**Setting:**

`chat.agentMerge.enabled`

Agent Merge helps you take a pull request across the finish line.

It asks an agent to:

* Address review feedback
* Fix failed checks
* Resolve merge conflicts
* Rerun workflows

Agent Merge repeats this process until the pull request is ready to merge.

To try Agent Merge, enable:

`chat.agentMerge.enabled`

You can currently enable Agent Merge for a session only from the Agents window.

Run:

**Enable Agent Merge for Active Session**

or select the **Agent Merge** button in the title bar.

---

## Agent Host

The Agent Host lets you connect to the same agent session from multiple VS Code windows.

It runs agent harnesses in a dedicated process based on the Agent Host Protocol (AHP).

The Agent Host's Copilot agent is powered by the Copilot SDK, which aligns the agent's behavior and functionality with the Copilot CLI, the standalone GitHub Copilot app, and other Copilot products.

The Agent Host is actively being developed.

The following screenshot shows the Copilot harness selected for an agent host in an editor window.

---

# Chat

## Enterprise Controls for Dictation Data

Administrators can manage the dictation model and language-model transcript cleanup through enterprise policies.

The new controls make it possible to require on-device transcription and disable language-model cleanup.

This allows dictation to remain available while preventing dictation data from being sent to cloud transcription or a Copilot model.

---

# Accessibility

## Screen Reader Optimized Badge in the Agents Window

The **Screen Reader Optimized** badge in the Agents window title bar makes the active accessibility mode easier to identify.

The badge appears when Screen Reader Optimized mode is enabled.

Select the badge to disable this mode.

---

# Editor Experience

## Layout Density for the Editor Window — Experimental

**Settings:**

`workbench.experimental.modernUI`

`window.density.layout`

Fit more content in the editor window with the **Compact** layout density.

When `workbench.experimental.modernUI` is enabled, you can choose between two layout densities:

### Default

The same as the current editor window layout.

### Compact

Removes the spacing between panels and reduces inner panel spacing.

This setting is available in the **Layout Density** section of the Settings menu and can also be set using:

`window.density.layout`

---

# Code Editing

## Word Wrapping Improvements

Injected text no longer pushes wrapped lines outside the editor viewport.

Word wrapping takes the visual width of the following elements into account:

* Color decorators
* Inlay hint spacing
* Inline progress indicators
* Breakpoint placeholders

This improves the readability of wrapped lines and prevents text from being cropped at the edge of the editor viewport.

---

# Integrated Browser

## Spell Check Suggestions

Right-click a misspelled word in an editable field to select a suggested correction.

In sessions that use persistent data storage, you can also select:

**Add to Dictionary**

---

# Terminal

## Reduced Delay When Running Commands

Terminal commands executed by extensions no longer incur an unnecessary delay when shell integration is ready under certain timing conditions.

Users of the JavaScript debugger who experienced this issue will no longer experience a five-second delay when starting their programs.

---

# Deprecated Features and Settings

None.

---

# Thank You

We really appreciate everyone who contributes to the development and improvement of VS Code.

The VS Code community continues to help improve:

* Agents
* Chat
* Accessibility
* Editor experience
* Code editing
* Integrated browser
* Terminal
* Developer tools

We really appreciate people trying new features as soon as they are ready.

Check back regularly to learn what's new in future VS Code releases.
