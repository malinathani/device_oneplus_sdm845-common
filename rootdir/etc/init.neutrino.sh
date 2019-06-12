#!/system/bin/sh 

# Setup readahead
find /sys/devices -name read_ahead_kb | while read node; do echo 64 > $node; done

# Configure virtual memory
echo 60 > /proc/sys/vm/swappiness
echo 7 > /proc/sys/vm/dirty_ratio
echo 3 > /proc/sys/vm/dirty_background_ratio
echo 60 > /proc/sys/vm/vfs_cache_pressure

# Reset zRAM/swapspace
swapoff /data/vendor/swap/swapfile
swapoff /dev/block/zram0
echo 1 > /sys/block/zram0/reset
echo 1073741824 > /sys/block/zram0/disksize
echo 8 > /sys/block/zram0/max_comp_streams
mkswap /dev/block/zram0
swapon /dev/block/zram0
