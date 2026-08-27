#!/bin/bash
# ==============================================================================
# VM DISK CONFIGURATION SCRIPT
# ==============================================================================
# Target sizes :
#   / (root)  → 22GB
#   /home     → 3GB
#   /dev/shm  → 64GB
#   /data     → ext4 mounted
# ==============================================================================

set -uo pipefail

echo "=== VM Disk Configuration ==="

# ------------------------------------------------------------------------------
# Target Sizes
# ------------------------------------------------------------------------------
ROOT_TARGET="22G"
HOME_TARGET="3G"
SHM_TARGET="64G"

# ------------------------------------------------------------------------------
# Helper: Resize filesystem based on type
# ------------------------------------------------------------------------------
resize_fs() {
    local mount_point="$1"
    local fs_type=$(df -T "$mount_point" | awk 'NR==2 {print $2}')
    if [ "$fs_type" = "xfs" ]; then
        xfs_growfs "$mount_point" 2>/dev/null || true
    else
        resize2fs "$mount_point" 2>/dev/null || true
    fi
}

# ==============================================================================
# SECTION 1: Set / (root) to 22GB
# ==============================================================================
echo "=== Configuring / (root) → $ROOT_TARGET ==="
if lvextend -L $ROOT_TARGET /dev/mapper/rootvg-rootlv 2>/dev/null; then
    resize_fs "/"
    echo "  Extended to $ROOT_TARGET"
else
    echo "  Already at or above $ROOT_TARGET"
fi
chmod 1777 /tmp

# ==============================================================================
# SECTION 2: Set /home to 3GB
# ==============================================================================
echo "=== Configuring /home → $HOME_TARGET ==="
if lvextend -L $HOME_TARGET /dev/mapper/rootvg-homelv 2>/dev/null; then
    resize_fs "/home"
    echo "  Extended to $HOME_TARGET"
else
    echo "  Already at or above $HOME_TARGET"
fi

# ==============================================================================
# SECTION 3: Set /dev/shm to 64GB
# ==============================================================================
echo "=== Configuring /dev/shm → $SHM_TARGET ==="
if mount | grep -q "on /dev/shm type tmpfs"; then
    mount -o remount,size=$SHM_TARGET /dev/shm
else
    mount -t tmpfs -o size=$SHM_TARGET tmpfs /dev/shm
fi
chmod 1777 /dev/shm
echo "  Done"

# ==============================================================================
# SECTION 4: Mount /data disk
# ==============================================================================
echo "=== Configuring /data ==="
DISK="/dev/disk/azure/scsi1/lun0"
MOUNT_POINT="/data"

if mountpoint -q "$MOUNT_POINT" 2>/dev/null; then
    echo "  Already mounted"
elif [ ! -b "$DISK" ]; then
    echo "  Disk not found"
else
    mkdir -p "$MOUNT_POINT"

    if [ ! -b "${DISK}-part1" ]; then
        parted --script "$DISK" mklabel gpt
        parted --script -a optimal "$DISK" mkpart primary ext4 0% 100%
        sleep 2
    fi

    PART="${DISK}-part1"

    if ! blkid "$PART" 2>/dev/null | grep -q 'TYPE="ext4"'; then
        mkfs.ext4 -F "$PART"
    fi
    
    UUID=$(blkid -s UUID -o value "$PART")
    sed -i "\|[[:space:]]${MOUNT_POINT}[[:space:]]|d" /etc/fstab 
    if [ -n "$UUID" ]; then
        echo "UUID=$UUID $MOUNT_POINT ext4 defaults,nofail 0 2" >> /etc/fstab
    fi

    mount -a
    echo "  Mounted"
fi

# ==============================================================================
# SECTION 5: User config
# ==============================================================================
echo "=== Configuring adcadmin ==="
if id adcadmin &>/dev/null && ! id -nG adcadmin | grep -qw wheel; then
    usermod -aG wheel adcadmin
    echo "  Added to wheel"
else
    echo "  Already configured"
fi

# ==============================================================================
# SECTION 6: /tmp config
# ==============================================================================
echo "=== Configuring /tmp ==="
if grep -q '/tmp.*noexec' /etc/fstab 2>/dev/null; then
    sed -i 's/noexec,//g; s/,noexec//g' /etc/fstab
    systemctl daemon-reload
    mount -o remount /tmp 2>/dev/null || true
    echo "  Removed noexec"
else
    echo "  Already configured"
fi
chmod 1777 /tmp

# ==============================================================================
echo ""
echo "=== DONE ==="
df -Th / /home /dev/shm 2>/dev/null
mountpoint -q "$MOUNT_POINT" 2>/dev/null && df -Th "$MOUNT_POINT"