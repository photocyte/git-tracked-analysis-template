## Docker format
#docker pull wurmlab/sequenceserver                                                                               
#docker run -v "$(pwd):/db" --rm -it -p 4567:4567 wurmlab/sequenceserver sequenceserver -d /db
#docker run -v "$(pwd):/db" --rm -it -p 4567:4567 wurmlab/sequenceserver sequenceserver -d /db -m

## Singularity aka Apptainer format
#singularity pull docker://wurmlab/sequenceserver
#mkdir -p ~/containers/
#mv sequenceserver_latest.sif ~/containers/
#singularity exec --pwd /sequenceserver --bind "$(pwd)":/db ~/containers/sequenceserver_latest.sif bundle exec sequenceserver -d /db -m
singularity exec --pwd /sequenceserver --bind "$(pwd)":/db ~/containers/sequenceserver_latest.sif bundle exec sequenceserver -d /db
