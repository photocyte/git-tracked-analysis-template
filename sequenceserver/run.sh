#docker pull wurmlab/sequenceserver                                                                               
#docker run -v "$(pwd):/db" --rm -it -p 4567:4567 wurmlab/sequenceserver sequenceserver -d /db
docker run -v "$(pwd):/db" --rm -it -p 4567:4567 wurmlab/sequenceserver sequenceserver -d /db -m

