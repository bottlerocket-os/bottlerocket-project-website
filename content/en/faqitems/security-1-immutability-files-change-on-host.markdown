+++
question = "I heard Bottlerocket is immutable. What does that really mean?"
group = "Security"
+++

There are both immutable and mutable areas on a Bottlerocket host.

`dm-verity` is used for Bottlerocket's root filesystem, meaning it is read-only.
More details about the immutable filesystem are available in the {{< ver-ref project="os" page="/concepts/restricted-filesystem/index.markdown#immutable-filesystem" >}}"Immutable Filesystem" section of the Restricted Filesystem documentation{{< /ver-ref >}}.

On the other hand, the non-root filesystem uses SELinux to protect files at a granular level.
There are rules and policies which determine the mutability of different areas of the non-root filesystem.
With sufficient privilege, a user can modify the SELinux labels of a file or resource.
More details about the mutability of the non-root filesystem are available in the {{< ver-ref project="os" page="/concepts/restricted-filesystem/index.markdown#mutable-filesystem" >}}"Mutable Filesystem" section of the Restricted Filesystem documentation{{< /ver-ref >}}.
