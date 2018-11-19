# Build script
wget https://raw.githubusercontent.com/Hortenkommune/Thinstation/master/build.conf -O gitbuild.conf
cat gitbuild.conf passwd.conf > build.conf.example
/bin/bash build