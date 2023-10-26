# Bottlerocket.dev Shortcodes

This site makes extensive use of [Hugo shortcodes](https://gohugo.io/content-management/shortcodes/).
Shortcodes help keep _content_ away from _logic_.
Some shortcodes are broadly useful and can be intetegrated into a variety of pages, while others are highly specific and only make sense on particular pages.
The shortcodes can be found in the `/layouts/shortcodes` directory.

## Current Shortcodes

### `all-settings.html`

__Usage__: 
`{{< all-settings >}}`

__Purpose__:
Create a list of all the settings in a given version of Bottlerocket.
The version is extracted from the URL of the page.
This is a single-purpose shortcode is only really useful for the index of the settings reference.

### `bootstrap_containers_diagram.html`

__Usage__:
`{{< bootstrap_containers_diagram example=n >}}` (n is the example number)

__Purpose__:
Show one of three diagrams on how bootstrap containers work.
This is a single-purpose shortcode for `/os/<ver>/concepts/bootstrap-containers/`

### `center-button.html`

__Usage__:
`{{< center-button link="<page>" label="<text>" lang="<lang code>" >}}`

__Purpose__:
Show a centered button in the homepage template.
This is only useful for pages using the homepage template, but is specifically designed for future language redirection.

### `components_diagram.html`

__Usage__:

```{{< components_diagram <many, many arguments> >}}```

__Purpose__:
This is a wrapper around the SVG diagrams on `/os/<ver>/concepts/components/` page.
It allows you to change the labels of the components or enable/disable boxes.
It has a very specific use-case, but it is used on multiple pages.

