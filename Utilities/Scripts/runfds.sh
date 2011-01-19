#!/bin/bash -f
scratchdir=$SVNROOT/Utilities/Scripts/tmp
dir=$1
infile=$2

fulldir=$BASEDIR/$dir
in=$infile.fds
outerr=$fulldir/$infile.err
outlog=$fulldir/$infile.log
stopfile=$infile.stop

scriptfile=$scratchdir/script.$$
if ! [ -e $FDS ];  then
  echo "The file $FDS does not exit. Run aborted"
  exit
fi
if ! [ -d $fulldir ]; then
  echo "The directory $fulldir does not exit. Run aborted."
  exit
fi
if ! [ -e $fulldir/$in ]; then
  echo "The fds input file, $fulldir/$in, does not exit. Run aborted."
  exit
fi
if [ $STOPFDS ]; then
 echo "stopping case: $infile"
 touch $fulldir/$stopfile
 exit
fi
if [ -e $fulldir/$stopfile ]; then
 rm $fulldir/$stopfile
fi
cat << EOF > $scriptfile
#!/bin/bash -f
#PBS -N $infile
#PBS -e $outerr
#PBS -o $outlog
cd $fulldir
$FDS $in 
EOF
chmod +x $scriptfile
echo Running $in 
qsub $scriptfile
rm $scriptfile
