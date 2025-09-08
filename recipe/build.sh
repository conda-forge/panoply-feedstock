#!/usr/bin/env bash

set -exuo pipefail

mkdir -p $PREFIX/lib/java/PanoplyJ
mkdir -p $PREFIX/bin
cp -r $SRC_DIR/* $PREFIX/lib/java/PanoplyJ/

cat <<EOF >${PREFIX}/bin/panoply
#!/usr/bin/env bash
# Panoply Data Viewer
#
# Usage:
#   panoply [-log (TRACE|DEBUG|INFO|WARN|ERROR)] [-multi] [-path DATAPATH] [--] [DATAFILENAME [DATAFILENAME ...]]
#   panoply -script SCRIPTFILE [-log (TRACE|DEBUG|INFO|WARN|ERROR)] [-gui | -server] [-grib (strict|lenient)] [-enginelist] [-engine ENGINE] [-enginepath ENGINEPATH] [--]

java -Xms512m -Xmx4g \$JAVA_OPTS -cp $PREFIX/lib/java/PanoplyJ/jars/Panoply.jar gov.nasa.giss.panoply.Panoply "\$@"
EOF
chmod +x ${PREFIX}/bin/panoply

cat <<EOF >${PREFIX}/bin/panoplycl
#!/usr/bin/env bash
# Panoply Data Viewer (Command Line Interpreter)
#
# Usage:
#   panoplycl [-script SCRIPTFILE] [-log (TRACE|DEBUG|INFO|WARN|ERROR)] [-gui | -server] [-grib (strict|lenient)] [-enginelist] [-engine ENGINE] [-enginepath ENGINEPATH] [--]

java -Xms512m -Xmx4g \$JAVA_OPTS -cp $PREFIX/lib/java/PanoplyJ/jars/Panoply.jar gov.nasa.giss.panoply.PanoplyCL "\$@"
EOF
chmod +x ${PREFIX}/bin/panoplycl
# netcdf-java tools included with Panoply bundle

#cat <<EOF >${PREFIX}/bin/ncj-panoply-toolsui
##!/usr/bin/env bash
#java -Xms512m -Xmx4g \$JAVA_OPTS -cp $PREFIX/lib/java/PanoplyJ/jars/Panoply.jar ucar.nc2.ui.ToolsUI "\$@"
#EOF
#chmod +x ${PREFIX}/bin/ncj-panoply-toolsui

cat <<EOF >${PREFIX}/bin/ncj-panoply-nccopy
#!/usr/bin/env bash
java -Xms512m -Xmx4g \$JAVA_OPTS -cp $PREFIX/lib/java/PanoplyJ/jars/Panoply.jar ucar.nc2.write.Nccopy "\$@"
EOF
chmod +x ${PREFIX}/bin/ncj-panoply-nccopy

cat <<EOF >${PREFIX}/bin/ncj-panoply-ncdump
#!/usr/bin/env bash
java -Xms512m -Xmx4g \$JAVA_OPTS -cp $PREFIX/lib/java/PanoplyJ/jars/Panoply.jar ucar.nc2.NCdumpW "\$@"
EOF
chmod +x ${PREFIX}/bin/ncj-panoply-ncdump

cat <<EOF >${PREFIX}/bin/ncj-panoply-nccompare
#!/usr/bin/env bash
java -Xms512m -Xmx4g \$JAVA_OPTS -cp $PREFIX/lib/java/PanoplyJ/jars/Panoply.jar ucar.nc2.util.CompareNetcdf2 "\$@"
EOF
chmod +x ${PREFIX}/bin/ncj-panoply-nccompare

cat <<EOF >${PREFIX}/bin/ncj-panoply-bufrsplitter
#!/usr/bin/env bash
java -Xms512m -Xmx4g \$JAVA_OPTS -cp $PREFIX/lib/java/PanoplyJ/jars/Panoply.jar ucar.nc2.iosp.bufr.writer.BufrSplitter "\$@"
EOF
chmod +x ${PREFIX}/bin/ncj-panoply-bufrsplitter

cat <<EOF >${PREFIX}/bin/ncj-panoply-cfpointwriter
#!/usr/bin/env bash
java -Xms512m -Xmx4g \$JAVA_OPTS -cp $PREFIX/lib/java/PanoplyJ/jars/Panoply.jar ucar.nc2.ft.point.writer.CFPointWriter "\$@"
EOF
chmod +x ${PREFIX}/bin/ncj-panoply-cfpointwriter

cat <<EOF >${PREFIX}/bin/ncj-panoply-gribcdmindex
#!/usr/bin/env bash
java -Xms512m -Xmx4g \$JAVA_OPTS -cp $PREFIX/lib/java/PanoplyJ/jars/Panoply.jar ucar.nc2.grib.collection.GribCdmIndex "\$@"
EOF
chmod +x ${PREFIX}/bin/ncj-panoply-gribcdmindex

cat <<EOF >${PREFIX}/bin/ncj-panoply-featurescan
#!/usr/bin/env bash
java -Xms512m -Xmx4g \$JAVA_OPTS -cp $PREFIX/lib/java/PanoplyJ/jars/Panoply.jar ucar.nc2.ft2.scan.FeatureScan "\$@"
EOF
chmod +x ${PREFIX}/bin/ncj-panoply-featurescan

cat <<EOF >${PREFIX}/bin/ncj-panoply-catalogcrawler
#!/usr/bin/env bash
java -Xms512m -Xmx4g \$JAVA_OPTS -cp $PREFIX/lib/java/PanoplyJ/jars/Panoply.jar thredds.client.catalog.tools.CatalogCrawler "\$@"
EOF
chmod +x ${PREFIX}/bin/ncj-panoply-catalogcrawler

# Windows batch files

cat <<EOF >${PREFIX}/bin/panoply.bat
@echo off
java -Xms512m -Xmx4g %JAVA_OPTS% -cp %CONDA_PREFIX%\\lib\\java\\PanoplyJ\\jars\\Panoply.jar gov.nasa.giss.panoply.Panoply   %*
EOF
unix2dos "${PREFIX}/bin/panoply.bat"

cat <<EOF >${PREFIX}/bin/panoplycl.bat
@echo off
java -Xms512m -Xmx4g %JAVA_OPTS% -cp %CONDA_PREFIX%\\lib\\java\\PanoplyJ\\jars\\Panoply.jar gov.nasa.giss.panoply.PanoplyCL %*
EOF
unix2dos "${PREFIX}/bin/panoplycl.bat"

# REM netcdf-java tools included with Panoply bundle
# REM echo java -Xms512m -Xmx4g %JAVA_OPTS% -cp %PREFIX%\lib\java\PanoplyJ\jars\Panoply.jar ucar.nc2.ui.ToolsUI                         %* > "%SCRIPTS%\ncj-toolsui.bat"

cat <<EOF >${PREFIX}/bin/ncj-nccopy.bat
@echo off
java -Xms512m -Xmx4g %JAVA_OPTS% -cp %CONDA_PREFIX%\\lib\\java\\PanoplyJ\\jars\\Panoply.jar ucar.nc2.write.Nccopy                       %*
EOF
unix2dos "${PREFIX}/bin/ncj-nccopy.bat"

cat <<EOF >${PREFIX}/bin/ncj-ncdump.bat
@echo off
java -Xms512m -Xmx4g %JAVA_OPTS% -cp %CONDA_PREFIX%\\lib\\java\\PanoplyJ\\jars\\Panoply.jar ucar.nc2.NCdumpW                            %*
EOF
unix2dos "${PREFIX}/bin/ncj-ncdump.bat"

cat <<EOF >${PREFIX}/bin/ncj-nccompare.bat
@echo off
java -Xms512m -Xmx4g %JAVA_OPTS% -cp %CONDA_PREFIX%\\lib\\java\\PanoplyJ\\jars\\Panoply.jar ucar.nc2.util.CompareNetcdf2                %*
EOF
unix2dos "${PREFIX}/bin/ncj-nccompare.bat"

cat <<EOF >${PREFIX}/bin/ncj-bufrspliter.bat
@echo off
java -Xms512m -Xmx4g %JAVA_OPTS% -cp %CONDA_PREFIX%\\lib\\java\\PanoplyJ\\jars\\Panoply.jar ucar.nc2.iosp.bufr.writer.BufrSplitter      %*
EOF
unix2dos "${PREFIX}/bin/ncj-bufrspliter.bat"

cat <<EOF >${PREFIX}/bin/ncj-cfpointwriter.bat
@echo off
java -Xms512m -Xmx4g %JAVA_OPTS% -cp %CONDA_PREFIX%\\lib\\java\\PanoplyJ\\jars\\Panoply.jar ucar.nc2.ft.point.writer.CFPointWriter      %*
EOF
unix2dos "${PREFIX}/bin/ncj-cfpointwriter.bat"

cat <<EOF >${PREFIX}/bin/ncj-gribcdmindex.bat
@echo off
java -Xms512m -Xmx4g %JAVA_OPTS% -cp %CONDA_PREFIX%\\lib\\java\\PanoplyJ\\jars\\Panoply.jar ucar.nc2.grib.collection.GribCdmIndex       %*
EOF
unix2dos "${PREFIX}/bin/ncj-gribcdmindex.bat"

cat <<EOF >${PREFIX}/bin/ncj-featurescan.bat
@echo off
java -Xms512m -Xmx4g %JAVA_OPTS% -cp %CONDA_PREFIX%\\lib\\java\\PanoplyJ\\jars\\Panoply.jar ucar.nc2.ft2.scan.FeatureScan               %*
EOF
unix2dos "${PREFIX}/bin/ncj-featurescan.bat"

cat <<EOF >${PREFIX}/bin/ncj-catalogcrawler.bat
@echo off
java -Xms512m -Xmx4g %JAVA_OPTS% -cp %CONDA_PREFIX%\\lib\\java\\PanoplyJ\\jars\\Panoply.jar thredds.client.catalog.tools.CatalogCrawler %*
EOF
unix2dos "${PREFIX}/bin/ncj-catalogcrawler.bat"
