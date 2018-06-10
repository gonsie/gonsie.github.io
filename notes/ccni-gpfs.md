---
title: CCNI GPFS
category: notes
layout: old_default
---

# Best Practices for Using the [CCNI File System] [ccni_gpfs]

*AKA: WHERE THE HECK DID MY FILES GO?!*

---

### **ALERT**: Some directories are frequently purged! Use `/data` at your own risk!

---

The new file system at the CCNI was very carefully designed.
Be sure to read [this page] [ccni_gpfs] about how it was set up.
The following reiterates what was said on the CCNI Wiki, then lists some [best practices](#best_practices) you can use to make your life easier.

## The File System

The GPFS (IBM's General Parallel File System) implemented at the CCNI is split into two portions: large and small. The large side uses 4 MB blocks, while the small side uses 128 KB blocks.

### Heriarchy

	- /gpfs
		- /sb
			- /home
			- /data
		- /lb
			- /data
			- /provisioned

Within each of these folders is a `PROJ` project folder for your group, consisting of the following sub-directories:

	- /PROJ
		- /shared
		- /PROJuser

This means your personal ~ home directory is at `/gpsf/sb/home/PROJ/PROJuser/`.

### Home

These directories are shared by the group, and replicated to ensure data reliablity.
This portion of the file system has an effective quota of 5 GB per project.

### Data

**Please Note**: These directiories are for *temporary* storage. Files not touched in at least 14 days will be purged frequetly.

These directories are intended to be staging areas for performing computation.
They exist on both the small and large block partitions of the system, for flexiblity and optimum usage.
Again they are shared by the group and have a much larger quota.

### Provisioned

This directory exsits for long-term storage of unimportant data.
It is not replicated or backed up, but your data should persist.
This only exists on the large portion of the file system and has a quota of 5 GB per procjet.


## <a id='best_practices'></a> Best Practices

First and foremost, **remove all of your experimental results and code from `/data` now**.

Depending on your project, you will have several files to organize. The following uses a [ROSS][ross] project (part of the RSNT CCNI group) for reference. It also assumes that some type of version control is being used.

### Source
`/gpfs/lb/provisioned/RSNT/RSNTgons/rossnet/`

This directory holds the sorce code for all of my experiments.
The rossnet folder is managed through version control.
This ensures that if cataclysmic event occurs and the CCNI loses this data, I have made sure a recent verion is backed up somewhere else.

### Build
`/gpfs/lb/data/RSNT/RSNTgons/rossnet-build/`

This directory is where my source code is built.
The executable lives here, and not much else.
If I go on vacation for two weeks, I expect everything in these directories to disappear.

### Test
`/gpfs/sb/home/RSNT/RSNTgons/ROSS-tests/`

This is within my home directory.
All of my experimental results and run scprits are kept here.
This is the core of important files, that, if destroyed, would delay my PhD by years.



### Sample Scripts

`build.sh`: Interatively build the project and perform a run:

	#!/bin/bash

	# Parameter checking / help
	if [ $# -eq 1 ]; then
	    if [ "$1" == "-h" ]; then
	        echo "Usage: `basename $0` [order]"
	        exit 65
	    fi
	fi

	# Check build environment
	if [ "$ARCH" = "" ]; then
	    module load xl
	    export ARCH=bgq
	    export CC=mpixlc
	fi

	# Configure Build Directory
	if [ $# -eq 1 ]; then
	    ORDER=$1
	else
	    ORDER=`squeue | wc -l`
	fi

	BUILD=/gpfs/lb/data/RSNT/RSNTgons

	if [ ! -e $BUILD/rossnet-build-$ORDER/ ]; then
	    mkdir $BUILD/rossnet-build-$ORDER
	fi

	cd $BUILD/rossnet-build-$ORDER/

	# gather run settings
	echo -n "NP = "
	read NP

	echo -n "X = "
	read X

	echo -n "Y = "
	read Y

	echo "cmake -Dnp=$NP -Dx=$X -Dy=$Y rossnet/trunk"

	# cmake
	cmake28 -Dnp=$NP -Dx=$X -Dy=$Y -DROSS_BUILD_MODELS=ON /gpfs/lb/provisioned/RSNT/RSNTgons/rossnet/trunk

	# make
	cd ross/models/gates/
	make -j 12

	# configure the run
	cd /gpfs/sb/home/RSNT/RSNTgons/ROSS/tests

	echo -n "nodes = "
	read NODES

	echo -n "synch = "
	read SYNCH

	cat srun.sh.in | sed s/"@NP@"/$NP/g | sed s/"@BUILD@"/$BUILD/g | sed s/"@ORDER@"/$ORDER/g | sed s/"@SYNCH@"/$SYNCH/g | sed s/"@NODES@"/$NODES/g > $BUILD/rossnet-build-$ORDER/srun-$ORDER.sh

	chmod u+x $BUILD/rossnet-build-$ORDER/srun-$ORDER.sh

	# get the allocation and run
	salloc --nodes $NODES --bell $BUILD/rossnet-build-$ORDER/srun-$ORDER.sh

`srun.sh.in`: run script template:

	#!/bin/bash

	echo "testing: $SLURM_JOB_ID"

	srun --ntasks @NP@ @BUILD@/rossnet-build-@ORDER@/ross/models/gates/gates --batch=2 --gvt-interval=1024 --source_interval=2 --sink_interval=100 --synch=@SYNCH@ --end=3000 > srun-$SLURM_JOB_bID-n@NODES@.@NP@-s@SYNC@.out

[ccni_gpfs]: https://ccni.rpi.edu/wiki/index.php/File_System "CCNI File System"
[ross]: http://odin.cs.rpi.edu "Rensselaer Optimistic Simulation System"
