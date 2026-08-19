# !/bin/bash

BASEDIR=$(dirname "$0")

VMNAME=nixos-aarch64
ISO="${BASEDIR}/result/iso/nixos-minimal-26.05.20260627.714a5f8-aarch64-linux.iso"
NVRAM="${BASEDIR}/vars-pflash.raw"
CORES=6
MEMORY=4096
KEYBOARD="en"

cleanup() {
    kill "$QEMU_PID" || true
}

trap cleanup EXIT

run_vm() {
    OVMF_FD=$(nix-build '<nixpkgs>' --no-out-link -A OVMF.fd --system aarch64-linux)
    test -f "${NVRAM}" || {
        cp "${OVMF_FD}/AAVMF/vars-template-pflash.raw" "${NVRAM}"
        chmod u+w "${NVRAM}"
    }

    qemu-system-aarch64 \
        -name $VMNAME,process=$VMNAME \
        -machine virt,gic-version=max \
        --accel tcg,thread=multi \
        -cpu max \
        -smp $CORES \
        -m $MEMORY \
        -k $KEYBOARD \
        -serial stdio \
        -drive if=pflash,format=raw,file="${OVMF_FD}/AAVMF//QEMU_EFI-pflash.raw",readonly=on \
        -drive if=pflash,format=raw,file="${NVRAM}" \
        -device virtio-scsi-pci \
        -device virtio-gpu-pci \
        -device virtio-net-pci,netdev=wan \
        -netdev user,id=wan \
        -device virtio-rng-pci,rng=rng0 \
        -object rng-random,filename=/dev/urandom,id=rng0 \
        -device virtio-serial-pci \
        -drive file="${ISO}",media=cdrom \
        -boot d

    QEMU_PID=$!
}

run_vm
