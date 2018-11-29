# Build script
wget https://raw.githubusercontent.com/Hortenkommune/Thinstation/master/build.conf -O gitbuild.conf
wget https://raw.githubusercontent.com/Hortenkommune/Thinstation/master/thinstation.conf.buildtime -O thinstation.conf.buildtime
cat gitbuild.conf passwd.conf > build.conf.example
/bin/bash build