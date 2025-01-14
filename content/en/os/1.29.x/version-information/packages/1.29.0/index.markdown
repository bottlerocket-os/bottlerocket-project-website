---
title: "1.29.0"
type: "docs"
description: "Package Versions in Bottlerocket Release 1.29.0"
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
    version: 0.6.26
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
    version: 4.5
  - package: cni
    version: 1.2.3
  - package: cni-plugins
    version: 1.5.1
  - package: conntrack-tools
    version: 1.4.8
    patches:
      - "0001-disable-RPC-helper.patch"
  - package: containerd
    version: 1.7.22
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
    version: 1.27.9
  - package: ecr-credential-provider-1.29
    version: 1.29.6
  - package: ecr-credential-provider-1.30
    version: 1.30.3
  - package: ecr-credential-provider-1.31
    version: 1.31.0
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
    version: 2.38
    patches:
      - "0047-sparc-Fix-broken-memset-for-sparc32-BZ-31068.patch"
      - "0093-resolv-Fix-tst-resolv-short-response-for-older-GCC-b.patch"
      - "0059-AArch64-Cleanup-emag-memset.patch"
      - "0090-mremap-Update-manual-entry.patch"
      - "0016-elf-Remove-unused-l_text_end-field-from-struct-link_.patch"
      - "0011-sysdeps-tst-bz21269-fix-Wreturn-type.patch"
      - "0101-posix-Use-support-check.h-facilities-in-tst-truncate.patch"
      - "0018-NEWS-Add-the-2.38.1-bug-list.patch"
      - "0085-Linux-Make-__rseq_size-useful-for-feature-detection-.patch"
      - "0027-tunables-Terminate-if-end-of-input-is-reached-CVE-20.patch"
      - "0008-malloc-Remove-bin-scanning-from-memalign-bug-30723.patch"
      - "0099-ungetc-Fix-uninitialized-read-when-putting-into-unus.patch"
      - "0103-libio-Attempt-wide-backup-free-only-for-non-legacy-c.patch"
      - "0066-iconv-ISO-2022-CN-EXT-fix-out-of-bound-writes-when-w.patch"
      - "0100-ungetc-Fix-backup-buffer-leak-on-program-exit-BZ-278.patch"
      - "0088-resolv-Track-single-request-fallback-via-_res._flags.patch"
      - "0057-AArch64-Add-support-for-MOPS-memcpy-memmove-memset.patch"
      - "0068-login-Check-default-sizes-of-structs-utmp-utmpx-last.patch"
      - "0007-malloc-Enable-merging-of-remainders-in-memalign-bug-.patch"
      - "0042-syslog-Fix-heap-buffer-overflow-in-__vsyslog_interna.patch"
      - "0024-Fix-leak-in-getaddrinfo-introduced-by-the-fix-for-CV.patch"
      - "0105-elf-Change-ldconfig-auxcache-magic-number-bug-32231.patch"
      - "0087-resolv-Do-not-wait-for-non-existing-second-DNS-respo.patch"
      - "9001-move-ldconfig-cache-to-ephemeral-storage.patch"
      - "0055-LoongArch-Correct-__ieee754-_-_scalb-__ieee754-_-_sc.patch"
      - "0076-elf-Also-compile-dl-misc.os-with-rtld-early-cflags.patch"
      - "0017-elf-Move-l_init_called_next-to-old-place-of-l_text_e.patch"
      - "0021-iconv-restore-verbosity-with-unrecognized-encoding-n.patch"
      - "0094-Fix-name-space-violation-in-fortify-wrappers-bug-320.patch"
      - "0032-elf-Fix-wrong-break-removal-from-8ee878592c.patch"
      - "0058-AArch64-Cleanup-ifuncs.patch"
      - "0075-CVE-2024-33601-CVE-2024-33602-nscd-netgroup-Use-two-.patch"
      - "0043-syslog-Fix-heap-buffer-overflow-in-__vsyslog_interna.patch"
      - "0023-manual-jobs.texi-Add-missing-item-EPERM-for-getpgid.patch"
      - "0104-Add-crt1-2.0.o-for-glibc-2.0-compatibility-tests.patch"
      - "0102-nptl-Use-support-check.h-facilities-in-tst-setuid3.patch"
      - "0096-support-Add-FAIL-test-failure-helper.patch"
      - "0081-misc-Add-support-for-Linux-uio.h-RWF_NOAPPEND-flag.patch"
      - "0083-nptl-fix-potential-merge-of-__rseq_-relro-symbols.patch"
      - "0020-getaddrinfo-Fix-use-after-free-in-getcanonname-CVE-2.patch"
      - "0078-resolv-Fix-some-unaligned-accesses-in-resolver-BZ-30.patch"
      - "0086-resolv-Allow-short-error-responses-to-match-any-quer.patch"
      - "0030-Revert-elf-Move-l_init_called_next-to-old-place-of-l.patch"
      - "0060-AArch64-Add-memset_zva64.patch"
      - "0046-S390-Fix-building-with-disable-mutli-arch-BZ-31196.patch"
      - "0005-x86_64-Fix-build-with-disable-multiarch-BZ-30721.patch"
      - "0013-libio-Fix-oversized-__io_vtables.patch"
      - "0038-NEWS-Mention-bug-fixes-for-29039-30694-30709-30721.patch"
      - "HACK-only-build-and-install-localedef.patch"
      - "0054-linux-Use-rseq-area-unconditionally-in-sched_getcpu-.patch"
      - "0036-x86-64-Fix-the-dtv-field-load-for-x32-BZ-31184.patch"
      - "0052-malloc-Use-__get_nprocs-on-arena_get2-BZ-30945.patch"
      - "0015-elf-Always-call-destructors-in-reverse-constructor-o.patch"
      - "0028-Revert-elf-Remove-unused-l_text_end-field-from-struc.patch"
      - "0025-Document-CVE-2023-4806-and-CVE-2023-5156-in-NEWS.patch"
      - "0079-Force-DT_RPATH-for-enable-hardcoded-path-in-tests.patch"
      - "0092-Update-syscall-lists-for-Linux-6.5.patch"
      - "0063-aarch64-fix-check-for-SVE-support-in-assembler.patch"
      - "0064-AArch64-Check-kernel-version-for-SVE-ifuncs.patch"
      - "0029-Revert-elf-Always-call-destructors-in-reverse-constr.patch"
      - "0065-powerpc-Fix-ld.so-address-determination-for-PCREL-mo.patch"
      - "0009-sysdeps-tst-bz21269-fix-test-parameter.patch"
      - "0051-arm-Remove-wrong-ldr-from-_dl_start_user-BZ-31339.patch"
      - "glibc-cs-path.patch"
      - "0034-elf-Fix-TLS-modid-reuse-generation-assignment-BZ-290.patch"
      - "0039-NEWS-Mention-bug-fixes-for-30745-30843.patch"
      - "0072-CVE-2024-33599-nscd-Stack-based-buffer-overflow-in-n.patch"
      - "0067-sparc-Remove-64-bit-check-on-sparc32-wordsize-BZ-275.patch"
      - "0045-x86_64-Optimize-ffsll-function-code-size.patch"
      - "0091-Add-mremap-tests.patch"
      - "0080-i386-Disable-Intel-Xeon-Phi-tests-for-GCC-15-and-abo.patch"
      - "0031-sysdeps-sem_open-Clear-O_CREAT-when-semaphore-file-i.patch"
      - "0004-x86-Fix-incorrect-scope-of-setting-shared_per_thread.patch"
      - "0053-S390-Do-not-clobber-r7-in-clone-BZ-31402.patch"
      - "0106-nptl-initialize-rseq-area-prior-to-registration.patch"
      - "0041-libio-Check-remaining-buffer-size-in-_IO_wdo_write-b.patch"
      - "0098-Make-tst-ungetc-use-libsupport.patch"
      - "0019-CVE-2023-4527-Stack-read-overflow-with-large-TCP-res.patch"
      - "0014-elf-Do-not-run-constructors-for-proxy-objects.patch"
      - "0077-nscd-Use-time_t-for-return-type-of-addgetnetgrentX.patch"
      - "0048-sparc64-Remove-unwind-information-from-signal-return.patch"
      - "0082-s390x-Fix-segfault-in-wcsncmp-BZ-31934.patch"
      - "0070-nptl-Fix-tst-cancel30-on-kernels-without-ppoll_time6.patch"
      - "0071-i386-ulp-update-for-SSE2-disable-multi-arch-configur.patch"
      - "0033-LoongArch-Delete-excessively-allocated-memory.patch"
      - "0050-sparc-Remove-unwind-information-from-signal-return-s.patch"
      - "0049-sparc-Fix-sparc64-memmove-length-comparison-BZ-31266.patch"
      - "0044-syslog-Fix-integer-overflow-in-__vsyslog_internal-CV.patch"
      - "0061-AArch64-Remove-Falkor-memcpy.patch"
      - "0073-CVE-2024-33600-nscd-Do-not-send-missing-not-found-re.patch"
      - "0035-elf-Add-TLS-modid-reuse-test-for-bug-29039.patch"
      - "0062-aarch64-correct-CFI-in-rawmemchr-bug-31113.patch"
      - "0095-x86-Fix-bug-in-strchrnul-evex512-BZ-32078.patch"
      - "0012-io-Fix-record-locking-contants-for-powerpc64-with-__.patch"
      - "0089-linux-Update-the-mremap-C-implementation-BZ-31968.patch"
      - "0074-CVE-2024-33600-nscd-Avoid-null-pointer-crashes-after.patch"
      - "0003-nscd-Do-not-rebuild-getaddrinfo-bug-30709.patch"
      - "0010-sysdeps-tst-bz21269-handle-ENOSYS-skip-appropriately.patch"
      - "0069-login-structs-utmp-utmpx-lastlog-_TIME_BITS-independ.patch"
      - "0022-string-Fix-tester-build-with-fortify-enable-with-gcc.patch"
      - "0037-x86-64-Fix-the-tcb-field-load-for-x32-BZ-31185.patch"
      - "0040-getaddrinfo-translate-ENOMEM-to-EAI_MEMORY-bug-31163.patch"
      - "0084-elf-Make-dl-rseq-symbols-Linux-only.patch"
      - "0097-stdio-common-Add-test-for-vfscanf-with-matches-longe.patch"
      - "0056-Add-HWCAP2_MOPS-from-Linux-6.5-to-AArch64-bits-hwcap.patch"
      - "0107-nptl-initialize-cpu_id_start-prior-to-rseq-registrat.patch"
      - "0002-x86-Fix-for-cache-computation-on-AMD-legacy-cpus.patch"
      - "0026-Propagate-GLIBC_TUNABLES-in-setxid-binaries.patch"
      - "0001-stdlib-Improve-tst-realpath-compatibility-with-sourc.patch"
      - "0006-i686-Fix-build-with-disable-multiarch.patch"
  - package: grep
    version: 3.11
  - package: host-ctr
    version: 0.0
  - package: iproute
    version: 6.9.0
    patches:
      - "0001-skip-libelf-check.patch"
  - package: iptables
    version: 1.8.10
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
    version: 1.28.14
  - package: kubernetes-1.29
    version: 1.29.9
  - package: kubernetes-1.30
    version: 1.30.5
  - package: kubernetes-1.31
    version: 1.31.1
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
    version: 0.191
  - package: libexpat
    version: 2.6.4
  - package: libffi
    version: 3.4.6
  - package: libgcc
    version: 0.0
  - package: libglib
    version: 2.78.4
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
    version: 1.0.9
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
    version: 3.10.0
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
    version: 1.3.5
  - package: liburcu
    version: 0.14.0
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
    version: 0.16.2
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
    version: 1.1.14
  - package: selinux-policy
    version: 0.0
  - package: socat
    version: 1.8.0.1
  - package: soci-snapshotter
    version: 0.7.0
  - package: static-pods
    version: 0.1
  - package: strace
    version: 6.11
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
