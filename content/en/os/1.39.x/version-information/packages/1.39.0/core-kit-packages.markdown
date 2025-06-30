---
title: "Core Kit Version 8.1.0"
type: "docs"
description: "Core Kit Package Versions in Bottlerocket Release 1.39.0"
packages:
  - package: amazon-ecs-cni-plugins
    version: 2024.09.0
    patches:
      - "0001-bottlerocket-default-filesystem-locations.patch"
  - package: amazon-ssm-agent
    version: 3.3.1957.0
    patches:
      - "0001-agent-Add-config-to-make-shell-optional.patch"
  - package: amazon-vpc-cni-plugins
    version: 1.3
  - package: aws-iam-authenticator
    version: 0.6.30
  - package: aws-otel-collector
    version: 0.43.1
    patches:
      - "0001-change-logger-and-extraconfig-file-paths.patch"
  - package: aws-signing-helper
    version: 1.4.0
  - package: bash
    version: 5.2.37
    patches:
      - "bash-5.0-patch-1.patch"
      - "bash-4.4-no-loadable-builtins.patch"
      - "bash-5.0-patch-2.patch"
  - package: binutils
    version: 2.43.1
    patches:
      - "0001-PR32560-stack-buffer-overflow-at-objdump-disassemble.patch"
  - package: chrony
    version: 4.6.1
  - package: cni
    version: 1.2.3
  - package: cni-plugins
    version: 1.6.2
  - package: conntrack-tools
    version: 1.4.8
    patches:
      - "0001-disable-RPC-helper.patch"
  - package: containerd-1.7
    version: 1.7.27
    patches:
      - "1001-Use-Intel-ISA-L-s-igzip-if-available.patch"
      - "1002-Skip-exec.LookPath-if-a-specific-gzip-implementation.patch"
  - package: containerd-2.0
    version: 2.0.5
    patches:
      - "1001-Revert-Don-t-allow-io_uring-related-syscalls-in-the-.patch"
  - package: coreutils
    version: 9.6
  - package: cryptsetup
    version: 2.7.5
    patches:
      - "0001-pbkdf-check-whether-FIPS-is-enabled-at-runtime.patch"
  - package: dbus-broker
    version: 36
    patches:
      - "0001-c-utf8-disable-strict-aliasing-optimizations.patch"
  - package: docker-cli
    version: 25.0.7
    patches:
      - "0001-non-tcp-host-header.patch"
  - package: docker-engine
    version: 25.0.8
    patches:
      - "0002-oci-inject-kmod-in-all-containers.patch"
      - "0001-Change-default-capabilities-using-daemon-config.patch"
  - package: docker-init
    version: 19.03.15
  - package: e2fsprogs
    version: 1.47.1
  - package: early-boot-config
    version: 0.1
  - package: ecr-credential-provider-1.26
    version: 1.26.14
  - package: ecr-credential-provider-1.27
    version: 1.27.10
  - package: ecr-credential-provider-1.28
    version: 1.28.11
  - package: ecr-credential-provider-1.29
    version: 1.29.8
  - package: ecr-credential-provider-1.30
    version: 1.30.8
  - package: ecr-credential-provider-1.31
    version: 1.31.5
  - package: ecr-credential-provider-1.32
    version: 1.32.2
  - package: ecr-credential-provider-1.33
    version: 1.33.0
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
    version: 6.11
  - package: filesystem
    version: 1.0
  - package: findutils
    version: 4.10.0
  - package: glibc
    version: 2.41
    patches:
      - "0029-configure-Fix-spelling-of-Wl-no-error-execstack-opti.patch"
      - "0002-NEWS-start-new-section.patch"
      - "0021-aarch64-Add-GCS-tests-for-dlopen.patch"
      - "0034-nptl-PTHREAD_COND_INITIALIZER-compatibility-with-pre.patch"
      - "0035-nptl-Check-if-thread-is-already-terminated-in-sigcan.patch"
      - "0001-Remove-advisories-from-release-branch.patch"
      - "0022-aarch64-Add-GCS-test-with-signal-handler.patch"
      - "0012-RISC-V-Fix-IFUNC-resolver-cannot-access-gp-pointer.patch"
      - "0019-aarch64-Add-tests-for-Guarded-Control-Stack.patch"
      - "0020-aarch64-Add-GCS-tests-for-transitive-dependencies.patch"
      - "0007-assert-Add-test-for-CVE-2025-0395.patch"
      - "0030-posix-Move-environ-helper-variables-next-to-environ-.patch"
      - "0026-Pass-Wl-no-error-execstack-for-tests-where-Wl-z-exec.patch"
      - "0032-Linux-Remove-attribute-access-from-sched_getattr-bug.patch"
      - "9001-move-ldconfig-cache-to-ephemeral-storage.patch"
      - "0009-x86-__HAVE_FLOAT128-Defined-to-0-for-Intel-SYCL-comp.patch"
      - "0027-static-pie-Skip-the-empty-PT_LOAD-segment-at-offset-.patch"
      - "0005-nptl-Correct-stack-size-attribute-when-stack-grows-u.patch"
      - "0010-math-Fix-unknown-type-name-__float128-for-clang-3.4-.patch"
      - "0003-math-Fix-log10p1f-internal-table-value-BZ-32626.patch"
      - "0016-AArch64-Improve-codegen-for-SVE-pow.patch"
      - "0031-math-Remove-an-extra-semicolon-in-math-function-decl.patch"
      - "0011-math-Add-optimization-barrier-to-ensure-a1-u.d-is-no.patch"
      - "0017-AArch64-Improve-codegen-for-SVE-powf.patch"
      - "0037-x86_64-Add-sinh-with-FMA.patch"
      - "HACK-only-build-and-install-localedef.patch"
      - "0004-math-Fix-sinhf-for-some-inputs-BZ-32627.patch"
      - "0023-math-Improve-layout-of-exp-exp10-data.patch"
      - "glibc-cs-path.patch"
      - "0008-Fix-tst-aarch64-pkey-to-handle-ENOSPC-as-not-support.patch"
      - "0006-math-Fix-tanf-for-some-inputs-BZ-32630.patch"
      - "0036-x86_64-Add-tanh-with-FMA.patch"
      - "0018-aarch64-Add-configure-checks-for-GCS-support.patch"
      - "0015-AArch64-Improve-codegen-for-SVE-erfcf.patch"
      - "0028-elf-Check-if-__attribute__-aligned-65536-is-supporte.patch"
      - "0033-nptl-clear-the-whole-rseq-area-before-registration.patch"
      - "0025-AArch64-Use-prefer_sve_ifuncs-for-SVE-memset.patch"
      - "0013-Aarch64-Improve-codegen-in-SVE-asinh.patch"
      - "0024-AArch64-Add-SVE-memset.patch"
      - "0038-x86_64-Add-atanh-with-FMA.patch"
      - "0014-Aarch64-Improve-codegen-in-SVE-exp-and-users-and-upd.patch"
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
    version: 2.0.30
  - package: keyutils
    version: 1.6.1
  - package: kmod
    version: 33
  - package: kubernetes-1.26
    version: 1.26.15
  - package: kubernetes-1.27
    version: 1.27.16
  - package: kubernetes-1.28
    version: 1.28.15
  - package: kubernetes-1.29
    version: 1.29.14
  - package: kubernetes-1.30
    version: 1.30.10
  - package: kubernetes-1.31
    version: 1.31.6
  - package: kubernetes-1.32
    version: 1.32.2
  - package: kubernetes-1.33
    version: 1.33.0
  - package: libacl
    version: 2.3.2
  - package: libaio
    version: 0.3.113
  - package: libattr
    version: 2.5.2
  - package: libaudit
    version: 4.0.3
  - package: libbpf
    version: 1.5.0
  - package: libcap
    version: 2.75
    patches:
      - "9001-dont-test-during-install.patch"
  - package: libcrypto
    version: 3.0.0
    patches:
      - "0001-Cherry-pick-BORINGSSL_bcm_text_hash-Go-utility-2221.patch"
      - "0002-Cherry-pick-Fix-out-of-bound-OOB-input-read-in-AES-X.patch"
      - "0003-Cherry-pick-support-for-CMake-4.0-to-fips-2024-09-27.patch"
  - package: libdbus
    version: 1.16.2
  - package: libdevmapper
    version: 2.03.31
  - package: libelf
    version: 0.192
  - package: libexpat
    version: 2.7.0
  - package: libffi
    version: 3.4.7
  - package: libgcc
    version: 0.0
  - package: libglib
    version: 2.84.0
  - package: libinih
    version: 58
  - package: libisal
    version: 2.31.1
    patches:
      - "0001-igzip-increase-stdin-and-stdout-pipe-sizes.patch"
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
    version: 1.17.4
    patches:
      - "0002-use-prefix-from-environment.patch"
      - "0001-use-shared-libtirpc.patch"
      - "0004-makefile-avoid-ldconfig-when-cross-compiling.patch"
      - "0003-keep-debug-symbols.patch"
  - package: libnvme
    version: 1.11.1
  - package: libpcre
    version: 10.44
  - package: libpopt
    version: 1.19
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
  - package: libtss2
    version: 4.1.3
  - package: liburcu
    version: 0.15.1
  - package: libxcrypt
    version: 4.4.38
  - package: libz
    version: 2.2.4
  - package: libzstd
    version: 1.5.7
  - package: login
    version: 0.0.1
  - package: makedumpfile
    version: 1.7.6
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
    version: 1.17.4
  - package: nvidia-k8s-device-plugin
    version: 0.17.0
  - package: nvme-cli
    version: 2.11
    patches:
      - "0001-plugins-amzn-add-stats-support.patch"
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
    version: 4.0.5
  - package: rdma-core
    version: 56.0
  - package: readline
    version: 8.2.13
    patches:
      - "readline-8.2-shlib.patch"
  - package: release
    version: 0.0
  - package: runc
    version: 1.2.6
  - package: selinux-policy
    version: 0.0
  - package: socat
    version: 1.8.0.3
  - package: soci-snapshotter
    version: 0.9.0
  - package: static-pods
    version: 0.1
  - package: strace
    version: 6.13
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
      - "9015-allow-lookups-of-local-domains-using-unicast-DNS.patch"
      - "9003-machine-id-setup-generate-stable-ID-under-Xen-and-VM.patch"
      - "1002-sd-netlink-make-the-default-timeout-configurable-by-.patch"
  - package: tpm2-tools
    version: 5.7
    patches:
      - "0001-tpm2-tools-disable-SM2-and-SM3-checks.patch"
      - "0002-tpm2-tools-disable-tpm2_getekcertificate.patch"
  - package: util-linux
    version: 2.40.4
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
