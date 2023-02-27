# Directory Structure

When you add files to a website the most challenging part is often "Where does this thing go?"
This document aims to provide the high-level structure to both the markdown files and the resulting URLs after website build.

The index and the "about" documents are intended to be world-facing and unlocalized.
The documentation is localizeable and is placed in directory per language to facilitate translations.

Bottlerocket's documentation is placed in the `os` directory with subdirectories for each version - allowing for alignment between releases and documentation.
Every directory or page in the versioned tree is intended to have clear meaning without much pre-existing Bottlerocket context (e.g. `introduction`, `install`, `update`, etc.).

Other user-facing repos (`control-container`, `brupop`, etc.) and components are in their own versioned trees with links provided to relevant versions of the OS as required.
This decouples versioning from the OS and allows for documentation of out-of-phase releases.

This may not be comprehensive for every file, but should be considered a living document and updated as needed for clarity.

```. index [homepage]
├── all [top level documents that do not get localized]
│   ├── about [top level documents about the OS]
│   ├── charter.markdown
│   ├── code-of-conduct.markdown
│   ├── security.markdown
│   ├── trademark.markdown
│   └── [... more non-localized content]
├── en [localized content, each language get a directory named by ISO-639-1]
│   ├── faqitems [Bottlerocket's Frequently Asked Questions (headless, see faq.markdown)]
│   │   ├── general-01-what-is-bottlerocket.markdown
│   │   ├── release-02-why-was-bottlerocket-created.markdown
│   │   └── [... more FAQs]
│   ├── faq.markdown [Single page rendering for faqitems bundle]
│   ├── os [Bottlerocket's documentation]
│   │   ├── 1.12.x [versioned content, each new minor version gets a new directrory]
│   │   │   ├── introduction.markdown
│   │   │   ├── install [how to put Bottlerocket on a node]
│   │   │   │   ├── manual [install instructions without high level tools]
│   │   │   │   │   ├── aws [each platform gets an directory]
│   │   │   │   │   │   ├── k8s.markdown [each orchestrator gets a page]
│   │   │   │   │   │   └── [... more orchestrators]
│   │   │   │   │   └── [... more platforms]
│   │   │   │   └── quickstart [install instructions with high level tools]
│   │   │   │       ├── aws [each platform gets an directory]
│   │   │   │       │   ├── k8s.markdown [each orchestrator gets a page, tools are headings on page]
│   │   │   │       │   └── [... more orchestrators]
│   │   │   │       └── [... more platforms]
│   │   │   ├── update [how to move to newer versions]
│   │   │   │   ├── methods.markdown [methods and instructions to update]
│   │   │   │   ├── guidelines.markdown [guidelines and caveats around updating]
│   │   │   │   └── comparison.markdown [how each method is different]
│   │   │   ├── hardware [topics specific to underlying hardware]
│   │   │   │   ├── requirements.markdown
│   │   │   │   └── [... future hardware related pages] 
│   │   │   ├── concepts [topics that provide high-level explainations]
│   │   │   │   ├── image-based-updates.markdown
│   │   │   │   └── [... other conceptual pages]
│   │   │   ├── glossary.markdown [defintions]
│   │   │   ├── api [settings avaliable in the api defintions]
│   │   │   │   ├── endpoints [top-level API endpoints, from the OpenAPI spec]
│   │   │   │   │   ├── settings.markdown [the available methods at this endpoint]
│   │   │   │   │   └── [... more endpoints]
│   │   │   │   └── settings [all available settings]
│   │   │   │       ├── motd.markdown [description of what the motd setting does]
│   │   │   │       └── [... more settings]
│   │   │   ├── login
│   │   │   │   ├── control-container.markdown
│   │   │   │   ├── admin-container.markdown
│   │   │   │   └── regaining-access.markdown
│   │   └── [... more versions]
│   ├── control-container
│   │   ├── 0.7.x
│   │   │   └── [... more details]
│   │   └── [... more versions]
│   ├── admin-container
│   │   ├── 0.4.x
│   │   │   └── [... more details]
│   │   └── [... more versions]
│   ├── brupop
│   │   ├── 1.0.0
│   │   │   └── [... more details]
│   │   └── [... more versions]
│   ├── ecs-updater
│   │   ├── 0.2.x
│   │   │   └── [... more details]
│   │   └── [... more versions]
└── [... more languages]
```
