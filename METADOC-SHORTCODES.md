# Bottlerocket.dev Shortcodes

This site makes extensive use of [Hugo shortcodes](https://gohugo.io/content-management/shortcodes/).
Shortcodes help keep _content_ away from _logic_.
Some shortcodes are broadly useful and can be integrated into a variety of pages, while others are highly specific and only make sense on particular pages.
The shortcodes can be found in the `/layouts/shortcodes` directory.

## Current Shortcodes

### `all-settings.html`

__Usage__:
`{{< all-settings >}}`

__Purpose__:
Create a list of all the settings in a given version of Bottlerocket.
The version is extracted from the URL of the page.
This is a single-purpose shortcode and is only really useful for the index of the settings reference.

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

`{{< components_diagram <many, many arguments> >}}`

__Purpose__:
This is a wrapper around the SVG diagrams on `/os/<ver>/concepts/components/` page.
It allows you to change the labels of the components or enable/disable boxes.
It has a very specific use-case, but it is used on multiple pages.

### `faqlist.html`

__Usage__:

`{{< faqlist >}}`

__Purpose__:
To render the FAQ. It's only used on `/faq` but it will be useful for localization.

### `kernel-variant-info.html`

__Usage__:
`{{< kernel-variant-info >}}`

__Purpose__:
To render the kernel information about variants. Only used on `/version-information/variants`

### `latest-redirect.html`

__Usage__:
`{{< latest-redirect >}}`

__Purpose__:
To redirect hash links to the latest version. It's only used on `latest.markdown`.
This provides functionality to have evergreen links through a Javascript redirect.
So, for example: `https://bottlerocket.dev/en/os/latest/#/api/settings/container-runtime/` will always redirect to the latest version of the docs for container runtime.
The usage of this type of linking should be used judiciously as the redirect doesn't pass search engine traffic.

### `nav-bar-open.html`

__Usage__:
`{{< nav-bar-open html_id="m-enos-check" >}}`

__Purpose__:
This is used on the main documentation (`/en`) page to inject Javascript that "opens" the sidebar menu to the latest version based on a tag ID.
It could be useful on other pages, but it's likely only needed to direct the reader to the most recent page.

### `os-release-example.html`

__Usage__:
`{{< os-release-example orchestrator="k8s" build_id="6ef1139f" >}}`

__Purpose__:
This is used on the quickstart host container page as a way to keep the output mockup fresh per version.
It has no other use.

### `packages-by-variant.html`

__Usage__:
`{{< packages-by-variant  >}}`

__Purpose__:
This renders the grid of packages included in each variant on `/version-information/packages-by-variant/` only.
It has no other use.

### `packages-table.html`

__Usage__:
`{{< packages-table >}}`

__Purpose__:
This renders the table of packages included in a particular version.
It has no other use and the page that uses this shortcode is generated.

### `page-ver.html`

__Usage__:

`{{< page-ver >}}`

__Purpose__:
This injects information about the version docs being viewed into a scratch variable.
Independently, this has no rendered output but can be used to support other shortcodes.
Currently, it is only used with `kernel-variant-info` although it could be used with others.

### `setting-reference.html`

__Usage__:
`{{< setting-reference setting="" >}}{{</ setting-reference >}}`

__Purpose__:
This can be used to create a link to setting reference documentation.
For many settings, especially those with complicated names, creating a link to the reference is not straightforward.
This provides an easier way to render this, by supplying the rendered setting text in the `setting` argument.

### `settings.html`

__Usage__:
`{{< settings >}}`

__Purpose__:
This renders the entire setting reference and is used on every setting reference category (e.g. `/api/settings/*`)
The parameters are derived from the called page, no other arguments are needed.

### `stackedfigure.html`

__Usage__:

```html
{{< stackedfigure  alt="" src="" caption="" >}} 
...sometimes other stuff..
{{</ stackedfigure>}}
```

__Purpose__:
This shortcode provides a common way to have a chart/diagram with a `caption` below it.
If supplied `src` and `alt` it will render add an image tag. If not it will use the "other stuff" between the opening and closing template tag.

### `subsections-list.html`

__Usage__:
`{{< subsections-list >}}`

__Purpose__:
Renders a list of the subsections in a given section.
It is used only at the root of a section (e.g. `os`) to generate a reverse chronological list of versions.

### `twocol.html` & `twocol_inner.html`

__Usage__:

```html
{{< twocol containerclass="" rowclass="">}}
    {{< twocol_inner colsplit="" >}}.. stuff ..{{</ twocol_inner >}}
    {{< twocol_inner colsplit="" >}}.. stuff ..{{</ twocol_inner >}}
{{< /twocol >}}
```

__Purpose__:
Create a side-by-side chat with details.
Each `twocol_inner` containes the content.

### `twocolfigure.html`

__Usage__:

```html
{{< twocolfigure colsplit="" alt="" caption="" >}}
    .. stuff ..
{{</ twocolfigure>}}
```

__Purpose__:
Every similar to `twocol`/`twocol_inner` shortcodes (actually an earlier version).
It creates a two column, responsive layout with one side being content via the caption.
This is only used on the homepage.

### `ver-ref.html`

__Usage:__:

```html
{{< ver-ref project="" page="" >}} ... {{< /ver-ref >}}
```

__Purpose__:
This creates links with proper the current version and language references without relying on relative links (avoiding relative links in Hugo is a best practice).
`project` is usually `os` (for Bottlerocket OS) and `page` is the is the path of the page of the _content_ (note that the path does not include the trailing slash or extension).
So, for example, to link to `/<lang>/os/<version>/concepts/variants/` the shortcode would be something like: `{{< ver-ref project="os" page="/concepts/variants" >}}Variants{{< /ver-ref >}}`, which will make a link to a path like `/en/os/1.16.x/concepts/variants/`.
