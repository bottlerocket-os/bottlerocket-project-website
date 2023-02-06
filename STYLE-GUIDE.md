# Bottlerocket website content style & writing guide (WIP)

The Bottlerocket content style largely follows the [OpenStack General Writing Guidelines](https://docs.openstack.org/doc-contrib-guide/writing-style/general-writing-guidelines.html).

Take the time to read through the OpenStack General Writing Guidelines and adapt these appropriately to the context of Bottlerocket as needed.
At a high level, these guidelines state that you should write in:

* [Active voice](https://owl.purdue.edu/owl/general_writing/academic_writing/active_and_passive_voice/active_versus_passive_voice.html)
* [Present tense](https://writing-rag.com/2872/the-present-tense-in-technical-writing/#:~:text=Here's%20the%20rule%3A,you%20do%20something%2C%20something%20happens.)
* [Second person](https://ddbeck.com/second-person-is-ok/)
* [Imperative mood](https://www.grammarbook.com/blog/verbs/imperative-mood/)

## Additions & differences

_Copyright and licensing_
Bottlerocket’s copyright and licensing information can be found in files with the prefix `LICENSE` in the root of each repo.

_Collective Pronouns_
The OpenStack General Writing Guidelines take a “judicious” approach to the use of the first person plural pronouns of _we_ and _our_.
Counter to the instruction in that writing guide, **“we”/“our” should not be used as a stand-in when writing for Bottlerocket, contributors, nor a particular team**.
In the context of Bottlerocket, use only “we”/“our” for collective works with two or more explicitly stated authors.
This change is needed to provide extra clarity to readers regarding decision making given the current structure of Bottlerocket.

_Inclusive Terms_
Avoid terms on Inclusive Naming’s [Tier 1,](https://inclusivenaming.org/word-lists/tier-1/) [Tier 2](https://inclusivenaming.org/word-lists/tier-2/), and [Tier 3](https://inclusivenaming.org/word-lists/tier-3/) lists.

## Document conventions

Consider the Markdown documents used as website content to be precursors to the final rendered website, not a final product on their own.
While Markdown does somewhat isolate the style from the content, the limited nature of the Markdown markup doesn’t allow for precise control without some impact on the structures.
All document conventions serve first the desired rendered output over any other demands.

Additional conventions:

1. Use [CommonMark](https://commonmark.org/) spec markdown
2. One sentence-per line, ending with a carriage return.
3. Double carriage return for paragraph endings
4. Use real-numbering for lists
5. Backticked inline code should limited to 60 characters, otherwise use code blocks (triple backtick)
6. Images must include alt text, while [title text](https://dev.to/stephencweiss/markdown-image-titles-and-alt-text-5fi1) is optional.
7. Captions to images should be included as italics text immediately following the image markup.
