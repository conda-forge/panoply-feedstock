#!/usr/bin/env bash

set -exuo pipefail

mkdir -p $PREFIX/lib/java/PanoplyJ
mkdir -p $PREFIX/bin
cp -r $SRC_DIR/* $PREFIX/lib/java/PanoplyJ/

cat <<EOF >${PREFIX}/bin/panoply
#!/usr/bin/env bash
java -Xms512m -Xmx4g \$JAVA_OPTS -cp $PREFIX/lib/java/PanoplyJ/jars/Panoply.jar gov.nasa.giss.panoply.Panoply "\$@"
EOF
chmod +x ${PREFIX}/bin/panoply

# netcdf-java tools included with Panoply bundle

#cat <<EOF >${PREFIX}/bin/pnj-toolsui
##!/usr/bin/env bash
#java -Xms512m -Xmx4g \$JAVA_OPTS -cp $PREFIX/lib/java/PanoplyJ/jars/Panoply.jar ucar.nc2.ui.ToolsUI "\$@"
#EOF
#chmod +x ${PREFIX}/bin/pnj-toolsui

cat <<EOF >${PREFIX}/bin/pnj-nccopy
#!/usr/bin/env bash
java -Xms512m -Xmx4g \$JAVA_OPTS -cp $PREFIX/lib/java/PanoplyJ/jars/Panoply.jar ucar.nc2.write.Nccopy "\$@"
EOF
chmod +x ${PREFIX}/bin/pnj-nccopy

cat <<EOF >${PREFIX}/bin/pnj-ncdump
#!/usr/bin/env bash
java -Xms512m -Xmx4g \$JAVA_OPTS -cp $PREFIX/lib/java/PanoplyJ/jars/Panoply.jar ucar.nc2.NCdumpW "\$@"
EOF
chmod +x ${PREFIX}/bin/pnj-ncdump

cat <<EOF >${PREFIX}/bin/pnj-nccompare
#!/usr/bin/env bash
java -Xms512m -Xmx4g \$JAVA_OPTS -cp $PREFIX/lib/java/PanoplyJ/jars/Panoply.jar ucar.nc2.util.CompareNetcdf2 "\$@"
EOF
chmod +x ${PREFIX}/bin/pnj-nccompare

cat <<EOF >${PREFIX}/bin/pnj-bufrspliter
#!/usr/bin/env bash
java -Xms512m -Xmx4g \$JAVA_OPTS -cp $PREFIX/lib/java/PanoplyJ/jars/Panoply.jar ucar.nc2.iosp.bufr.writer.BufrSplitter "\$@"
EOF
chmod +x ${PREFIX}/bin/pnj-bufrspliter

cat <<EOF >${PREFIX}/bin/pnj-cfpointwriter
#!/usr/bin/env bash
java -Xms512m -Xmx4g \$JAVA_OPTS -cp $PREFIX/lib/java/PanoplyJ/jars/Panoply.jar ucar.nc2.ft.point.writer.CFPointWriter "\$@"
EOF
chmod +x ${PREFIX}/bin/pnj-cfpointwriter

cat <<EOF >${PREFIX}/bin/pnj-gribcdmindex
#!/usr/bin/env bash
java -Xms512m -Xmx4g \$JAVA_OPTS -cp $PREFIX/lib/java/PanoplyJ/jars/Panoply.jar ucar.nc2.grib.collection.GribCdmIndex "\$@"
EOF
chmod +x ${PREFIX}/bin/pnj-gribcdmindex

cat <<EOF >${PREFIX}/bin/pnj-featurescan
#!/usr/bin/env bash
java -Xms512m -Xmx4g \$JAVA_OPTS -cp $PREFIX/lib/java/PanoplyJ/jars/Panoply.jar ucar.nc2.ft2.scan.FeatureScan "\$@"
EOF
chmod +x ${PREFIX}/bin/pnj-featurescan

cat <<EOF >${PREFIX}/bin/pnj-catalogcrawler
#!/usr/bin/env bash
java -Xms512m -Xmx4g \$JAVA_OPTS -cp $PREFIX/lib/java/PanoplyJ/jars/Panoply.jar thredds.client.catalog.tools.CatalogCrawler "\$@"
EOF
chmod +x ${PREFIX}/bin/pnj-catalogcrawler