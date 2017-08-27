#!/bin/bash

# Création des 3 machines virtuelles
ionice -c 3 cp ../vm0-debian-testing-i386-base.qed target.qed
ionice -c 3 cp ../vm0-debian-testing-i386-base.qed initiator1.qed
ionice -c 3 cp ../vm0-debian-testing-i386-base.qed initiator2.qed

# Création des 3 volumes de stockage
dd if=/dev/null of=target.disk bs=1 seek=72G
dd if=/dev/null of=initiator1.disk bs=1 seek=32G
dd if=/dev/null of=initiator2.disk bs=1 seek=32G
