---
title: "1.30.0"
type: "docs"
description: "Package Versions in Bottlerocket Release 1.30.0"
packages:
  - package: amazon-ecs-cni-plugins
    version: 2020.09.0
    patches:
      - "0001-bottlerocket-default-filesystem-locations.patch"
  - package: amazon-ssm-agent
    version: 3.3.1345.0
    patches:
      - "0001-agent-Add-config-to-make-shell-optional.patch"
  - package: amazon-vpc-cni-plugins
    version: 1.3
  - package: aws-iam-authenticator
    version: 0.6.28
  - package: aws-otel-collector
    version: 0.41.1
    patches:
      - "0001-change-logger-and-extraconfig-file-paths.patch"
  - package: aws-signing-helper
    version: 1.2.0
  - package: bash
    version: 5.2.37
    patches:
      - "bash-5.0-patch-1.patch"
      - "bash-4.4-no-loadable-builtins.patch"
      - "bash-5.0-patch-2.patch"
  - package: binutils
    version: 2.41
  - package: chrony
    version: 4.6.1
  - package: cni
    version: 1.2.3
  - package: cni-plugins
    version: 1.6.1
  - package: conntrack-tools
    version: 1.4.8
    patches:
      - "0001-disable-RPC-helper.patch"
  - package: containerd
    version: 1.7.24
  - package: coreutils
    version: 9.5
  - package: dbus-broker
    version: 36
    patches:
      - "0001-c-utf8-disable-strict-aliasing-optimizations.patch"
  - package: docker-cli
    version: 25.0.5
    patches:
      - "0001-non-tcp-host-header.patch"
  - package: docker-engine
    version: 25.0.6
    patches:
      - "0002-oci-inject-kmod-in-all-containers.patch"
      - "0001-Change-default-capabilities-using-daemon-config.patch"
  - package: docker-init
    version: 19.03.15
  - package: e2fsprogs
    version: 1.47.1
  - package: early-boot-config
    version: 0.1
  - package: ecr-credential-provider
    version: 1.25.16
  - package: ecr-credential-provider-1.27
    version: 1.27.10
  - package: ecr-credential-provider-1.29
    version: 1.29.7
  - package: ecr-credential-provider-1.30
    version: 1.30.6
  - package: ecr-credential-provider-1.31
    version: 1.31.4
  - package: ecr-credential-provider-1.32
    version: 1.32.0
  - package: ecs-agent
    version: 1.88.0
    patches:
      - "0005-bottlerocket-change-execcmd-directories-for-Bottlero.patch"
      - "0006-containermetadata-don-t-use-dataDirOnHost-for-metada.patch"
      - "0001-bottlerocket-default-filesystem-locations.patch"
      - "0002-bottlerocket-remove-unsupported-capabilities.patch"
      - "0004-bottlerocket-fix-procfs-path-on-host.patch"
      - "0003-bottlerocket-bind-introspection-to-localhost.patch"
  - package: ecs-gpu-init
    version: 0.0
  - package: ethtool
    version: 6.11
  - package: filesystem
    version: 1.0
  - package: findutils
    version: 4.10.0
  - package: glibc
    version: 2.40
    patches:
      - "0041-Fix-strtod-subnormal-rounding-bug-30220.patch"
      - "0020-x86-64-Remove-sysdeps-x86_64-x32-dl-machine.h.patch"
      - "0038-Add-tests-of-fread.patch"
      - "0055-nptl-initialize-rseq-area-prior-to-registration.patch"
      - "0054-elf-handle-addition-overflow-in-_dl_find_object_upda.patch"
      - "0021-x32-cet-Support-shadow-stack-during-startup-for-Linu.patch"
      - "0004-manual-Do-not-mention-STATIC_TLS-in-dynamic-linker-h.patch"
      - "0026-stdio-common-Add-test-for-vfscanf-with-matches-longe.patch"
      - "0045-powerpc64le-Build-new-strtod-tests-with-long-double-.patch"
      - "9001-move-ldconfig-cache-to-ephemeral-storage.patch"
      - "0005-Fix-version-number-in-NEWS-file.patch"
      - "0039-Test-errno-setting-on-strtod-overflow-in-tst-strtod-.patch"
      - "0032-elf-Clarify-and-invert-second-argument-of-_dl_alloca.patch"
      - "0052-Mitigation-for-clone-on-sparc-might-fail-with-EFAULT.patch"
      - "HACK-only-build-and-install-localedef.patch"
      - "0033-elf-Avoid-re-initializing-already-allocated-TLS-in-d.patch"
      - "0035-debug-Fix-read-error-handling-in-pcprofiledump.patch"
      - "0011-Enhanced-test-coverage-for-strncmp-wcsncmp.patch"
      - "0037-stdio-common-Add-new-test-for-fdopen.patch"
      - "0030-posix-Use-support-check.h-facilities-in-tst-truncate.patch"
      - "0017-Fix-name-space-violation-in-fortify-wrappers-bug-320.patch"
      - "glibc-cs-path.patch"
      - "0014-Add-mremap-tests.patch"
      - "0050-Make-tst-strtod-underflow-type-generic.patch"
      - "0019-support-Add-options-list-terminator-to-the-test-driv.patch"
      - "0018-manual-stdio-Further-clarify-putc-putwc-getc-and-get.patch"
      - "0051-elf-Change-ldconfig-auxcache-magic-number-bug-32231.patch"
      - "0043-Improve-NaN-payload-testing.patch"
      - "0003-resolv-Do-not-wait-for-non-existing-second-DNS-respo.patch"
      - "0009-manual-make-setrlimit-description-less-ambiguous.patch"
      - "0027-Make-tst-ungetc-use-libsupport.patch"
      - "0025-support-Add-FAIL-test-failure-helper.patch"
      - "0048-Add-tests-of-more-strtod-special-cases.patch"
      - "0057-malloc-add-indirection-for-malloc-like-functions-in-.patch"
      - "0016-x86-Tunables-may-incorrectly-set-Prefer_PMINUB_for_s.patch"
      - "0056-nptl-initialize-cpu_id_start-prior-to-rseq-registrat.patch"
      - "0008-manual-stdio-Clarify-putc-and-putwc.patch"
      - "0001-Replace-advisories-directory.patch"
      - "0024-string-strerror-strsignal-cannot-use-buffer-after-dl.patch"
      - "0010-Enhance-test-coverage-for-strnlen-wcsnlen.patch"
      - "0047-Add-more-tests-of-strtod-end-pointer.patch"
      - "0031-nptl-Use-support-check.h-facilities-in-tst-setuid3.patch"
      - "0036-libio-Attempt-wide-backup-free-only-for-non-legacy-c.patch"
      - "0049-libio-Set-_vtable_offset-before-calling-_IO_link_in-.patch"
      - "0028-ungetc-Fix-uninitialized-read-when-putting-into-unus.patch"
      - "0040-More-thoroughly-test-underflow-errno-in-tst-strtod-r.patch"
      - "0046-Make-tst-strtod2-and-tst-strtod5-type-generic.patch"
      - "0022-x86-Fix-bug-in-strchrnul-evex512-BZ-32078.patch"
      - "0053-linux-sparc-Fix-clone-for-LEON-sparcv8-BZ-31394.patch"
      - "0015-resolv-Fix-tst-resolv-short-response-for-older-GCC-b.patch"
      - "0007-malloc-add-multi-threaded-tests-for-aligned_alloc-ca.patch"
      - "0029-ungetc-Fix-backup-buffer-leak-on-program-exit-BZ-278.patch"
      - "0013-mremap-Update-manual-entry.patch"
      - "0012-linux-Update-the-mremap-C-implementation-BZ-31968.patch"
      - "0002-resolv-Allow-short-error-responses-to-match-any-quer.patch"
      - "0034-elf-Fix-tst-dlopen-tlsreinit1.out-test-dependency.patch"
      - "0044-Do-not-set-errno-for-overflowing-NaN-payload-in-strt.patch"
      - "0023-Define-__libc_initial-for-the-static-libc.patch"
      - "0006-malloc-avoid-global-locks-in-tst-aligned_alloc-lib.c.patch"
      - "0042-Make-__strtod_internal-tests-type-generic.patch"
  - package: grep
    version: 3.11
  - package: host-ctr
    version: 0.0
  - package: iproute
    version: 6.12.0
    patches:
      - "0001-skip-libelf-check.patch"
  - package: iptables
    version: 1.8.11
  - package: iputils
    version: 20240905
  - package: kexec-tools
    version: 2.0.29
  - package: keyutils
    version: 1.6.1
  - package: kmod
    version: 33
  - package: kubernetes-1.23
    version: 1.23.17
  - package: kubernetes-1.24
    version: 1.24.17
  - package: kubernetes-1.25
    version: 1.25.16
  - package: kubernetes-1.26
    version: 1.26.15
  - package: kubernetes-1.27
    version: 1.27.16
  - package: kubernetes-1.28
    version: 1.28.15
  - package: kubernetes-1.29
    version: 1.29.11
  - package: kubernetes-1.30
    version: 1.30.7
  - package: kubernetes-1.31
    version: 1.31.3
  - package: kubernetes-1.32
    version: 1.32.0
  - package: libacl
    version: 2.3.2
  - package: libattr
    version: 2.5.2
  - package: libaudit
    version: 4.0.2
  - package: libbpf
    version: 1.4.5
  - package: libcap
    version: 2.70
    patches:
      - "9001-dont-test-during-install.patch"
  - package: libdbus
    version: 1.15.12
  - package: libelf
    version: 0.192
  - package: libexpat
    version: 2.6.4
  - package: libffi
    version: 3.4.6
  - package: libgcc
    version: 0.0
  - package: libglib
    version: 2.83.0
    patches:
      - "0001-require-older-meson.patch"
  - package: libinih
    version: 58
  - package: libiw
    version: 29
    patches:
      - "wireless-tools-29-makefile.patch"
  - package: libjson-c
    version: 0.18
  - package: libmnl
    version: 1.0.5
  - package: libncurses
    version: 6.5
    patches:
      - "ncurses-config.patch"
      - "ncurses-libs.patch"
      - "ncurses-urxvt.patch"
  - package: libnetfilter_conntrack
    version: 1.1.0
  - package: libnetfilter_cthelper
    version: 1.0.1
  - package: libnetfilter_cttimeout
    version: 1.0.1
  - package: libnetfilter_queue
    version: 1.0.5
  - package: libnfnetlink
    version: 1.0.2
  - package: libnftnl
    version: 1.2.8
  - package: libnl
    version: 3.11.0
  - package: libnvidia-container
    version: 1.17.3
    patches:
      - "0004-Use-NVIDIA_PATH-to-look-up-binaries.patch"
      - "0002-use-prefix-from-environment.patch"
      - "0001-use-shared-libtirpc.patch"
      - "0003-keep-debug-symbols.patch"
      - "0005-makefile-avoid-ldconfig-when-cross-compiling.patch"
  - package: libnvme
    version: 1.11
  - package: libpcre
    version: 10.44
  - package: libseccomp
    version: 2.5.5
  - package: libselinux
    version: 3.7
  - package: libsemanage
    version: 3.7
    patches:
      - "0001-remove-bzip2-dependency.patch"
  - package: libsepol
    version: 3.7
  - package: libstd-rust
    version: 0.0
  - package: libtirpc
    version: 1.3.6
  - package: liburcu
    version: 0.14.1
  - package: libxcrypt
    version: 4.4.36
  - package: libz
    version: 1.3.1
  - package: libzstd
    version: 1.5.6
  - package: login
    version: 0.0.1
  - package: makedumpfile
    version: 1.7.5
    patches:
      - "0000-fix-strip-invocation-for-TARGET-env-variable.patch"
      - "0001-do-not-overlink-with-bzip2.patch"
  - package: mdadm
    version: 4.3
    patches:
      - "0001-report-monitor-output-to-syslog.patch"
  - package: netdog
    version: 0.1.1
  - package: nvidia-container-toolkit
    version: 1.17.3
  - package: nvidia-k8s-device-plugin
    version: 0.17.0
  - package: nvme-cli
    version: 2.11
    patches:
      - "0001-plugins-amzn-add-stats-support.patch"
  - package: oci-add-hooks
    version: 1.0.0
  - package: open-vm-tools
    version: 12.5.0
    patches:
      - "0002-dont-force-cppflags.patch"
      - "0003-Update-shutdown-code-to-work-for-Bottlerocket.patch"
      - "0001-no_cflags_werror.patch"
  - package: os
    version: 0.0
  - package: pciutils
    version: 3.13.0
  - package: pigz
    version: 2.8
  - package: policycoreutils
    version: 3.7
  - package: procps
    version: 4.0.4
  - package: rdma-core
    version: 54.0
  - package: readline
    version: 8.2
    patches:
      - "readline-8.2-shlib.patch"
  - package: release
    version: 0.0
  - package: runc
    version: 1.1.15
  - package: selinux-policy
    version: 0.0
  - package: socat
    version: 1.8.0.1
  - package: soci-snapshotter
    version: 0.8.0
  - package: static-pods
    version: 0.1
  - package: strace
    version: 6.12
  - package: systemd
    version: 252.22
    patches:
      - "9013-sd-dhcp-lease-parse-multiple-domains-in-option-15.patch"
      - "9010-units-keep-modprobe-service-units-running.patch"
      - "9004-units-mount-tmp-with-noexec.patch"
      - "9007-pkg-config-stop-hardcoding-prefix-to-usr.patch"
      - "9014-meson-make-gpt-auto-generator-selectable-at-build-ti.patch"
      - "1001-sd-netlink-make-calc_elapse-return-USEC_INFINITY-whe.patch"
      - "9012-core-mount-increase-mount-rate-limit-burst-to-25.patch"
      - "9009-sysusers-set-root-shell-to-sbin-nologin.patch"
      - "9002-core-add-separate-timeout-for-system-shutdown.patch"
      - "9006-mount-setup-mount-etc-with-specific-label.patch"
      - "9011-systemd-networkd-Conditionalize-hostnamed-timezoned-.patch"
      - "9008-sysctl-do-not-set-rp_filter-via-wildcard.patch"
      - "9001-use-absolute-path-for-var-run-symlink.patch"
      - "9005-mount-setup-apply-noexec-to-more-mounts.patch"
      - "9003-machine-id-setup-generate-stable-ID-under-Xen-and-VM.patch"
      - "1002-sd-netlink-make-the-default-timeout-configurable-by-.patch"
  - package: util-linux
    version: 2.40.2
  - package: wicked
    version: 0.6.68
    patches:
      - "1003-ship-mkconst-and-schema-sources-for-runtime-use.patch"
      - "0001-dhcp6-refresh-ipv6-flags-on-staring-in-auto-mode.patch"
      - "1005-client-validate-ethernet-namespace-node.patch"
      - "1004-adjust-safeguard-for-dhcp6-defer-timeout.patch"
      - "1007-dhpc6-don-t-cancel-transmission-if-random-delay-happ.patch"
      - "1001-avoid-gcrypt-dependency.patch"
      - "1006-server-discover-hardware-address-of-unconfigured-int.patch"
      - "1002-exclude-unused-components.patch"
      - "1008-dhcp6-reduce-maximum-initial-solicitation-delay-to-1.patch"
  - package: xfsprogs
    version: 6.9.0
---

{{< packages-table >}}
