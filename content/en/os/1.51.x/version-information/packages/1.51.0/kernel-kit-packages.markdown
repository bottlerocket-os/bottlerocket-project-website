---
title: "Kernel Kit packages 4.5.1"
type: "docs"
description: "Kernel Kit Package Versions in Bottlerocket Release 1.51.0"
packages:
  - package: grub
    version: 2.06
    patches:
      - "0001-setup-Add-root-device-argument-to-grub-setup.patch"
      - "0002-gpt-start-new-GPT-module.patch"
      - "0003-gpt-rename-misnamed-header-location-fields.patch"
      - "0004-gpt-record-size-of-of-the-entries-table.patch"
      - "0005-gpt-consolidate-crc32-computation-code.patch"
      - "0006-gpt-add-new-repair-function-to-sync-up-primary-and-b.patch"
      - "0007-gpt-add-write-function-and-gptrepair-command.patch"
      - "0008-gpt-add-a-new-generic-GUID-type.patch"
      - "0009-gpt-new-gptprio.next-command-for-selecting-priority-.patch"
      - "0010-gpt-split-out-checksum-recomputation.patch"
      - "0011-gpt-move-gpt-guid-printing-function-to-common-librar.patch"
      - "0012-gpt-switch-partition-names-to-a-16-bit-type.patch"
      - "0013-tests-add-some-partitions-to-the-gpt-unit-test-data.patch"
      - "0014-gpt-add-search-by-partition-label-and-uuid-commands.patch"
      - "0015-gpt-clean-up-little-endian-crc32-computation.patch"
      - "0016-gpt-minor-cleanup.patch"
      - "0017-gpt-add-search-by-disk-uuid-command.patch"
      - "0018-gpt-do-not-use-disk-sizes-GRUB-will-reject-as-invali.patch"
      - "0019-gpt-add-verbose-debug-logging.patch"
      - "0020-gpt-improve-validation-of-GPT-headers.patch"
      - "0021-gpt-refuse-to-write-to-sector-0.patch"
      - "0022-gpt-properly-detect-and-repair-invalid-tables.patch"
      - "0023-gptrepair_test-fix-typo-in-cleanup-trap.patch"
      - "0024-gptprio_test-check-GPT-is-repaired-when-appropriate.patch"
      - "0025-gpt-fix-partition-table-indexing-and-validation.patch"
      - "0026-gpt-prefer-disk-size-from-header-over-firmware.patch"
      - "0027-gpt-add-helper-for-picking-a-valid-header.patch"
      - "0028-gptrepair-fix-status-checking.patch"
      - "0029-gpt-use-inline-functions-for-checking-status-bits.patch"
      - "0030-gpt-allow-repair-function-to-noop.patch"
      - "0031-gpt-do-not-use-an-enum-for-status-bit-values.patch"
      - "0032-gpt-check-header-and-entries-status-bits-together.patch"
      - "0033-gpt-be-more-careful-about-relocating-backup-header.patch"
      - "0034-gpt-selectively-update-fields-during-repair.patch"
      - "0035-gpt-always-revalidate-when-recomputing-checksums.patch"
      - "0036-gpt-include-backup-in-sync-check-in-revalidation.patch"
      - "0037-gpt-read-entries-table-at-the-same-time-as-the-heade.patch"
      - "0038-gpt-report-all-revalidation-errors.patch"
      - "0039-gpt-rename-and-update-documentation-for-grub_gpt_upd.patch"
      - "0040-gpt-write-backup-GPT-first-skip-if-inaccessible.patch"
      - "0041-gptprio-Use-Bottlerocket-boot-partition-type-GUID.patch"
      - "0042-util-mkimage-Bump-EFI-PE-header-size-to-accommodate-.patch"
      - "0043-util-mkimage-avoid-adding-section-table-entry-outsid.patch"
      - "0044-efi-return-virtual-size-of-section-found-by-grub_efi.patch"
      - "0045-mkimage-pgp-move-single-public-key-into-its-own-sect.patch"
      - "0046-Revert-sb-Add-fallback-to-EFI-LoadImage-if-shim_lock.patch"
      - "0047-Revert-UBUNTU-Move-verifiers-after-decompressors.patch"
  - package: kernel-6.1
    version: 6.1.158
    patches:
      - "1002-Revert-kbuild-hide-tools-build-targets-from-external.patch"
      - "1003-initramfs-unlink-INITRAMFS_FORCE-from-CMDLINE_-EXTEN.patch"
      - "1004-af_unix-increase-default-max_dgram_qlen-to-512.patch"
      - "1005-Revert-Revert-drm-fb_helper-improve-CONFIG_FB-depend.patch"
      - "1006-strscpy-write-destination-buffer-only-once.patch"
      - "1007-efi-libstub-don-t-measure-kernel-command-line-into-P.patch"
      - "1001-Makefile-add-prepare-target-for-external-modules.patch"
  - package: kernel-6.12
    version: 6.12.55
    patches:
      - "1002-Revert-kbuild-hide-tools-build-targets-from-external.patch"
      - "1003-initramfs-unlink-INITRAMFS_FORCE-from-CMDLINE_-EXTEN.patch"
      - "1004-af_unix-increase-default-max_dgram_qlen-to-512.patch"
      - "1005-Lustre-cast-unsigned-long-to-pointer.patch"
      - "1006-Select-prerequisites-for-gpu-drivers.patch"
      - "1007-strscpy-write-destination-buffer-only-once.patch"
      - "1008-efi-libstub-don-t-measure-kernel-command-line-into-P.patch"
      - "1001-Makefile-add-prepare-target-for-external-modules.patch"
      - "2000-config-efa.cmake-execute-config-tests-in-serial.patch"
  - package: kmod-6.12-nvidia-r570
    version: 570.195.03
    patches:
      - "0001-makefile-allow-to-use-any-kernel-arch.patch"
  - package: kmod-6.12-nvidia-r580
    version: 580.95.05
    patches:
      - "0001-makefile-allow-to-use-any-kernel-arch.patch"
  - package: kmod-6.1-nvidia-r570
    version: 570.195.03
    patches:
      - "0001-makefile-allow-to-use-any-kernel-arch.patch"
  - package: libkcapi
    version: 1.4.0
  - package: linux-firmware
    version: 20230625
    patches:
      - "0001-linux-firmware-snd-remove-firmware-for-snd-audio-dev.patch"
      - "0002-linux-firmware-video-Remove-firmware-for-video-broad.patch"
      - "0003-linux-firmware-bt-wifi-Remove-firmware-for-Bluetooth.patch"
      - "0004-linux-firmware-scsi-Remove-firmware-for-SCSI-devices.patch"
      - "0005-linux-firmware-usb-remove-firmware-for-USB-Serial-PC.patch"
      - "0006-linux-firmware-ethernet-Remove-firmware-for-ethernet.patch"
      - "0007-linux-firmware-Remove-firmware-for-Accelarator-devic.patch"
      - "0008-linux-firmware-gpu-Remove-firmware-for-GPU-devices.patch"
      - "0009-linux-firmware-various-Remove-firmware-for-various-d.patch"
      - "0010-linux-firmware-amd-ucode-Remove-amd-microcode.patch"
  - package: microcode
    version: 0.0
  - package: nvidia-migmanager
    version: 0.1
  - package: nvlsm
    version: 2025.06.6
  - package: shim
    version: 16.0
---

{{< packages-table >}}
