Corebuild based on RHEL 7.2
===========================

This is a RHEL 7.2 based corebuild, crunchtools will use this image as a base
for all its other layers.

Build
-----

Building this Dockerfile requires a Red Hat Enterprise Linux 7 host
system with Software Collections entitlements available.
```
docker build --rm --tag corebuild .
```

Run
---
```
docker run --tty --interactive corebuild /bin/bash
```

Test
----
Notice the message of the day, something a core build team may like to add to all container images

> This is a Crunchtools Lab user space for authorized use only. This Crunchtools user space and underlying computer systems may be monitored for all lawful purposes, including to ensure that their use is authorized, for management of the system, to facilitate against unauthorized access, and to verify security procedures, survivability, and operational security. Using this system constitutes consent to monitoring. All information, including personal information, placed on or sent over this system may be obtained during monitoring. Unauthorized use could result in criminal prosecution.

```
