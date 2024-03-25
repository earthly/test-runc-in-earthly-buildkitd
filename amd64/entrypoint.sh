#!/bin/sh
set -e

if [ -f "/sys/fs/cgroup/cgroup.controllers" ]; then
    echo "detected cgroups v2; buildkit/entrypoint.sh running under pid=$$ with controllers \"$(cat /sys/fs/cgroup/cgroup.controllers)\" in group $(cat /proc/self/cgroup)"
    test "$(cat /sys/fs/cgroup/cgroup.type)" = "domain" || (echo >&2 "WARNING: invalid root cgroup type: $(cat /sys/fs/cgroup/cgroup.type)")
    mkdir /sys/fs/cgroup/my-test-group
    echo "moving $$ to my-test-group cgroup"
    echo $$ > /sys/fs/cgroup/my-test-group/cgroup.procs
else
    echo "/sys/fs/cgroup/cgroup.controllers does not exist"
    echo "I don't know what to do here....."
fi

cd /test-runc
echo "running runc"
/usr/bin/buildkit-runc run test-container
echo "finished"
