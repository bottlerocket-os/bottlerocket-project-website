---
title: "1.14.2"
type: "docs"
description: "Package Versions in Bottlerocket Release 1.14.2"
packages:
  - package: readline
    version: 8.2
    patches:
      - "readline-8.2-shlib.patch"
  - package: aws-signing-helper
    version: 1.0.4
  - package: libsepol
    version: 3.5
  - package: kubernetes-1.26
    version: 1.26.6
  - package: tcpdump
    version: 4.99.4
  - package: containerd
    version: 1.6.20
  - package: iptables
    version: 1.8.9
    patches:
      - "1001-extensions-NAT-Fix-for-Werror-format-security.patch"
      - "1002-ip6tables-Fix-checking-existence-of-rule.patch"
  - package: kernel-5.15
    version: 5.15.117
    patches:
      - "1001-Makefile-add-prepare-target-for-external-modules.patch"
      - "1002-Revert-kbuild-hide-tools-build-targets-from-external.patch"
      - "1004-af_unix-increase-default-max_dgram_qlen-to-512.patch"
      - "1003-initramfs-unlink-INITRAMFS_FORCE-from-CMDLINE_-EXTEN.patch"
  - package: libpcap
    version: 1.10.1
  - package: libnftnl
    version: 1.2.5
  - package: libffi
    version: 3.4.4
  - package: libncurses
    version: 6.2
    patches:
      - "ncurses-config.patch"
      - "ncurses-urxvt.patch"
      - "ncurses-kbs.patch"
      - "ncurses-libs.patch"
  - package: bash
    version: 5.1.16
    patches:
      - "bash-5.0-patch-1.patch"
      - "bash-4.4-no-loadable-builtins.patch"
      - "bash-5.0-patch-2.patch"
  - package: nvidia-container-toolkit
    version: 1.13.1
  - package: libsemanage
    version: 3.5
  - package: libexpat
    version: 2.5.0
  - package: libbzip2
    version: 1.0.8
    patches:
      - "0001-simplify-shared-object-build.patch"
  - package: cni
    version: 1.1.2
  - package: docker-cli
    version: 20.10.21
  - package: runc
    version: 1.1.6
  - package: ecr-credential-provider-1.27
    version: 1.27.1
  - package: liblzma
    version: 5.4.2
  - package: docker-proxy
    version: 20.10.18
  - package: chrony
    version: 4.3
  - package: filesystem
    version: 1.0
  - package: libnetfilter_cttimeout
    version: 1.0.1
  - package: policycoreutils
    version: 3.5
  - package: libcap
    version: 2.68
    patches:
      - "9001-dont-test-during-install.patch"
  - package: wicked
    version: 0.6.68
    patches:
      - "1002-exclude-unused-components.patch"
      - "0001-dhcp6-refresh-ipv6-flags-on-staring-in-auto-mode.patch"
      - "1005-client-validate-ethernet-namespace-node.patch"
      - "1003-ship-mkconst-and-schema-sources-for-runtime-use.patch"
      - "1006-server-discover-hardware-address-of-unconfigured-int.patch"
      - "1001-avoid-gcrypt-dependency.patch"
      - "1007-dhpc6-don-t-cancel-transmission-if-random-delay-happ.patch"
      - "1008-dhcp6-reduce-maximum-initial-solicitation-delay-to-1.patch"
      - "1004-adjust-safeguard-for-dhcp6-defer-timeout.patch"
  - package: aws-iam-authenticator
    version: 0.6.8
  - package: acpid
    version: 2.0.34
    patches:
      - "0001-Remove-shell-dependency-by-only-shutting-down.patch"
  - package: log4j2-hotpatch
    version: 1.3.0
  - package: findutils
    version: 4.9.0
  - package: libdbus
    version: 1.15.4
  - package: oci-add-hooks
    version: 1.0.0
  - package: libgcc
    version: 0.0
  - package: os
    version: 0.0
  - package: kubernetes-1.22
    version: 1.22.17
  - package: libnetfilter_cthelper
    version: 1.0.1
  - package: kmod
    version: 30
  - package: kubernetes-1.23
    version: 1.23.17
  - package: keyutils
    version: 1.6.1
  - package: ca-certificates
    version: 2023.01.10
  - package: selinux-policy
    version: 0.0
  - package: binutils
    version: 2.38
  - package: nvidia-k8s-device-plugin
    version: 0.14.0
  - package: libnetfilter_queue
    version: 1.0.5
  - package: makedumpfile
    version: 1.7.3
    patches:
      - "0000-fix-strip-invocation-for-TARGET-env-variable.patch"
  - package: libiw
    version: 29
    patches:
      - "wireless-tools-29-makefile.patch"
  - package: libselinux
    version: 3.5
  - package: ethtool
    version: 6.2
  - package: util-linux
    version: 2.38.1
  - package: libnvidia-container
    version: 1.13.1
    patches:
      - "0001-use-shared-libtirpc.patch"
      - "0003-keep-debug-symbols.patch"
      - "0004-Use-NVIDIA_PATH-to-look-up-binaries.patch"
      - "0005-makefile-avoid-ldconfig-when-cross-compiling.patch"
      - "0002-use-prefix-from-environment.patch"
  - package: libglib
    version: 2.76.0
  - package: docker-engine
    version: 20.10.21
  - package: dbus-broker
    version: 33
    patches:
      - "0001-c-utf8-disable-strict-aliasing-optimizations.patch"
  - package: ecs-gpu-init
    version: 0.0
  - package: microcode
    version: 0.0
  - package: ecs-agent
    version: 1.70.2
    patches:
      - "0002-bottlerocket-remove-unsupported-capabilities.patch"
      - "1001-bottlerocket-default-filesystem-locations.patch"
      - "0005-bottlerocket-fix-procfs-path-on-host.patch"
      - "0006-execcmd-change-execcmd-directories-for-Bottlerocket.patch"
      - "0003-bottlerocket-bind-introspection-to-localhost.patch"
      - "0004-bottlerocket-remove-unsupported-CNI-plugins.patch"
      - "0001-bottlerocket-default-filesystem-locations.patch"
  - package: libtirpc
    version: 1.3.3
  - package: iproute
    version: 6.2.0
    patches:
      - "0001-skip-libelf-check.patch"
  - package: kubernetes-1.25
    version: 1.25.11
  - package: libnl
    version: 3.7.0
  - package: kernel-5.10
    version: 5.10.184
    patches:
      - "1003-af_unix-increase-default-max_dgram_qlen-to-512.patch"
      - "2001-kbuild-add-support-for-zstd-compressed-modules.patch"
      - "1001-Makefile-add-prepare-target-for-external-modules.patch"
      - "1002-initramfs-unlink-INITRAMFS_FORCE-from-CMDLINE_-EXTEN.patch"
      - "2000-kbuild-move-module-strip-compression-code-into-scrip.patch"
  - package: hotdog
    version: 1.0.6
  - package: libxcrypt
    version: 4.4.33
  - package: libzstd
    version: 1.5.5
  - package: docker-init
    version: 19.03.15
  - package: host-ctr
    version: 0.0
  - package: grep
    version: 3.9
  - package: procps
    version: 3.3.17
  - package: libmnl
    version: 1.0.5
  - package: kubernetes-1.27
    version: 1.27.3
  - package: libnetfilter_conntrack
    version: 1.0.9
  - package: strace
    version: 6.2
  - package: libaudit
    version: 3.1
  - package: iputils
    version: 20221126
  - package: libelf
    version: 0.189
  - package: libattr
    version: 2.5.1
  - package: systemd
    version: 250.11
    patches:
      - "9010-sysusers-set-root-shell-to-sbin-nologin.patch"
      - "9007-journal-disable-keyed-hashes-for-compatibility.patch"
      - "9009-sysctl-do-not-set-rp_filter-via-wildcard.patch"
      - "0003-udev-introduce-device_broadcast-helper-function.patch"
      - "0004-udev-assume-there-is-no-blocker-when-failed-to-check.patch"
      - "9002-core-add-separate-timeout-for-system-shutdown.patch"
      - "0010-udev-fix-inversed-inequality-for-timeout-of-retrying.patch"
      - "9006-mount-setup-mount-etc-with-specific-label.patch"
      - "9001-use-absolute-path-for-var-run-symlink.patch"
      - "9012-tmpfiles-Split-networkd-entries-into-a-separate-file.patch"
      - "9011-units-keep-modprobe-service-units-running.patch"
      - "9003-machine-id-setup-generate-stable-ID-under-Xen-and-VM.patch"
      - "0009-udev-assume-block-device-is-not-locked-when-a-new-ev.patch"
      - "0008-udev-split-worker_lock_block_device-into-two.patch"
      - "0007-udev-only-ignore-ENOENT-or-friends-which-suggest-the.patch"
      - "9004-units-mount-tmp-with-noexec.patch"
      - "0006-udev-requeue-event-when-the-corresponding-block-devi.patch"
      - "9008-pkg-config-stop-hardcoding-prefix-to-usr.patch"
      - "0012-udev-try-to-reload-selinux-label-database-less-frequ.patch"
      - "0011-udev-certainly-restart-event-for-previously-locked-d.patch"
      - "0002-udev-drop-unnecessary-clone-of-received-sd-device-ob.patch"
      - "0001-errno-util-add-ERRNO_IS_DEVICE_ABSENT-macro.patch"
      - "0005-udev-store-action-in-struct-Event.patch"
      - "9005-mount-setup-apply-noexec-to-more-mounts.patch"
  - package: glibc
    version: 2.37
    patches:
      - "0003-Use-64-bit-time_t-interfaces-in-strftime-and-strptim.patch"
      - "HACK-only-build-and-install-localedef.patch"
      - "glibc-cs-path.patch"
      - "0008-elf-Restore-ldconfig-libc6-implicit-soname-logic-BZ-.patch"
      - "0002-LoongArch-Add-new-relocation-types.patch"
      - "0004-Account-for-grouping-in-printf-width-bug-30068.patch"
      - "0005-NEWS-Document-CVE-2023-25139.patch"
      - "9001-move-ldconfig-cache-to-ephemeral-storage.patch"
      - "0007-stdlib-Undo-post-review-change-to-16adc58e73f3-BZ-27.patch"
      - "0001-cdefs-Limit-definition-of-fortification-macros.patch"
      - "0006-elf-Smoke-test-ldconfig-p-against-system-etc-ld.so.c.patch"
  - package: login
    version: 0.0.1
  - package: kubernetes-1.24
    version: 1.24.15
  - package: pigz
    version: 2.7
  - package: amazon-ssm-agent
    version: 3.2.815.0
  - package: libz
    version: 1.2.13
  - package: e2fsprogs
    version: 1.47.0
  - package: libseccomp
    version: 2.5.4
  - package: grub
    version: 2.06
    patches:
      - "0017-gpt-add-search-by-disk-uuid-command.patch"
      - "0005-gpt-consolidate-crc32-computation-code.patch"
      - "0034-gpt-selectively-update-fields-during-repair.patch"
      - "0024-gptprio_test-check-GPT-is-repaired-when-appropriate.patch"
      - "0030-gpt-allow-repair-function-to-noop.patch"
      - "0010-gpt-split-out-checksum-recomputation.patch"
      - "0019-gpt-add-verbose-debug-logging.patch"
      - "0001-setup-Add-root-device-argument-to-grub-setup.patch"
      - "0026-gpt-prefer-disk-size-from-header-over-firmware.patch"
      - "0033-gpt-be-more-careful-about-relocating-backup-header.patch"
      - "0037-gpt-read-entries-table-at-the-same-time-as-the-heade.patch"
      - "0016-gpt-minor-cleanup.patch"
      - "0032-gpt-check-header-and-entries-status-bits-together.patch"
      - "0002-gpt-start-new-GPT-module.patch"
      - "0018-gpt-do-not-use-disk-sizes-GRUB-will-reject-as-invali.patch"
      - "0027-gpt-add-helper-for-picking-a-valid-header.patch"
      - "0022-gpt-properly-detect-and-repair-invalid-tables.patch"
      - "0014-gpt-add-search-by-partition-label-and-uuid-commands.patch"
      - "0028-gptrepair-fix-status-checking.patch"
      - "0008-gpt-add-a-new-generic-GUID-type.patch"
      - "0009-gpt-new-gptprio.next-command-for-selecting-priority-.patch"
      - "0020-gpt-improve-validation-of-GPT-headers.patch"
      - "0036-gpt-include-backup-in-sync-check-in-revalidation.patch"
      - "0031-gpt-do-not-use-an-enum-for-status-bit-values.patch"
      - "0040-gpt-write-backup-GPT-first-skip-if-inaccessible.patch"
      - "0004-gpt-record-size-of-of-the-entries-table.patch"
      - "0006-gpt-add-new-repair-function-to-sync-up-primary-and-b.patch"
      - "0041-gptprio-Use-Bottlerocket-boot-partition-type-GUID.patch"
      - "0038-gpt-report-all-revalidation-errors.patch"
      - "0023-gptrepair_test-fix-typo-in-cleanup-trap.patch"
      - "0012-gpt-switch-partition-names-to-a-16-bit-type.patch"
      - "0013-tests-add-some-partitions-to-the-gpt-unit-test-data.patch"
      - "0003-gpt-rename-misnamed-header-location-fields.patch"
      - "0025-gpt-fix-partition-table-indexing-and-validation.patch"
      - "0039-gpt-rename-and-update-documentation-for-grub_gpt_upd.patch"
      - "0021-gpt-refuse-to-write-to-sector-0.patch"
      - "0011-gpt-move-gpt-guid-printing-function-to-common-librar.patch"
      - "0035-gpt-always-revalidate-when-recomputing-checksums.patch"
      - "0007-gpt-add-write-function-and-gptrepair-command.patch"
      - "0029-gpt-use-inline-functions-for-checking-status-bits.patch"
      - "0015-gpt-clean-up-little-endian-crc32-computation.patch"
  - package: libpcre
    version: 10.42
  - package: libstd-rust
    version: 0.0
  - package: cni-plugins
    version: 1.2.0
  - package: coreutils
    version: 9.3
  - package: libacl
    version: 2.3.1
  - package: open-vm-tools
    version: 12.2.0
    patches:
      - "0001-no_cflags_werror.patch"
      - "0002-dont-force-cppflags.patch"
  - package: libnfnetlink
    version: 1.0.2
  - package: conntrack-tools
    version: 1.4.7
    patches:
      - "0001-disable-RPC-helper.patch"
  - package: ecr-credential-provider
    version: 1.25.3
  - package: release
    version: 0.0
  - package: kexec-tools
    version: 2.0.26
---

{{< packages-table >}}
