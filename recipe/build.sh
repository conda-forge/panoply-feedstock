#!/usr/bin/env bash
set -exuo pipefail

# ---- Install payload (copy whole upstream bundle, as in your original) ----
mkdir -p "$PREFIX/lib/java/PanoplyJ" "$PREFIX/bin"
cp -r "$SRC_DIR/"* "$PREFIX/lib/java/PanoplyJ/"

# --------------------------------------------------------------------------
# Launchers
# --------------------------------------------------------------------------

# write_unix_launcher <file> <main-class>
write_unix_launcher() {
  local file="$1" main="$2"
  local out="${PREFIX}/bin/${file}"
  cat <<EOF > "${out}"
#!/usr/bin/env bash
set -euo pipefail
JAR="\${CONDA_PREFIX}/lib/java/PanoplyJ/jars/Panoply.jar"
exec java -Xms512m -Xmx4g \${JAVA_OPTS:-} -cp "\$JAR" ${main} "\$@"
EOF
  chmod +x "${out}"
}

# write_windows_launcher <file> <main-class>  (adds .bat)
write_windows_launcher() {
  local file="$1" main="$2"
  local out="${PREFIX}/bin/${file}.bat"
  cat <<EOF > "${out}"
@echo off
setlocal
set "JAR=%CONDA_PREFIX%\lib\java\PanoplyJ\jars\Panoply.jar"
java -Xms512m -Xmx4g %JAVA_OPTS% -cp "%JAR%" ${main} %*
exit /b %ERRORLEVEL%
EOF
  unix2dos "${out}"
}

# write_launcher <file> <main-class>  → emits Unix + Windows launchers
write_launcher() {
  write_unix_launcher "$1" "$2"
  write_windows_launcher "$1" "$2"
}

# --------------------------------------------------------------------------
# Create launchers
# --------------------------------------------------------------------------

# GUI + CLI
# Panoply Data Viewer
#
# Usage:
#   panoply [-log (TRACE|DEBUG|INFO|WARN|ERROR)] [-multi] [-path DATAPATH] [--] [DATAFILENAME [DATAFILENAME ...]]
#   panoply -script SCRIPTFILE [-log (TRACE|DEBUG|INFO|WARN|ERROR)] [-gui | -server] [-grib (strict|lenient)] [-enginelist] [-engine ENGINE] [-enginepath ENGINEPATH] [--]

write_launcher panoply                    gov.nasa.giss.panoply.Panoply
# Panoply Data Viewer (Command Line Interpreter)
#
# Usage:
#   panoplycl [-script SCRIPTFILE] [-log (TRACE|DEBUG|INFO|WARN|ERROR)] [-gui | -server] [-grib (strict|lenient)] [-enginelist] [-engine ENGINE] [-enginepath ENGINEPATH] [--]
write_launcher panoplycl                  gov.nasa.giss.panoply.PanoplyCL

# netCDF-Java tools (keep your original names)
write_launcher ncj-panoply-nccopy         ucar.nc2.write.Nccopy
write_launcher ncj-panoply-ncdump         ucar.nc2.NCdumpW
write_launcher ncj-panoply-nccompare      ucar.nc2.util.CompareNetcdf2
write_launcher ncj-panoply-bufrsplitter   ucar.nc2.iosp.bufr.writer.BufrSplitter
write_launcher ncj-panoply-cfpointwriter  ucar.nc2.ft.point.writer.CFPointWriter
write_launcher ncj-panoply-gribcdmindex   ucar.nc2.grib.collection.GribCdmIndex
write_launcher ncj-panoply-featurescan    ucar.nc2.ft2.scan.FeatureScan
write_launcher ncj-panoply-catalogcrawler thredds.client.catalog.tools.CatalogCrawler

# --------------------------------------------------------------------------
# Create Menu Entry
# --------------------------------------------------------------------------
install -Dm0644 "$RECIPE_DIR/menu/panoply.json"  "$PREFIX/share/menu/panoply.json"
install -Dm0644 "$RECIPE_DIR/menu/panoply.png"   "$PREFIX/share/menu/icons/panoply.png"
install -Dm0644 "$RECIPE_DIR/menu/panoply.ico"   "$PREFIX/share/menu/icons/panoply.ico"
install -Dm0644 "$RECIPE_DIR/menu/panoply.icns"  "$PREFIX/share/menu/icons/panoply.icns"

# Install the menu hook script
install -Dm0644 "$RECIPE_DIR/menu/panoply_menu.py"  "$PREFIX/share/menu/hooks/panoply_menu.py"

# --------------------------------------------------------------------------
# Include Windows hook scripts in the payload (so they run on install)
# --------------------------------------------------------------------------
install -Dm0644 "$RECIPE_DIR/post-link.bat"  "$PREFIX/Scripts/.${PKG_NAME}-post-link.bat"
install -Dm0644 "$RECIPE_DIR/pre-unlink.bat" "$PREFIX/Scripts/.${PKG_NAME}-pre-unlink.bat"
unix2dos "$PREFIX/Scripts/.${PKG_NAME}-post-link.bat"
unix2dos "$PREFIX/Scripts/.${PKG_NAME}-pre-unlink.bat"
