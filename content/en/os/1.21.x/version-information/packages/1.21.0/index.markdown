---
title: "1.21.0"
type: "docs"
description: "Package Versions in Bottlerocket Release 1.21.0"
packages:
  - package: acpid
    version: 2.0.34
    patches:
      - "0001-Remove-shell-dependency-by-only-shutting-down.patch"
  - package: amazon-ssm-agent
    version: 3.3.418.0
    patches:
      - "0001-agent-Add-config-to-make-shell-optional.patch"
  - package: aws-iam-authenticator
    version: 0.6.21
  - package: aws-signing-helper
    version: 1.1.1
  - package: bash
    version: 5.2.21
    patches:
      - "bash-5.0-patch-1.patch"
      - "bash-4.4-no-loadable-builtins.patch"
      - "bash-5.0-patch-2.patch"
  - package: binutils
    version: 2.38
  - package: chrony
    version: 4.5
  - package: cni
    version: 1.1.2
  - package: cni-plugins
    version: 1.5.1
  - package: conntrack-tools
    version: 1.4.8
    patches:
      - "0001-disable-RPC-helper.patch"
  - package: containerd
    version: 1.7.20
  - package: coreutils
    version: 9.5
  - package: dbus-broker
    version: 35
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
    version: 1.25.3
  - package: ecr-credential-provider-1.27
    version: 1.27.1
  - package: ecr-credential-provider-1.29
    version: 1.29.0
  - package: ecr-credential-provider-1.30
    version: 1.30.0
  - package: ecs-agent
    version: 1.82.3
    patches:
      - "0005-bottlerocket-change-execcmd-directories-for-Bottlero.patch"
      - "1001-bottlerocket-default-filesystem-locations.patch"
      - "0006-containermetadata-don-t-use-dataDirOnHost-for-metada.patch"
      - "0001-bottlerocket-default-filesystem-locations.patch"
      - "0002-bottlerocket-remove-unsupported-capabilities.patch"
      - "0004-bottlerocket-fix-procfs-path-on-host.patch"
      - "0003-bottlerocket-bind-introspection-to-localhost.patch"
  - package: ecs-gpu-init
    version: 0.0
  - package: ethtool
    version: 6.9
  - package: filesystem
    version: 1.0
  - package: findutils
    version: 4.10.0
  - package: glibc
    version: 2.38
    patches:
      - "0047-sparc-Fix-broken-memset-for-sparc32-BZ-31068.patch"
      - "0059-AArch64-Cleanup-emag-memset.patch"
      - "0016-elf-Remove-unused-l_text_end-field-from-struct-link_.patch"
      - "0011-sysdeps-tst-bz21269-fix-Wreturn-type.patch"
      - "0018-NEWS-Add-the-2.38.1-bug-list.patch"
      - "0027-tunables-Terminate-if-end-of-input-is-reached-CVE-20.patch"
      - "0008-malloc-Remove-bin-scanning-from-memalign-bug-30723.patch"
      - "0066-iconv-ISO-2022-CN-EXT-fix-out-of-bound-writes-when-w.patch"
      - "0057-AArch64-Add-support-for-MOPS-memcpy-memmove-memset.patch"
      - "0068-login-Check-default-sizes-of-structs-utmp-utmpx-last.patch"
      - "0007-malloc-Enable-merging-of-remainders-in-memalign-bug-.patch"
      - "0042-syslog-Fix-heap-buffer-overflow-in-__vsyslog_interna.patch"
      - "0024-Fix-leak-in-getaddrinfo-introduced-by-the-fix-for-CV.patch"
      - "9001-move-ldconfig-cache-to-ephemeral-storage.patch"
      - "0055-LoongArch-Correct-__ieee754-_-_scalb-__ieee754-_-_sc.patch"
      - "0017-elf-Move-l_init_called_next-to-old-place-of-l_text_e.patch"
      - "0021-iconv-restore-verbosity-with-unrecognized-encoding-n.patch"
      - "0032-elf-Fix-wrong-break-removal-from-8ee878592c.patch"
      - "0058-AArch64-Cleanup-ifuncs.patch"
      - "0043-syslog-Fix-heap-buffer-overflow-in-__vsyslog_interna.patch"
      - "0023-manual-jobs.texi-Add-missing-item-EPERM-for-getpgid.patch"
      - "0020-getaddrinfo-Fix-use-after-free-in-getcanonname-CVE-2.patch"
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
      - "0063-aarch64-fix-check-for-SVE-support-in-assembler.patch"
      - "0064-AArch64-Check-kernel-version-for-SVE-ifuncs.patch"
      - "0029-Revert-elf-Always-call-destructors-in-reverse-constr.patch"
      - "0065-powerpc-Fix-ld.so-address-determination-for-PCREL-mo.patch"
      - "0009-sysdeps-tst-bz21269-fix-test-parameter.patch"
      - "0051-arm-Remove-wrong-ldr-from-_dl_start_user-BZ-31339.patch"
      - "glibc-cs-path.patch"
      - "0034-elf-Fix-TLS-modid-reuse-generation-assignment-BZ-290.patch"
      - "0039-NEWS-Mention-bug-fixes-for-30745-30843.patch"
      - "0067-sparc-Remove-64-bit-check-on-sparc32-wordsize-BZ-275.patch"
      - "0045-x86_64-Optimize-ffsll-function-code-size.patch"
      - "0031-sysdeps-sem_open-Clear-O_CREAT-when-semaphore-file-i.patch"
      - "0004-x86-Fix-incorrect-scope-of-setting-shared_per_thread.patch"
      - "0053-S390-Do-not-clobber-r7-in-clone-BZ-31402.patch"
      - "0041-libio-Check-remaining-buffer-size-in-_IO_wdo_write-b.patch"
      - "0019-CVE-2023-4527-Stack-read-overflow-with-large-TCP-res.patch"
      - "0014-elf-Do-not-run-constructors-for-proxy-objects.patch"
      - "0048-sparc64-Remove-unwind-information-from-signal-return.patch"
      - "0070-nptl-Fix-tst-cancel30-on-kernels-without-ppoll_time6.patch"
      - "0033-LoongArch-Delete-excessively-allocated-memory.patch"
      - "0050-sparc-Remove-unwind-information-from-signal-return-s.patch"
      - "0049-sparc-Fix-sparc64-memmove-length-comparison-BZ-31266.patch"
      - "0044-syslog-Fix-integer-overflow-in-__vsyslog_internal-CV.patch"
      - "0061-AArch64-Remove-Falkor-memcpy.patch"
      - "0035-elf-Add-TLS-modid-reuse-test-for-bug-29039.patch"
      - "0062-aarch64-correct-CFI-in-rawmemchr-bug-31113.patch"
      - "0012-io-Fix-record-locking-contants-for-powerpc64-with-__.patch"
      - "0003-nscd-Do-not-rebuild-getaddrinfo-bug-30709.patch"
      - "0010-sysdeps-tst-bz21269-handle-ENOSYS-skip-appropriately.patch"
      - "0069-login-structs-utmp-utmpx-lastlog-_TIME_BITS-independ.patch"
      - "0022-string-Fix-tester-build-with-fortify-enable-with-gcc.patch"
      - "0037-x86-64-Fix-the-tcb-field-load-for-x32-BZ-31185.patch"
      - "0040-getaddrinfo-translate-ENOMEM-to-EAI_MEMORY-bug-31163.patch"
      - "0056-Add-HWCAP2_MOPS-from-Linux-6.5-to-AArch64-bits-hwcap.patch"
      - "0002-x86-Fix-for-cache-computation-on-AMD-legacy-cpus.patch"
      - "0026-Propagate-GLIBC_TUNABLES-in-setxid-binaries.patch"
      - "0001-stdlib-Improve-tst-realpath-compatibility-with-sourc.patch"
      - "0006-i686-Fix-build-with-disable-multiarch.patch"
  - package: grep
    version: 3.9
  - package: grub
    version: 2.06
    patches:
      - "0024-gptprio_test-check-GPT-is-repaired-when-appropriate.patch"
      - "0027-gpt-add-helper-for-picking-a-valid-header.patch"
      - "0008-gpt-add-a-new-generic-GUID-type.patch"
      - "0037-gpt-read-entries-table-at-the-same-time-as-the-heade.patch"
      - "0001-setup-Add-root-device-argument-to-grub-setup.patch"
      - "0023-gptrepair_test-fix-typo-in-cleanup-trap.patch"
      - "0010-gpt-split-out-checksum-recomputation.patch"
      - "0048-add-flag-to-only-search-root-dev.patch"
      - "0005-gpt-consolidate-crc32-computation-code.patch"
      - "0035-gpt-always-revalidate-when-recomputing-checksums.patch"
      - "0012-gpt-switch-partition-names-to-a-16-bit-type.patch"
      - "0004-gpt-record-size-of-of-the-entries-table.patch"
      - "0014-gpt-add-search-by-partition-label-and-uuid-commands.patch"
      - "0017-gpt-add-search-by-disk-uuid-command.patch"
      - "0007-gpt-add-write-function-and-gptrepair-command.patch"
      - "0009-gpt-new-gptprio.next-command-for-selecting-priority-.patch"
      - "0021-gpt-refuse-to-write-to-sector-0.patch"
      - "0013-tests-add-some-partitions-to-the-gpt-unit-test-data.patch"
      - "0016-gpt-minor-cleanup.patch"
      - "0011-gpt-move-gpt-guid-printing-function-to-common-librar.patch"
      - "0046-Revert-sb-Add-fallback-to-EFI-LoadImage-if-shim_lock.patch"
      - "0015-gpt-clean-up-little-endian-crc32-computation.patch"
      - "0036-gpt-include-backup-in-sync-check-in-revalidation.patch"
      - "0040-gpt-write-backup-GPT-first-skip-if-inaccessible.patch"
      - "0019-gpt-add-verbose-debug-logging.patch"
      - "0018-gpt-do-not-use-disk-sizes-GRUB-will-reject-as-invali.patch"
      - "0041-gptprio-Use-Bottlerocket-boot-partition-type-GUID.patch"
      - "0022-gpt-properly-detect-and-repair-invalid-tables.patch"
      - "0032-gpt-check-header-and-entries-status-bits-together.patch"
      - "0006-gpt-add-new-repair-function-to-sync-up-primary-and-b.patch"
      - "0039-gpt-rename-and-update-documentation-for-grub_gpt_upd.patch"
      - "0044-efi-return-virtual-size-of-section-found-by-grub_efi.patch"
      - "0020-gpt-improve-validation-of-GPT-headers.patch"
      - "0026-gpt-prefer-disk-size-from-header-over-firmware.patch"
      - "0043-util-mkimage-avoid-adding-section-table-entry-outsid.patch"
      - "0047-Revert-UBUNTU-Move-verifiers-after-decompressors.patch"
      - "0045-mkimage-pgp-move-single-public-key-into-its-own-sect.patch"
      - "0031-gpt-do-not-use-an-enum-for-status-bit-values.patch"
      - "0033-gpt-be-more-careful-about-relocating-backup-header.patch"
      - "0028-gptrepair-fix-status-checking.patch"
      - "0042-util-mkimage-Bump-EFI-PE-header-size-to-accommodate-.patch"
      - "0029-gpt-use-inline-functions-for-checking-status-bits.patch"
      - "0025-gpt-fix-partition-table-indexing-and-validation.patch"
      - "0003-gpt-rename-misnamed-header-location-fields.patch"
      - "0002-gpt-start-new-GPT-module.patch"
      - "0038-gpt-report-all-revalidation-errors.patch"
      - "0030-gpt-allow-repair-function-to-noop.patch"
      - "0034-gpt-selectively-update-fields-during-repair.patch"
  - package: host-ctr
    version: 0.0
  - package: iproute
    version: 6.4.0
    patches:
      - "0001-skip-libelf-check.patch"
  - package: iptables
    version: 1.8.9
    patches:
      - "1001-extensions-NAT-Fix-for-Werror-format-security.patch"
      - "1002-ip6tables-Fix-checking-existence-of-rule.patch"
  - package: iputils
    version: 20240117
  - package: kernel-5.10
    version: 5.10.220
    patches:
      - "1001-Makefile-add-prepare-target-for-external-modules.patch"
      - "5001-Revert-netfilter-nf_tables-drop-map-element-referenc.patch"
      - "1003-af_unix-increase-default-max_dgram_qlen-to-512.patch"
      - "2000-kbuild-move-module-strip-compression-code-into-scrip.patch"
      - "1002-initramfs-unlink-INITRAMFS_FORCE-from-CMDLINE_-EXTEN.patch"
      - "2001-kbuild-add-support-for-zstd-compressed-modules.patch"
  - package: kernel-5.15
    version: 5.15.162
    patches:
      - "1001-Makefile-add-prepare-target-for-external-modules.patch"
      - "1002-Revert-kbuild-hide-tools-build-targets-from-external.patch"
      - "1004-af_unix-increase-default-max_dgram_qlen-to-512.patch"
      - "1003-initramfs-unlink-INITRAMFS_FORCE-from-CMDLINE_-EXTEN.patch"
  - package: kernel-6.1
    version: 6.1.97
    patches:
      - "1001-Makefile-add-prepare-target-for-external-modules.patch"
      - "1002-Revert-kbuild-hide-tools-build-targets-from-external.patch"
      - "1004-af_unix-increase-default-max_dgram_qlen-to-512.patch"
      - "1003-initramfs-unlink-INITRAMFS_FORCE-from-CMDLINE_-EXTEN.patch"
      - "1005-Revert-Revert-drm-fb_helper-improve-CONFIG_FB-depend.patch"
  - package: kexec-tools
    version: 2.0.28
  - package: keyutils
    version: 1.6.1
  - package: kmod
    version: 31
  - package: kmod-5.10-nvidia
    version: 1.0.0
  - package: kmod-5.15-nvidia
    version: 1.0.0
  - package: kmod-6.1-neuron
    version: 2.16.7.0
    patches:
      - "0001-kbuild-do-not-outline-atomics-for-arm64.patch"
  - package: kmod-6.1-nvidia
    version: 1.0.0
  - package: kubernetes-1.23
    version: 1.23.17
  - package: kubernetes-1.24
    version: 1.24.17
  - package: kubernetes-1.25
    version: 1.25.16
  - package: kubernetes-1.26
    version: 1.26.15
  - package: kubernetes-1.27
    version: 1.27.14
  - package: kubernetes-1.28
    version: 1.28.10
  - package: kubernetes-1.29
    version: 1.29.5
  - package: kubernetes-1.30
    version: 1.30.1
  - package: libacl
    version: 2.3.2
  - package: libattr
    version: 2.5.2
  - package: libaudit
    version: 3.1.4
  - package: libbpf
    version: 1.4.3
  - package: libcap
    version: 2.69
    patches:
      - "9001-dont-test-during-install.patch"
  - package: libdbus
    version: 1.15.6
  - package: libelf
    version: 0.191
  - package: libexpat
    version: 2.6.2
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
  - package: libkcapi
    version: 1.5.0
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
    version: 1.2.6
  - package: libnl
    version: 3.9.0
  - package: libnvidia-container
    version: 1.13.5
    patches:
      - "0004-Use-NVIDIA_PATH-to-look-up-binaries.patch"
      - "0002-use-prefix-from-environment.patch"
      - "0001-use-shared-libtirpc.patch"
      - "0003-keep-debug-symbols.patch"
      - "0005-makefile-avoid-ldconfig-when-cross-compiling.patch"
  - package: libnvme
    version: 1.9
    patches:
      - "0001-linux-Fix-uninitialized-variables.patch"
  - package: libpcre
    version: 10.43
  - package: libseccomp
    version: 2.5.5
  - package: libselinux
    version: 3.6
  - package: libsemanage
    version: 3.6
    patches:
      - "0001-remove-bzip2-dependency.patch"
  - package: libsepol
    version: 3.6
    patches:
      - "0001-libsepol-cil-Check-common-perms-when-verifiying-all.patch"
  - package: libstd-rust
    version: 0.0
  - package: libtirpc
    version: 1.3.4
  - package: liburcu
    version: 0.14.0
  - package: libxcrypt
    version: 4.4.36
  - package: libz
    version: 1.3.1
  - package: libzstd
    version: 1.5.6
  - package: linux-firmware
    version: 20230625
    patches:
      - "0005-linux-firmware-usb-remove-firmware-for-USB-Serial-PC.patch"
      - "0001-linux-firmware-snd-remove-firmware-for-snd-audio-dev.patch"
      - "0007-linux-firmware-Remove-firmware-for-Accelarator-devic.patch"
      - "0002-linux-firmware-video-Remove-firmware-for-video-broad.patch"
      - "0006-linux-firmware-ethernet-Remove-firmware-for-ethernet.patch"
      - "0004-linux-firmware-scsi-Remove-firmware-for-SCSI-devices.patch"
      - "0010-linux-firmware-amd-ucode-Remove-amd-microcode.patch"
      - "0009-linux-firmware-various-Remove-firmware-for-various-d.patch"
      - "0008-linux-firmware-gpu-Remove-firmware-for-GPU-devices.patch"
      - "0003-linux-firmware-bt-wifi-Remove-firmware-for-Bluetooth.patch"
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
  - package: microcode
    version: 0.0
  - package: netdog
    version: 0.1.1
  - package: nvidia-container-toolkit
    version: 1.13.5
  - package: nvidia-k8s-device-plugin
    version: 0.14.4
  - package: nvme-cli
    version: 2.9.1
  - package: oci-add-hooks
    version: 1.0.0
  - package: open-vm-tools
    version: 12.3.5
    patches:
      - "0002-dont-force-cppflags.patch"
      - "0003-Update-shutdown-code-to-work-for-Bottlerocket.patch"
      - "0001-no_cflags_werror.patch"
  - package: os
    version: 0.0
  - package: pigz
    version: 2.8
  - package: policycoreutils
    version: 3.6
  - package: procps
    version: 4.0.4
  - package: readline
    version: 8.2
    patches:
      - "readline-8.2-shlib.patch"
  - package: release
    version: 0.0
  - package: runc
    version: 1.1.13
  - package: selinux-policy
    version: 0.0
  - package: shim
    version: 15.8
  - package: socat
    version: 1.8.0.0
    patches:
      - "0001-xioopts-conditionally-compile-applyopts_termios_valu.patch"
  - package: soci-snapshotter
    version: 0.6.1
  - package: static-pods
    version: 0.1
  - package: strace
    version: 6.9
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
    version: 6.8.0
---

{{< packages-table >}}
