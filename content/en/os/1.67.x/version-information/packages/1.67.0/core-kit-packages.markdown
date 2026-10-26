---
title: "Core Kit packages 17.2.0"
type: "docs"
description: "Core Kit Package Versions in Bottlerocket Release 1.67.0"
packages:
  - package: amazon-ecs-cni-plugins
    version: 2026.05.0
    patches:
      - "0001-bottlerocket-default-filesystem-locations.patch"
  - package: amazon-ssm-agent
    version: 3.3.5390.0
    patches:
      - "0001-agent-Add-config-to-make-shell-optional.patch"
  - package: amazon-vpc-cni-plugins
    version: 1.3
  - package: aws-iam-authenticator
    version: 0.7.20
  - package: aws-otel-collector
    version: 0.49.0
    patches:
      - "0001-change-logger-and-extraconfig-file-paths.patch"
  - package: aws-signer-notation-plugin
    version: 1.0.2292
  - package: aws-signing-helper
    version: 1.8.4
  - package: bash
    version: 5.3.15
    patches:
      - "bash-4.4-no-loadable-builtins.patch"
  - package: binutils
    version: 2.44
  - package: chrony
    version: 4.8
  - package: cni
    version: 1.3.0
  - package: cni-plugins
    version: 1.9.1
  - package: conntrack-tools
    version: 1.4.9
    patches:
      - "0001-disable-RPC-helper.patch"
  - package: containerd-1.7
    version: 1.7.36
    patches:
      - "1003-config-change-Plugins-type-from-toml.Tree-to-interfa.patch"
      - "1002-Skip-exec.LookPath-if-a-specific-gzip-implementation.patch"
      - "1001-Use-Intel-ISA-L-s-igzip-if-available.patch"
      - "1004-Allow-sections-of-Plugins-to-be-merged-and-not-overw.patch"
  - package: containerd-2.2
    version: 2.2.9
    patches:
      - "1003-ctr-default-hosts-dir-to-etc-containerd-certs.d.patch"
      - "1001-Revert-Don-t-allow-io_uring-related-syscalls-in-the-.patch"
      - "1002-transfer-service-fallback-to-credentials.toml-for-re.patch"
  - package: containerd-2.3
    version: 2.3.6
    patches:
      - "1003-ctr-default-hosts-dir-to-etc-containerd-certs.d.patch"
      - "1001-Revert-Don-t-allow-io_uring-related-syscalls-in-the-.patch"
      - "1002-transfer-service-fallback-to-credentials.toml-for-re.patch"
  - package: coreutils
    version: 9.11
  - package: cri-tools
    version: 1.35.0
  - package: dbus-broker
    version: 37
    patches:
      - "0001-c-utf8-disable-strict-aliasing-optimizations.patch"
      - "0002-meson.build-remove-condition-to-build-the-journal-ca.patch"
  - package: docker-cli-25
    version: 25.0.7
    patches:
      - "0001-non-tcp-host-header.patch"
  - package: docker-cli-29
    version: 29.0.4
    patches:
      - "0001-non-tcp-host-header.patch"
  - package: docker-engine-25
    version: 25.0.17
    patches:
      - "0001-Change-default-capabilities-using-daemon-config.patch"
      - "0002-oci-inject-kmod-in-all-containers.patch"
  - package: docker-engine-29
    version: 29.0.4
    patches:
      - "0001-Change-default-capabilities-using-daemon-config.patch"
      - "0004-Set-label-for-containerd-overlayfs-mounts.patch"
      - "0002-oci-inject-kmod-in-all-containers.patch"
  - package: docker-init
    version: 19.03.15
  - package: e2fsprogs
    version: 1.47.4
  - package: early-boot-config
    version: 0.1
  - package: ecr-credential-helper
    version: 0.12.0
  - package: ecr-credential-provider-1.31
    version: 1.31.9
    patches:
      - "0001-ecr-credential-provider-hardcode-ECR-endpoint-for-eu.patch"
  - package: ecr-credential-provider-1.32
    version: 1.32.8
    patches:
      - "0001-ecr-credential-provider-hardcode-ECR-endpoint-for-eu.patch"
  - package: ecr-credential-provider-1.33
    version: 1.33.4
    patches:
      - "0001-ecr-credential-provider-hardcode-ECR-endpoint-for-eu.patch"
  - package: ecr-credential-provider-1.34
    version: 1.34.3
    patches:
      - "0001-ecr-credential-provider-hardcode-ECR-endpoint-for-eu.patch"
  - package: ecr-credential-provider-1.35
    version: 1.35.2
    patches:
      - "0001-ecr-credential-provider-hardcode-ECR-endpoint-for-eu.patch"
  - package: ecr-credential-provider-1.36
    version: 1.36.1
    patches:
      - "0001-ecr-credential-provider-hardcode-ECR-endpoint-for-eu.patch"
  - package: ecr-credential-provider-1.37
    version: 1.37.0
    patches:
      - "0001-ecr-credential-provider-hardcode-ECR-endpoint-for-eu.patch"
  - package: ecs-agent
    version: 1.106.1
    patches:
      - "0002-bottlerocket-remove-unsupported-capabilities.patch"
      - "0003-bottlerocket-bind-introspection-to-localhost.patch"
      - "0004-bottlerocket-fix-procfs-path-on-host.patch"
      - "0006-containermetadata-don-t-use-dataDirOnHost-for-metada.patch"
      - "0001-bottlerocket-default-filesystem-locations.patch"
      - "0005-bottlerocket-change-execcmd-directories-for-Bottlero.patch"
  - package: ecs-gpu-init
    version: 0.0
  - package: erofs-utils
    version: 1.8.10
    patches:
      - "0001-build-disable-AC_CANONICAL_TARGET.patch"
  - package: ethtool
    version: 7.1
  - package: filesystem
    version: 1.0
  - package: findutils
    version: 4.11.0
  - package: glibc
    version: 2.44
    patches:
      - "0023-string-Speed-up-strcasecmp-test-data-initialization.patch"
      - "0036-Add-check-symbol-version.awk.patch"
      - "0033-alpha-Fix-stack-alignment-in-makecontext.patch"
      - "0022-string-Speed-up-strcmp-test-data-initialization.patch"
      - "0035-alpha-expect-test-float32x-float64-div-to-fail.patch"
      - "0003-hurd-Make-the-readlink-__fstatat64-references-option.patch"
      - "0034-alpha-add-the-denormal-trap-enable-bit-to-FE_NOMASK_.patch"
      - "0045-Revert-io-drop-nonnull-attribute-for-fchmodat-facces.patch"
      - "0004-hurd-fix-fork-s-longjmp-demangling-on-i386.patch"
      - "9002-Revert-malloc-auto-enable-THP-on-aarch64.patch"
      - "0032-iconvdata-Test-case-for-bug-34556-bug-34568.patch"
      - "0039-libio-Fix-CVE-2026-18374-heap-buffer-overflow-in-ccs.patch"
      - "0020-stdio-common-run-AWK-in-the-C-locale-in-the-printf-f.patch"
      - "0026-misc-Fix-out-of-bounds-array-write-in-tdelete-bug-34.patch"
      - "0041-nptl-Skip-pretty-printer-tests-without-python3-BZ-34.patch"
      - "0009-linux-Inline-syscall-cancellation-to-keep-wrapper-fr.patch"
      - "0017-elf-test-handle-different-rootsbindir-in-tst-ldconfi.patch"
      - "0012-Makefile-Only-print-the-test-summary-in-the-second-p.patch"
      - "0048-resolv-Fix-assertion-failure-on-search-list-truncati.patch"
      - "0024-elf-Honour-skip_ifunc-for-cross-object-IFUNC-relocat.patch"
      - "0002-NEWS-start-2.44.1-section.patch"
      - "0015-arm-Order-the-rtld-link-after-libgcc-stubs.a.patch"
      - "0030-iconvdata-SHIFT_JISX0213-decoding-lacks-pending-char.patch"
      - "0010-Fix-gen-as-const-headers-races-with-the-parallel-sub.patch"
      - "0038-powerpc-Fix-preprocessor-conditional-in-soft-float-_.patch"
      - "0001-advisories-replace-with-ADVISORIES-text-file.patch"
      - "0031-iconvdata-EUC_JISX0213-decoding-lacks-pending-charac.patch"
      - "0011-Makerules-Only-install-the-ABI-lib-names-header-from.patch"
      - "0019-powerpc-Fix-mlong-double-128-IBM-format-configure-te.patch"
      - "0043-io-drop-nonnull-attribute-for-fchmodat-faccessat-fch.patch"
      - "0005-math-Fix-sinh-worst-case-results-for-x-36.736801-BZ-.patch"
      - "0040-libio-Add-test-for-fopen-with-an-empty-ccs-value-BZ-.patch"
      - "0021-stdio-common-avoid-repeated-regexp-matches-in-tst-pr.patch"
      - "0013-Makerules-Make-the-.dt-to-.d-conversion-safe-against.patch"
      - "0018-ldbl-opt-Fix-mlong-double-128-configure-test-for-Cla.patch"
      - "0028-posix-Remove-unnecessary-overflow-check-in-wordexp-B.patch"
      - "0044-x86-64-Link-tst-shstk-legacy-1-f-g-with-Wl-no-as-nee.patch"
      - "0037-powerpc-Fix-non-atomic-stack-pointer-update-in-forti.patch"
      - "0016-benchtests-Create-objdir-in-the-bench-.c-generation-.patch"
      - "0046-io-drop-nonnull-attribute-for-fchmodat-faccessat-fch.patch"
      - "0008-hurd-Fix-build-after-the-ftw-kernel_stat.h-inclusion.patch"
      - "9001-move-ldconfig-cache-to-ephemeral-storage.patch"
      - "0014-Makefile-Order-the-top-level-stamp-files-before-the-.patch"
      - "0027-m68k-remove-sysdeps-m68k-m680x0-fpu-w_fmod_compat.c-.patch"
      - "0042-elf-Do-not-load-cache-extensions-from-an-old-format-.patch"
      - "glibc-cs-path.patch"
      - "0007-io-fix-ftw-ABI-on-MIPS-n64.patch"
      - "HACK-only-build-and-install-localedef.patch"
      - "0047-fcntl-drop-nonnull-attribute-for-openat-openat2-s-pa.patch"
      - "0025-m68k-Fix-fmod-fmodf-infinite-recursion-BZ-34508.patch"
      - "0006-math-Fix-x86_64-tanh-_FloatN-aliases-binding-to-the-.patch"
      - "0029-stdlib-Fix-right-justification-in-strfmon-bug-34510-.patch"
  - package: grep
    version: 3.12
  - package: host-ctr
    version: 0.0
  - package: hwloc
    version: 2.14.0
  - package: iproute
    version: 7.1.0
    patches:
      - "0001-skip-libelf-check.patch"
  - package: iptables
    version: 1.8.13
  - package: iputils
    version: 20250605
  - package: kexec-tools
    version: 2.0.32
  - package: keyutils
    version: 1.6.3
  - package: kmod
    version: 34.2
    patches:
      - "0002-meson-create-pkgconfig-files-in-default-path.patch"
      - "0001-meson-add-support-for-static-builds.patch"
  - package: kubernetes-1.31
    version: 1.31.14
  - package: kubernetes-1.32
    version: 1.32.13
  - package: kubernetes-1.33
    version: 1.33.13
  - package: kubernetes-1.34
    version: 1.34.9
    patches:
      - "0001-apiserver-drop-unused-go-proxyproto-require.patch"
  - package: kubernetes-1.35
    version: 1.35.6
  - package: kubernetes-1.36
    version: 1.36.2
  - package: kubernetes-1.37
    version: 1.37.0
  - package: libacl
    version: 2.4.0
  - package: libaio
    version: 0.3.113
  - package: libattr
    version: 2.6.0
  - package: libaudit
    version: 4.2.1
  - package: libbpf
    version: 1.7.0
  - package: libcap
    version: 2.78
    patches:
      - "9001-dont-test-during-install.patch"
  - package: libcryptsetup
    version: 2.8.8
    patches:
      - "0003-random-quiet-message-about-FIPS-mode.patch"
      - "0002-build-replace-openssl-with-libcrypto-in-pkgconfig.patch"
      - "0001-pbkdf-check-whether-FIPS-is-enabled-at-runtime.patch"
  - package: libdevmapper
    version: 2.03.42
  - package: libdrm
    version: 2.4.129
  - package: libelf
    version: 0.196
    patches:
      - "0002-backends-use-sys-uio.h-instead-of-linux-uio.h.patch"
      - "0001-fix-const-correctness-for-C23-compatibility-as-implemented-in-glibc-2.43.patch"
  - package: libffi
    version: 3.8.0
  - package: libgcc
    version: 0.0
  - package: libglib
    version: 2.90.0
  - package: libinih
    version: 62
  - package: libisal
    version: 2.32.1
    patches:
      - "1001-igzip-increase-stdin-and-stdout-pipe-sizes.patch"
  - package: libjansson
    version: 2.14.1
  - package: libjson-c
    version: 0.18
  - package: libmnl
    version: 1.0.5
  - package: libncurses
    version: 6.6
    patches:
      - "ncurses-urxvt.patch"
      - "ncurses-config.patch"
      - "ncurses-libs.patch"
  - package: libnetfilter_conntrack
    version: 1.1.1
  - package: libnetfilter_cthelper
    version: 1.0.1
  - package: libnetfilter_cttimeout
    version: 1.0.1
  - package: libnetfilter_queue
    version: 1.0.5
  - package: libnfnetlink
    version: 1.0.2
  - package: libnftnl
    version: 1.3.1
  - package: libnl
    version: 3.12.0
  - package: libnvidia-container
    version: 1.19.1
    patches:
      - "0001-use-shared-libtirpc.patch"
      - "0002-use-prefix-from-environment.patch"
      - "0003-keep-debug-symbols.patch"
      - "0004-makefile-avoid-ldconfig-when-cross-compiling.patch"
  - package: libnvme
    version: 1.16
  - package: libpcre
    version: 10.49
  - package: libpopt
    version: 1.19
  - package: libseccomp
    version: 2.6.0
  - package: libselinux
    version: 3.8.1
  - package: libsemanage
    version: 3.8.1
    patches:
      - "0001-remove-bzip2-dependency.patch"
  - package: libsepol
    version: 3.8.1
  - package: libstd-rust
    version: 0.0
  - package: libtirpc
    version: 1.3.7
  - package: libtss2
    version: 4.2.0
  - package: libudev
    version: 252.39
  - package: liburcu
    version: 0.15.6
    patches:
      - "0001-build-do-not-build-examples.patch"
  - package: libxcrypt
    version: 4.5.2
    patches:
      - "0001-fix-Werror-discarded-qualifiers.patch"
  - package: libz
    version: 2.3.3
  - package: libzstd
    version: 1.5.7
  - package: login
    version: 0.0.1
  - package: makedumpfile
    version: 1.7.9
    patches:
      - "0000-fix-strip-invocation-for-TARGET-env-variable.patch"
      - "0001-do-not-overlink-with-bzip2.patch"
  - package: mdadm
    version: 4.6
    patches:
      - "0001-report-monitor-output-to-syslog.patch"
  - package: netdog
    version: 0.1.1
  - package: nftables
    version: 1.1.6
  - package: notation
    version: 1.3.2
  - package: nvidia-container-toolkit
    version: 1.19.1
    patches:
      - "0002-add-additional-symlinks-flag.patch"
      - "0001-discover-reduce-missing-resource-warnings-to-debug-l.patch"
  - package: nvidia-dra-driver-gpu
    version: 25.8.1
  - package: nvidia-k8s-device-plugin
    version: 0.19.3
    patches:
      - "1002-Enable-library-path-compatibility-symlinks.patch"
      - "1001-Ensure-that-generated-CDI-specs-do-not-contain-enabl.patch"
      - "0001-Update-MPS-roots-for-immutable-host-OS.patch"
      - "1003-vendor-add-CreateLibSymlinksHook.patch"
  - package: nvme-cli
    version: 2.16
  - package: open-vm-tools
    version: 13.1.0
    patches:
      - "0002-dont-force-cppflags.patch"
      - "0005-glib_stubs-avoid-GLib-g_free-macro-redefinition-erro.patch"
      - "0004-fix-initialization-discards-const-qualifier-from-poi.patch"
      - "0001-no_cflags_werror.patch"
      - "0003-Update-shutdown-code-to-work-for-Bottlerocket.patch"
  - package: os
    version: 0.0
  - package: pciutils
    version: 3.15.0
  - package: perf
    version: 6.18.10
    patches:
      - "0001-libperf-fix-parallel-build-race-with-header-install.patch"
  - package: pigz
    version: 2.8
  - package: policycoreutils
    version: 3.8.1
  - package: procps
    version: 4.0.7
    patches:
      - "1001-fix-const-correctness-for-C23-compatibility-as-implemented-in-glibc-2.43.patch"
  - package: readline
    version: 8.3
    patches:
      - "readline-8.3-shlib.patch"
  - package: release
    version: 0.0
  - package: rottweiler
    version: 0.1.0
  - package: runc
    version: 1.3.6
  - package: selinux-policy
    version: 0.0
  - package: soci-snapshotter
    version: 0.16.1
  - package: static-pods
    version: 0.1
  - package: strace
    version: 7.1
  - package: systemd-252
    version: 252.39
    patches:
      - "9013-sd-dhcp-lease-parse-multiple-domains-in-option-15.patch"
      - "9009-sysusers-set-root-shell-to-sbin-nologin.patch"
      - "9018-meson-replace-openssl-dependency-with-libcrypto.patch"
      - "9014-meson-make-gpt-auto-generator-selectable-at-build-ti.patch"
      - "9004-units-mount-tmp-with-noexec.patch"
      - "9003-machine-id-setup-generate-stable-ID-under-Xen-and-VM.patch"
      - "9001-use-absolute-path-for-var-run-symlink.patch"
      - "9016-meson-always-set-HAVE_OPENSSL_OR_GCRYPT-to-false.patch"
      - "9038-nspawn-normalize-pivot_root-paths.patch"
      - "9015-allow-lookups-of-local-domains-using-unicast-DNS.patch"
      - "9011-systemd-networkd-Conditionalize-hostnamed-timezoned-.patch"
      - "9019-suppress-log-for-units-with-mode-0044.patch"
      - "9005-mount-setup-apply-noexec-to-more-mounts.patch"
      - "9010-units-keep-modprobe-service-units-running.patch"
      - "9008-sysctl-do-not-set-rp_filter-via-wildcard.patch"
      - "9006-mount-setup-mount-etc-with-specific-label.patch"
      - "9017-dissect-image-disable-openssl-support.patch"
      - "9002-core-add-separate-timeout-for-system-shutdown.patch"
      - "9020-core-validate-input-cgroup-path-more-prudently.patch"
      - "1001-sd-netlink-make-calc_elapse-return-USEC_INFINITY-whe.patch"
      - "9012-core-mount-increase-mount-rate-limit-burst-to-25.patch"
      - "1003-exec-util-make-missing-agents-a-gracefull-handled-issues.patch"
      - "1002-sd-netlink-make-the-default-timeout-configurable-by-.patch"
      - "9007-pkg-config-stop-hardcoding-prefix-to-usr.patch"
      - "9039-nspawn-apply-BindUser-Ephemeral-from-settings-fil.patch"
  - package: systemd-257
    version: 257.13
    patches:
      - "9013-fix-openssl-aws-lc-divergence-in-data-types.patch"
      - "9018-build-correct-sd-boot-EFI-arch-on-the-Bottlerocket-S.patch"
      - "9003-mount-setup-mount-etc-with-specific-label.patch"
      - "9019-boot-remove-SMBIOS-Type-11-kernel-cmdline-extra-mech.patch"
      - "9002-mount-setup-apply-noexec-to-more-mounts.patch"
      - "9008-allow-lookups-of-local-domains-using-unicast-DNS.patch"
      - "9017-meson-set-DOPENSSL_NO_UI_CONSOLE-when-using-openssl.patch"
      - "1001-exec-util-make-missing-agents-a-gracefull-handled-issues.patch"
      - "9007-sd-dhcp-lease-parse-multiple-domains-in-option-15.patch"
      - "9010-meson-replace-openssl-dependency-with-libcrypto.patch"
      - "9014-remove-NID_sm2.patch"
      - "9009-dissect-image-disable-openssl-support.patch"
      - "9021-measure-figure-success-of-measurement-correctly.patch"
      - "9016-bootctl-disable-secure-boot-autoenroll.patch"
      - "9022-efivars-kill-SystemdOptions-efi-var-support.patch"
      - "9012-openssl-util-build-without-ui.patch"
      - "9020-boot-vmspawn-finish-removing-SMBIOS-cmdline-extra-bi.patch"
      - "9001-machine-id-setup-generate-stable-ID-under-VM.patch"
      - "9011-suppress-log-for-units-with-mode-0044.patch"
      - "9004-sysctl-do-not-set-rp_filter-via-wildcard.patch"
      - "9015-disable-sb-sign.patch"
      - "9005-sysusers-set-root-shell-to-sbin-nologin.patch"
      - "9006-systemd-networkd-Conditionalize-hostnamed-timezoned-.patch"
  - package: tpm2-tools
    version: 5.8
    patches:
      - "0001-tpm2-tools-disable-SM2-and-SM3-checks.patch"
      - "0002-tpm2-tools-disable-tpm2_getekcertificate.patch"
  - package: util-linux
    version: 2.42.2
    patches:
      - "0001-libblkid-keep-only-supported-partition-probers.patch"
  - package: xfsprogs
    version: 7.1.1
    patches:
      - "0001-mkfs-source-defaults-from-config-file.patch"
---

{{< packages-table >}}
