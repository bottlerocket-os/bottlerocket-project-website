---
title: "Core Kit packages 12.0.1"
type: "docs"
description: "Core Kit Package Versions in Bottlerocket Release 1.52.0"
packages:
  - package: amazon-ecs-cni-plugins
    version: 2024.09.0
    patches:
      - "0001-bottlerocket-default-filesystem-locations.patch"
  - package: amazon-ssm-agent
    version: 3.3.3270.0
    patches:
      - "0001-agent-Add-config-to-make-shell-optional.patch"
  - package: amazon-vpc-cni-plugins
    version: 1.3
  - package: aws-iam-authenticator
    version: 0.7.8
  - package: aws-otel-collector
    version: 0.45.1
    patches:
      - "0001-change-logger-and-extraconfig-file-paths.patch"
  - package: aws-signer-notation-plugin
    version: 1.0.2292
  - package: aws-signing-helper
    version: 1.7.1
  - package: bash
    version: 5.3
    patches:
      - "bash-4.4-no-loadable-builtins.patch"
  - package: binutils
    version: 2.43.1
    patches:
      - "0001-PR32560-stack-buffer-overflow-at-objdump-disassemble.patch"
  - package: chrony
    version: 4.8
  - package: cni
    version: 1.3.0
  - package: cni-plugins
    version: 1.7.1
  - package: conntrack-tools
    version: 1.4.8
    patches:
      - "0001-disable-RPC-helper.patch"
  - package: containerd-1.7
    version: 1.7.29
    patches:
      - "1001-Use-Intel-ISA-L-s-igzip-if-available.patch"
      - "1003-config-change-Plugins-type-from-toml.Tree-to-interfa.patch"
      - "1002-Skip-exec.LookPath-if-a-specific-gzip-implementation.patch"
      - "1004-Allow-sections-of-Plugins-to-be-merged-and-not-overw.patch"
  - package: containerd-2.0
    version: 2.0.7
    patches:
      - "1001-Revert-Don-t-allow-io_uring-related-syscalls-in-the-.patch"
  - package: containerd-2.1
    version: 2.1.5
    patches:
      - "1001-Revert-Don-t-allow-io_uring-related-syscalls-in-the-.patch"
  - package: coreutils
    version: 9.9
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
    version: 29.0.0
    patches:
      - "0001-non-tcp-host-header.patch"
  - package: docker-engine-25
    version: 25.0.13
    patches:
      - "0002-oci-inject-kmod-in-all-containers.patch"
      - "0001-Change-default-capabilities-using-daemon-config.patch"
  - package: docker-engine-29
    version: 29.0.0
    patches:
      - "0002-oci-inject-kmod-in-all-containers.patch"
      - "0004-Set-label-for-containerd-overlayfs-mounts.patch"
      - "0001-Change-default-capabilities-using-daemon-config.patch"
  - package: docker-init
    version: 19.03.15
  - package: e2fsprogs
    version: 1.47.2
  - package: early-boot-config
    version: 0.1
  - package: ecr-credential-helper
    version: 0.10.1
  - package: ecr-credential-provider-1.29
    version: 1.29.8
    patches:
      - "0001-support-new-aws-partition-in-credential-provider.patch"
      - "0002-ecr-credential-provider-hardcode-ecr-endpoint-for-eu.patch"
  - package: ecr-credential-provider-1.30
    version: 1.30.10
    patches:
      - "0001-ecr-credential-provider-hardcode-ECR-endpoint-for-eu.patch"
  - package: ecr-credential-provider-1.31
    version: 1.31.9
    patches:
      - "0001-ecr-credential-provider-hardcode-ECR-endpoint-for-eu.patch"
  - package: ecr-credential-provider-1.32
    version: 1.32.5
    patches:
      - "0001-support-new-aws-partition-in-credential-provider.patch"
      - "0002-ecr-credential-provider-hardcode-ECR-endpoint-for-eu.patch"
  - package: ecr-credential-provider-1.33
    version: 1.33.2
    patches:
      - "0001-support-new-aws-partition-in-credential-provider.patch"
      - "0002-ecr-credential-provider-hardcode-ECR-endpoint-for-eu.patch"
  - package: ecr-credential-provider-1.34
    version: 1.34.1
    patches:
      - "0001-support-new-aws-partition-in-credential-provider.patch"
      - "0002-ecr-credential-provider-hardcode-ECR-endpoint-for-eu.patch"
  - package: ecs-agent
    version: 1.91.2
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
    version: 6.15
  - package: filesystem
    version: 1.0
  - package: findutils
    version: 4.10.0
  - package: glibc
    version: 2.42
    patches:
      - "0003-inet-fortified-fix-namespace-violation-bug-33227.patch"
      - "0020-x86-64-Add-GLIBC_ABI_GNU2_TLS-version-BZ-33129.patch"
      - "0008-Delete-temporary-files-in-support_subprocess.patch"
      - "0019-i386-Add-GLIBC_ABI_GNU_TLS-version-BZ-33221.patch"
      - "0021-x86-64-Add-GLIBC_ABI_DT_X86_64_PLT-BZ-33212.patch"
      - "0006-elf-Handle-ld.so-with-LOAD-segment-gaps-in-_dl_find_.patch"
      - "0022-i386-Also-add-GLIBC_ABI_GNU2_TLS-version-BZ-33129.patch"
      - "9001-move-ldconfig-cache-to-ephemeral-storage.patch"
      - "0001-Replace-advisories-directory-with-pointer-file.patch"
      - "0009-tst-fopen-threaded.c-Delete-temporary-file.patch"
      - "0011-tst-env-setuid-Delete-LD_DEBUG_OUTPUT-output.patch"
      - "0024-libio-Define-AT_RENAME_-with-the-same-tokens-as-Linu.patch"
      - "0023-AArch64-Fix-SVE-powf-routine-BZ-33299.patch"
      - "0015-malloc-Fix-MAX_TCACHE_SMALL_SIZE.patch"
      - "0002-NEWS-add-new-section.patch"
      - "0012-Revert-tst-freopen4-main.c-Call-support_capture_subp.patch"
      - "0005-elf-Extract-rtld_setup_phdr-function-from-dl_main.patch"
      - "0004-stdlib-resolve-a-double-lock-init-issue-after-fork-B.patch"
      - "0013-hurd-support-Fix-running-SGID-tests.patch"
      - "HACK-only-build-and-install-localedef.patch"
      - "glibc-cs-path.patch"
      - "0026-nptl-Fix-MADV_GUARD_INSTALL-logic-for-thread-without.patch"
      - "0010-tst-freopen4-main.c-Call-support_capture_subprocess-.patch"
      - "0017-malloc-Fix-checking-for-small-negative-values-of-tca.patch"
      - "0014-malloc-Remove-redundant-NULL-check.patch"
      - "0016-malloc-Make-sure-tcache_key-is-odd-enough.patch"
      - "0025-nss-Group-merge-does-not-react-to-ERANGE-during-merg.patch"
      - "0007-nptl-Fix-SYSCALL_CANCEL-for-return-values-larger-tha.patch"
      - "0018-Use-TLS-initial-exec-model-for-__libc_tsd_CTYPE_-thr.patch"
  - package: grep
    version: 3.12
  - package: host-ctr
    version: 0.0
  - package: hwloc
    version: 2.12.2
  - package: iproute
    version: 6.18.0
    patches:
      - "0001-skip-libelf-check.patch"
  - package: iptables
    version: 1.8.11
  - package: iputils
    version: 20250605
  - package: kexec-tools
    version: 2.0.32
  - package: keyutils
    version: 1.6.1
  - package: kmod
    version: 34.2
    patches:
      - "0001-meson-add-support-for-static-builds.patch"
      - "0002-meson-create-pkgconfig-files-in-default-path.patch"
  - package: kubernetes-1.29
    version: 1.29.15
  - package: kubernetes-1.30
    version: 1.30.14
  - package: kubernetes-1.31
    version: 1.31.14
  - package: kubernetes-1.32
    version: 1.32.9
  - package: kubernetes-1.33
    version: 1.33.5
  - package: kubernetes-1.34
    version: 1.34.2
  - package: libacl
    version: 2.3.2
  - package: libaio
    version: 0.3.113
  - package: libattr
    version: 2.5.2
  - package: libaudit
    version: 4.1.2
  - package: libbpf
    version: 1.6.2
  - package: libcap
    version: 2.76
    patches:
      - "9001-dont-test-during-install.patch"
  - package: libcryptsetup
    version: 2.8.1
    patches:
      - "0002-build-replace-openssl-with-libcrypto-in-pkgconfig.patch"
      - "0003-random-quiet-message-about-FIPS-mode.patch"
      - "0001-pbkdf-check-whether-FIPS-is-enabled-at-runtime.patch"
  - package: libdevmapper
    version: 2.03.37
  - package: libdrm
    version: 2.4.129
  - package: libelf
    version: 0.194
  - package: libexpat
    version: 2.7.3
  - package: libffi
    version: 3.5.2
  - package: libgcc
    version: 0.0
  - package: libglib
    version: 2.86.2
  - package: libinih
    version: 62
  - package: libisal
    version: 2.31.1
    patches:
      - "1001-igzip-increase-stdin-and-stdout-pipe-sizes.patch"
      - "0002-Address-type-mismatch-warnings-on-aarch64.patch"
      - "0001-Address-compiler-warnings-on-ppc64le-and-s390x.patch"
  - package: libjansson
    version: 2.14.1
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
    version: 1.3.1
  - package: libnl
    version: 3.11.0
  - package: libnvidia-container
    version: 1.17.8
    patches:
      - "0005-Add-clock_gettime-to-allowed-syscalls.patch"
      - "0002-use-prefix-from-environment.patch"
      - "0001-use-shared-libtirpc.patch"
      - "0004-makefile-avoid-ldconfig-when-cross-compiling.patch"
      - "0003-keep-debug-symbols.patch"
  - package: libnvme
    version: 1.15
  - package: libpcre
    version: 10.47
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
    version: 4.1.3
  - package: libudev
    version: 252.39
  - package: liburcu
    version: 0.15.3
    patches:
      - "0001-build-do-not-build-examples.patch"
  - package: libxcrypt
    version: 4.4.38
  - package: libz
    version: 2.2.5
  - package: libzstd
    version: 1.5.7
  - package: login
    version: 0.0.1
  - package: makedumpfile
    version: 1.7.7
    patches:
      - "0000-fix-strip-invocation-for-TARGET-env-variable.patch"
      - "0001-do-not-overlink-with-bzip2.patch"
  - package: mdadm
    version: 4.4
    patches:
      - "0001-report-monitor-output-to-syslog.patch"
  - package: netdog
    version: 0.1.1
  - package: nftables
    version: 1.1.6
  - package: notation
    version: 1.3.2
  - package: notation-image-verifier
    version: 0.1.0
  - package: nvidia-container-toolkit
    version: 1.17.8
  - package: nvidia-k8s-device-plugin
    version: 0.17.3
  - package: nvme-cli
    version: 2.15
    patches:
      - "0001-plugins-amzn-Add-stats-support-for-EC2-local-storage.patch"
  - package: open-vm-tools
    version: 13.0.5
    patches:
      - "0002-dont-force-cppflags.patch"
      - "0003-Update-shutdown-code-to-work-for-Bottlerocket.patch"
      - "0001-no_cflags_werror.patch"
  - package: os
    version: 0.0
  - package: pciutils
    version: 3.14.0
  - package: pigz
    version: 2.8
  - package: policycoreutils
    version: 3.8.1
  - package: procps
    version: 4.0.5
    patches:
      - "1001-check-for-sys-pidfd.h.patch"
      - "0001-library-internal-expand-buffer-for-stat_fd.patch"
  - package: rdma-core
    version: 60.0
  - package: readline
    version: 8.3
    patches:
      - "readline-8.3-shlib.patch"
  - package: release
    version: 0.0
  - package: rocm-k8s-device-plugin
    version: 1.31.0.8
  - package: rottweiler
    version: 0.1.0
  - package: runc
    version: 1.2.8
    patches:
      - "1001-rootfs-only-set-mode-for-tmpfs-mount.patch"
  - package: selinux-policy
    version: 0.0
  - package: soci-snapshotter
    version: 0.12.0
  - package: static-pods
    version: 0.1
  - package: strace
    version: 6.17
  - package: systemd-252
    version: 252.39
    patches:
      - "9019-suppress-log-for-units-with-mode-0044.patch"
      - "9018-meson-replace-openssl-dependency-with-libcrypto.patch"
      - "9013-sd-dhcp-lease-parse-multiple-domains-in-option-15.patch"
      - "9010-units-keep-modprobe-service-units-running.patch"
      - "9004-units-mount-tmp-with-noexec.patch"
      - "9016-meson-always-set-HAVE_OPENSSL_OR_GCRYPT-to-false.patch"
      - "9017-dissect-image-disable-openssl-support.patch"
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
      - "9015-allow-lookups-of-local-domains-using-unicast-DNS.patch"
      - "1003-exec-util-make-missing-agents-a-gracefull-handled-issues.patch"
      - "9003-machine-id-setup-generate-stable-ID-under-Xen-and-VM.patch"
      - "1002-sd-netlink-make-the-default-timeout-configurable-by-.patch"
  - package: systemd-257
    version: 257.9
    patches:
      - "9014-remove-NID_sm2.patch"
      - "9010-meson-replace-openssl-dependency-with-libcrypto.patch"
      - "9007-sd-dhcp-lease-parse-multiple-domains-in-option-15.patch"
      - "9009-dissect-image-disable-openssl-support.patch"
      - "9015-disable-sb-sign.patch"
      - "9002-mount-setup-apply-noexec-to-more-mounts.patch"
      - "9017-meson-set-DOPENSSL_NO_UI_CONSOLE-when-using-openssl.patch"
      - "9008-allow-lookups-of-local-domains-using-unicast-DNS.patch"
      - "9004-sysctl-do-not-set-rp_filter-via-wildcard.patch"
      - "9016-bootctl-disable-secure-boot-autoenroll.patch"
      - "9005-sysusers-set-root-shell-to-sbin-nologin.patch"
      - "9003-mount-setup-mount-etc-with-specific-label.patch"
      - "9001-machine-id-setup-generate-stable-ID-under-VM.patch"
      - "9013-fix-openssl-aws-lc-divergence-in-data-types.patch"
      - "9012-openssl-util-build-without-ui.patch"
      - "9006-systemd-networkd-Conditionalize-hostnamed-timezoned-.patch"
      - "1001-exec-util-make-missing-agents-a-gracefull-handled-issues.patch"
      - "9011-suppress-log-for-units-with-mode-0044.patch"
  - package: tpm2-tools
    version: 5.7
    patches:
      - "0001-tpm2-tools-disable-SM2-and-SM3-checks.patch"
      - "0002-tpm2-tools-disable-tpm2_getekcertificate.patch"
  - package: util-linux
    version: 2.41.2
  - package: xfsprogs
    version: 6.16.0
    patches:
      - "0001-mkfs-source-defaults-from-config-file.patch"
---

{{< packages-table >}}
