plasmapkg -t dataengine -r BCacheBridge
plasmapkg -t plasmoid -r bcachestats
cd ./bcache-engine/
zip -q -r contents.zip ./*
plasmapkg -t dataengine -i ./contents.zip
rm ./contents.zip
cd ../ 
cd ./bcachestats/
zip -q -r contents.zip ./*
plasmapkg -t plasmoid -i ./contents.zip
rm ./contents.zip
