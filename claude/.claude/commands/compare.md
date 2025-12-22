---
description: Compare two web pages with visual screenshots and analysis. Supports readability-focused, general, or comprehensive (all) comparison types.
---

# Page Comparison Tool

Compare two web pages by visiting them, capturing screenshots of specified sections, and generating a detailed HTML comparison report.

## Usage

You should call this command with parameters. The user will provide them in this format:

```
/compare --url1 <first-url> --url2 <second-url> --section "<section-name>" --type <readability|general|all>
```

## Parameters

When the user invokes this command, extract these parameters from their message:

- **url1** (required): First URL to compare
- **url2** (required): Second URL to compare
- **section** (optional): Specific section to scroll to and compare. If not provided, compare the full page as initially loaded.
- **type** (required): Type of comparison to perform
  - `readability` - Focus on typography, spacing, hierarchy, accessibility (best for documentation)
  - `general` - Focus on visual differences, content changes, layout, functionality (best for any pages)
  - `all` - Perform both readability AND general analysis in a comprehensive report

## Execution Steps

Follow these steps to complete the comparison:

### 1. Setup

- Create output directory: `~/cl-ai/page-comparisons/` if it doesn't exist
- Generate timestamp for unique filenames: `YYYY-MM-DD-HHMMSS`
- Launch Chrome with Automaton profile by running: `bash ~/.claude/launch-chrome-automaton.sh` or the local project script at `.claude/launch-chrome-automaton.sh`

### 1.1 Move window to workspace

- Move window to workspace P by running: `bash ~/.claude/move-to-workspace-p.sh`

### 2. Capture Screenshots

Use the browser-automation skill:

a. Visit first URL:

- `browser navigate <url1>`
- If section specified: `browser act "scroll to the <section> section"`
- Take screenshot and verify it worked

b. Visit second URL:

- `browser navigate <url2>`
- If section specified: `browser act "scroll to the <section> section"`
- Take screenshot and verify it worked

c. Close browser:

- `browser close`

d. Copy screenshots to output directory with descriptive names

### 3. Analyze Screenshots

**Before analysis**: Read and apply UX best practices from `~/cl-ai/.claude/ux-best-practices.md`

Read both screenshots using the Read tool and perform analysis based on --type parameter:

#### If type = "readability":

Analyze and compare:

- **Typography**: Font families, sizes, weights, line heights
- **Visual Hierarchy**: Heading structure, section prominence, emphasis
- **Spacing & Layout**: Whitespace, margins, padding, breathing room
- **Content Scannability**: Bullet formatting, list structure, paragraph breaks
- **Link Affordance**: Link visibility, color, underlines, hover states
- **Color Contrast**: Text/background contrast, accessibility compliance
- **Accessibility**: ARIA landmarks, semantic HTML, keyboard navigation
- **Documentation Best Practices**: Structure, navigation, search, organization

#### If type = "general":

Analyze and compare:

- **Visual Design**: Colors, imagery, branding, overall aesthetic
- **Layout Structure**: Grid system, component placement, responsive design
- **Content Differences**: What text/content changed, added, or removed
- **Interactive Elements**: Buttons, forms, CTAs, navigation differences
- **Functional Changes**: What works differently, new features, removed features
- **User Experience**: Flow, interactions, feedback mechanisms
- **Performance Indicators**: Page load appearance, rendering differences

#### If type = "all":

Perform BOTH readability AND general analysis. Create a comprehensive report with two main sections:

1. Readability Analysis (all metrics from readability type)
2. General Comparison (all metrics from general type)
3. Combined Executive Summary highlighting the most important findings from both

### 4. Generate HTML Report

Create an HTML file named: `page-comparison-<type>-<timestamp>.html`

The report should include:

**For all types:**

- Side-by-side embedded screenshots
- Metadata (URLs, date, section, comparison type)
- Clear section headings
- Professional styling (similar to previous comparison report)

**For readability type:**

- Readability metrics table
- Typography comparison
- Accessibility assessment
- Key findings focused on readability
- Recommendations for improving readability

**For general type:**

- Visual differences overview
- Content changes summary
- Functional differences
- Layout comparison
- Key findings focused on general differences

**For all type:**

- Combined executive summary
- Readability section (full analysis)
- General comparison section (full analysis)
- Integrated recommendations addressing both aspects
- Comprehensive metrics table

### 5. Output Results

Tell the user:

- Location of the HTML report
- Location of the screenshots
- Brief summary of key findings (3-5 bullet points)
- Offer to open the report in Chrome

## Example Invocations

```bash
# Readability-focused comparison of documentation
/compare --url1 https://docs.coveo.com/en/123 --url2 https://docsstaging.coveo.com/en/123 --section "Getting Started" --type readability

# General comparison of marketing pages
/compare --url1 https://coveo.com/products --url2 https://coveo-redesign.com/products --type general

# Comprehensive comparison with both analyses
/compare --url1 https://docs.site.com/guide --url2 https://staging.site.com/guide --section "Overview" --type all

# Full page comparison without specific section
/compare --url1 https://example.com --url2 https://example.org --type general
```

## Error Handling

- If browser-automation skill fails, inform user and suggest checking setup
- If section cannot be found, capture current view and note in report
- If screenshots are missing, stop and report the issue
- If parameters are missing, ask user for clarification

## Notes

- Always use the browser-automation skill (don't use bash `browser` commands directly)
- Browser automation uses the "Automaton" Chrome profile for consistent session state
- Always move Automaton chrome window to "P" aerospace workspace
- Always verify screenshots after capture by reading them with the Read tool
- Be specific when scrolling to sections - include section name in natural language
- Generate unique filenames to avoid overwriting previous comparisons
- Create professional, well-structured HTML reports with embedded images
- For "all" type, ensure the report is well-organized despite being comprehensive
